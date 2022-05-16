library HIVScreening

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include NACHCCommon called NC
include HIVCommon called HC
include HIVConcepts called Cx

include HIVDataElements called HDE

context Patient

define "Info":
  'info'

define "Warning":
  'warning'

define "Critical":
  'critical'

define "Errors":
  null

define "Patient Name":
  First(Patient.name.given)
   + ' ' +
  First(Patient.name.family)


/* Recommendation Criteria - HIV Screening  */
define "Meets Inclusion Criteria":
 "Patient is between 13 and 64 years old"
 or "Patient is Seeking Treatment for an STD"

define "Meets Exclusion Criteria":
  "Active Diagnosis of HIV During Patient Visit" is not null

define "In Population":
  "Meets Inclusion Criteria"
  and not "Meets Exclusion Criteria"

/* OPTIONS:

    1. Recommend Screening 3 months (High Risk - CDC Risk Factors)
    2. Recommend Screening Annually (Moderate Risk - SOGI Risk Factors)
    3. No Recommendation Screening (No Risk) / Low Risk
    4. Recommend Screening Custom Periods (3 months based on specific risk factor -- sexually active MSM w/ prep, etc)
      // MSM / Pregnancy / CDC Recommendation

  // - High Risk
    // CDC RISK FACTORS
    // Drug Abuse (DAST-10)

  // - Medium Risk
    // SOGI ELEMENTS

  // - No Risk
    // Documented not Sexually Active (Risk Factors Questionnaire DE 13 / 14)

  // - Low Risk
    // DEFAULT

  // TEST ORDER:
    Needs ActivityDefinition in the PlanDefinition.
    Need to be able to specify what they are ordering in the configuration.
    ServiceRequest using Data Element Ordered Codes


  // TODO:
  Snooze Options / Override:
    Accept - Place order
    Document Test - ACTION: Questionnaire to support documenting test
    Snooze - 1 month
    Snooze - 12 months
    Patient Declined - ACTION: Document patient preference

*/

/*

ORDER:
  1. Never TESTED
  2. CDC Edge Cases (MSM & Pregnancy)
  3.Risk Scoring
    a. High Risk
    b. Moderate Risk
    c. Low Risk / No Risk

*/

// NEVER TESTED
define "Never Tested Condition":
  "In Population"
  and not "Patient has had an HIV Screening"

define "Never Tested Recommendation":
  'HIV Screening Recommended due to patient never having been tested.'

define "Never Tested Rationale":
  'CDC recommends that diagnostic HIV testing and opt-out HIV screening be a part of routine clinical care in all health-care settings while also preserving the patients option to decline HIV testing and ensuring a provider-patient relationship conducive to optimal clinical and preventive care.'

define "Never Tested Indicator":
  "Info"


/* CDC EDGE CASES */
// MSM
define "MSM Condition":
  "In Population"
  and (
    "Patient is a Sexually Active MSM who should be Screened Every 3 Months"
    or "Patient is a Sexually Active MSM who should be Screened Annually"
  )

define "MSM Recommendation":
  if "Patient is a Sexually Active MSM who should be Screened Every 3 Months" then
    'Three Month HIV Screening Recommended due to patient being a sexually active MSM who has been prescribed PrEP in the past.'
  else if "Patient is a Sexually Active MSM who should be Screened Annually" then
    'Annual HIV Screening Recommended due to patient being a sexually active MSM without HIV and has had multiple sex partners.'
  else 'HIV Screening Not Recommended at this time. It has been ' + ToString("Amount of Days Since Previous HIV Screening") + ' days since last HIV Screening.'

define "MSM Rationale":
  'Among young (aged 18--24 years) men who have sex with men (MSM) surveyed during 2004--2005 in five U.S. cities, 14% were infected with HIV; 79% of these HIV-infected MSM were unaware of their infection.'

define "MSM Indicator":
  if "Patient is a Sexually Active MSM who should be Screened Every 3 Months" then "Warning"
  else "Warning"


// PREGNANCY
define "Pregnant Condition":
  "In Population"
  and (
    "Patient is at First Prenatal Visit"
    or "Patient is High Risk in Third Trimester of Pregnancy"
  )

define "Pregnant Recommendation":
  if "Patient is at First Prenatal Visit" and "Over 3 Months has Past Since Previous HIV Screening" then
    'HIV Screening Recommended now due to patient being at first prenatal visit.'
  else if "Patient is High Risk in Third Trimester of Pregnancy" and "Over 3 Months has Past Since Previous HIV Screening" then
    'HIV Screening Recommended due to patient being at high risk of HIV during third trimester of pregnancy.'
  else 'HIV Screening Not Recommended at this time. It has been ' + ToString("Amount of Days Since Previous HIV Screening") + ' days since last HIV Screening.'

define "Pregnant Rationale":
  if "Patient is at First Prenatal Visit" then
    'To promote informed and timely therapeutic decisions, health-care providers should test women for HIV as early as possible during each pregnancy. Women who decline the test early in prenatal care should be encouraged to be tested at a subsequent visit.'
  else if "Patient is High Risk in Third Trimester of Pregnancy" then
    'A second HIV test during the third trimester for women in settings with elevated HIV incidence (>17 cases per 100,000 person-years) is cost-effective and might result in substantial reductions in mother-to-child HIV transmission.'
  else ''

define "Pregnant Indicator":
  if "Patient is at First Prenatal Visit" then "Info"
  else if "Patient is High Risk in Third Trimester of Pregnancy" then "Critical"
  else "Info"


// SEEKING TREATMENT
define "Seeking STD Treatment Condition":
  "In Population"
  and "Patient is Seeking Treatment for an STD"

define "Seeking STD Treatment Recommendation":
  if "Over 3 Months has Past Since Previous HIV Screening" then 'HIV Screening Recommended now due to patient interest.'
  else 'HIV Screening Not Recommended at this time. It has been ' + ToString("Amount of Days Since Previous HIV Screening") + ' days since last HIV Screening.'

define "Seeking STD Treatment Rationale":
  'All patients seeking treatment for STDs, including all patients attending STD clinics, should be screened routinely for HIV during each visit for a new complaint, regardless of whether the patient is known or suspected to have specific behavior risks for HIV infection.'

define "Seeking STD Treatment Indicator":
  "Info"


/* RISK Level Actions */
define "Risk Level Condition":
  "In Population"
  and (
    "Never Tested Condition" is false
    and "MSM Condition" is false
    and "Pregnant Condition" is false
    and "Seeking STD Treatment Condition" is false
  )

define "Risk Level Recommendation":
  if "Patient is at High Risk for HIV" and "Over 3 Months has Past Since Previous HIV Screening" then 'HIV Screening Recommended due to patient being at High Risk for HIV and over three months have passed since previous screening.'
  else if "Patient is at Moderate Risk for HIV" and "Over a Year has Past Since Previous HIV Screening" then 'HIV Screening Recommended due to patient being at Moderate Risk for HIV and over a Year has passed since previous screening.'
  else if "Patient is at No Risk for HIV" then 'HIV Screening Not Recommended due to patient being at No Risk for HIV.'
  else if "Patient is at Low Risk for HIV" then 'HIV Screening Not Recommended due to patient being at Low Risk for HIV.'
  else 'HIV Screening Not Recommended at this time. It has been ' + ToString("Amount of Days Since Previous HIV Screening") + ' days since last HIV Screening.'

/* Risk Level Rational based on Recommendation Option (References to CDC Recommendations) */
define "Risk Level Rationale":
  if "Patient is at High Risk for HIV" then 'Health-care providers should subsequently test all persons likely to be at high risk for HIV at least every 3 months. Persons likely to be at high risk include persons with problems related to drug abuse, injection-drug users and their sex partners, persons who exchange sex for money or drugs, sex partners of HIV-infected persons, and MSM or heterosexual persons who themselves or whose sex partners have had more than one sex partner since their most recent HIV test.'
  else if "Patient is at Moderate Risk for HIV" then 'Health-care providers should subsequently test all persons likely to be at moderate risk for HIV at least annually. Persons likely to be at moderate risk include MSM, Transgender Persons, and Gay or Bisexual Men who are sexually active and have sex with other men.'
  else if "Patient is at No Risk for HIV" then 'The Task Force made no recommendation for or against routinely screening asymptomatic adults and adolescents with no identifiable risk factors for HIV. The Task Force concluded that such screening would detect additional patients with HIV, but the overall number would be limited, and the potential benefits did not clearly outweigh the burden on primary care practices or the potential harms of a general HIV screening program.'
  else 'In low prevalence settings, in which the majority of clients are at minimal risk, targeted HIV testing on the basis of risk screening was considered more feasible for identifying limited numbers of HIV-infected persons. The Task Force concluded that such screening would detect additional patients with HIV, but the overall number would be limited, and the potential benefits did not clearly outweigh the burden on primary care practices or the potential harms of a general HIV screening program.'

define "Risk Level Indicator Status":
  if "Patient is at High Risk for HIV" then "Critical"
  else if "Patient is at Moderate Risk for HIV" then "Warning"
  else if "Patient is at No Risk for HIV" then "Info"
  else "Info"

define "Exclusion Reason":
  if "Meets Exclusion Criteria" then
    (
      'Patient was excluded from HIV Screening '
      + (
          if not "Patient is between 13 and 64 years old" then 'due to not being between the ages of 13 and 64.'
          else if "Active Diagnosis of HIV During Patient Visit" is not null then 'due to the patient already having been diagnosed with HIV.'
          else ''
        )
    )
  else ''


/* HIV Screening Workflow */
// Patient Visit Occurred
define "Patient Encounter":
  Last(
    (HC.QualifiedEncounters(
      HDE."Encounter Type"
      union HDE."Pregnancy Encounters"
      union HDE."Third Trimester Encounters"
    )) PatientEncounter
    sort by end of period)


/* Determine Patient Characteristics and Testing Criteria */
define "Patient is between 13 and 64 years old":
  AgeInYearsAt(end of "Patient Encounter".period) >= 13
  and AgeInYearsAt(end of "Patient Encounter".period) <= 64

define "Active Diagnosis of HIV During Patient Visit":
  (Last(
    (HC.QualifiedConditions(HDE."HIV Diagnosis")) HIVDiagnosis
      sort by end of FC.ToInterval(abatement)
  )) HIVDiagnosis
    with "Patient Encounter" PatientEncounter
      such that FC.ToPrevalenceInterval(HIVDiagnosis) overlaps PatientEncounter.period

define "HIV Screening Test":
  (
    HC.QualifiedObservations(HDE."HIV Test")
    union HC.QualifiedObservations(HDE."Previous HIV Screening")
  ) HIVScreening
    with "Patient Encounter" PatientEncounter
      such that FC.ToInterval(HIVScreening.effective) before PatientEncounter.period

define "Patient has had an HIV Screening":
  exists("HIV Screening Test")

define "Previous HIV Screening Test":
  from
  (
    Last("HIV Screening Test" HIVTest
      sort by end of FC.ToInterval(effective))
  ) MostRecentHIVTest,
  "Patient Encounter" PatientEncounter
    where FC.ToInterval(MostRecentHIVTest.effective) before PatientEncounter.period

define "Amount of Days Since Previous HIV Screening":
  "Previous HIV Screening Test" HIVTest
    return duration in days between end of FC.ToInterval(HIVTest.MostRecentHIVTest.effective) and end of HIVTest.PatientEncounter.period

define "Over a Year has Past Since Previous HIV Screening":
  "Previous HIV Screening Test" HIVTest
    return (duration in years between end of FC.ToInterval(HIVTest.MostRecentHIVTest.effective) and end of HIVTest.PatientEncounter.period) >= 1

define "Over 3 Months has Past Since Previous HIV Screening":
  "Previous HIV Screening Test" HIVTest
    return (duration in months between end of FC.ToInterval(HIVTest.MostRecentHIVTest.effective) and end of HIVTest.PatientEncounter.period) >= 3

define "Patient has Received Pre Exposure Prophylaxis":
  exists(
    HC.QualifiedMedicationRequests(HDE."Prep Medication Prescriptions")
    union HC.QualifiedMedicationDispenses(HDE."Prep Dispensed Medications")
    union HC.QualifiedObservations(HDE."Previous experience with PREP")
  ) PrEP


/* Determine Patient's Category (gender, pregnancy, MSM, sexual activity, etc) */
define "Patient is Male":
  if Patient.gender = 'male' then true else false

define "Patient is Female":
  if Patient.gender = 'female' then true else false

define "Patient is Transgender":
    HDE."Gender Identity" in Cx."Transgender"

define "Patient is Gay or Bisexual":
      HDE."Sexual Orientation" in Cx."Gay Or Bisexual"

define "Patient is Pregnant":
  exists(
    (HC.QualifiedConditions(HDE."Pregnancy Conditions")) Pregnancy
      with "Patient Encounter" PatientEncounter
        such that FC.ToPrevalenceInterval(Pregnancy) overlaps PatientEncounter.period
  )


/* Determine Patient's Risk Level (High Risk, Normal Risk, No Risk, Low Risk) */
// Predominantly based off elements built from the risk-factors questionnaire
// RISKS: STIs, Injection Drug Use, Sex partner has HIV, Sex Exchanged for Drugs/Money, More than 1 Partner since previous screening (for themselves or their partners), Drug abuse

/* 1. Recommend Screening 3 months (High Risk - CDC Risk Factors)
    2. Recommend Screening Annually (Moderate Risk - SOGI Risk Factors)
    3. No Recommendation Screening (No Risk) / Low Risk
    4. Recommend Screening Custom Periods (3 months based on specific risk factor -- sexually active MSM w/ prep, etc)
      // MSM / Pregnancy / CDC Recommendation
*/

/* HIGH RISK */
// High Risk -- Other STIs
define "Active Diagnosis of HCV During Patient Visit":
  (
    (Last(
      (HC.QualifiedConditions(HDE."Hepatitis C Diagnosis")) HCVDiagnosis
        sort by end of FC.ToInterval(abatement))
    ) HCVDiagnosis
    with "Patient Encounter" PatientEncounter
      such that FC.ToPrevalenceInterval(HCVDiagnosis) overlaps PatientEncounter.period
  ) is not null
  or exists(
    (HC.QualifiedObservations(HDE."Patient Diagnosed with HCV")) HCVObserved
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(HCVObserved.effective) overlaps PatientEncounter.period
  )

define "Active Diagnosis of Syphilis During Patient Visit":
  (
    (Last(
      (HC.QualifiedConditions(HDE."Syphilis Diagnosis")) SyphilisDiagnosis
        sort by end of FC.ToInterval(abatement))
    ) SyphilisDiagnosis
    with "Patient Encounter" PatientEncounter
      such that FC.ToPrevalenceInterval(SyphilisDiagnosis) overlaps PatientEncounter.period
  ) is not null
  or exists(
    (HC.QualifiedObservations(HDE."Patient Diagnosed with Syphilis")) SyphilisObserved
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(SyphilisObserved.effective) overlaps PatientEncounter.period
  )

define "Active Diagnosis of Gonorrhea During Patient Visit":
  (
    (Last(
      (HC.QualifiedConditions(HDE."Gonorrhea Diagnosis")) GonorrheaDiagnosis
        sort by end of FC.ToInterval(abatement))
    ) GonorrheaDiagnosis
    with "Patient Encounter" PatientEncounter
      such that FC.ToPrevalenceInterval(GonorrheaDiagnosis) overlaps PatientEncounter.period
  ) is not null
  or exists(
    (HC.QualifiedObservations(HDE."Patient Diagnosed with Gonorrhea")) GonorrheaObserved
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(GonorrheaObserved.effective) overlaps PatientEncounter.period
  )

define "Active Diagnosis of Chlamydia During Patient Visit":
  (
    (Last(
      (HC.QualifiedConditions(HDE."Chlamydia Diagnosis")) ChlamydiaDiagnosis
        sort by end of FC.ToInterval(abatement))
    ) ChlamydiaDiagnosis
    with "Patient Encounter" PatientEncounter
      such that FC.ToPrevalenceInterval(ChlamydiaDiagnosis) overlaps PatientEncounter.period
  ) is not null
  or exists(
    (HC.QualifiedObservations(HDE."Patient Diagnosed with Chlamydia")) ChlamydiaObserved
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(ChlamydiaObserved.effective) overlaps PatientEncounter.period
  )

define "Patient is at High Risk Due to a STD":
  "Active Diagnosis of HCV During Patient Visit"
  or "Active Diagnosis of Syphilis During Patient Visit"
  or "Active Diagnosis of Gonorrhea During Patient Visit"
  or "Active Diagnosis of Chlamydia During Patient Visit"

// High Risk -- Injection Drug Use
// NOTE: What is considered an Active Time Period for Injection Drug Use?
define "Patient is at High Risk Due to Injection Drug Use":
  (
    (Last(
      (
        HC.QualifiedProcedures(HDE."Drug Rehabilitation")
        union HC.QualifiedObservations(HDE."Injection Findings")
        union HC.QualifiedConditions(HDE."Injection Drug Use Diagnosis")
        union HC.QualifiedMedicationStatements(HDE."Injection Drug Use")
        union HC.QualifiedObservations(HDE."Patient has used Injection Drugs")
      ) InjectionDrugUse
          return Tuple {
            resource: InjectionDrugUse,
            IDUTiming: Coalesce(
              end of FC.ToInterval(InjectionDrugUse.performed), end of FC.ToInterval(InjectionDrugUse.effective), end of FC.ToPrevalenceInterval(InjectionDrugUse)
            ) } sort by IDUTiming).resource
    ) InjectionDrugUse
    with "Patient Encounter" PatientEncounter
      such that Coalesce(FC.ToInterval(InjectionDrugUse.performed), FC.ToInterval(InjectionDrugUse.effective), FC.ToPrevalenceInterval(InjectionDrugUse)) overlaps PatientEncounter.period
  ) is not null

//High Risk -- Drug Abuse
define "Patient is at High Risk Due to Drug Abuse":
  "Patient Has High Degree Of Problems Related To Drug Abuse"

// High Risk -- Partner with HIV
define "Patient is at High Risk Due to Sexual Partner having HIV":
  exists(
    (HC.QualifiedObservations(HDE."Sexual Activity - Partners HIV History")) HIVPartnerHistory
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(HIVPartnerHistory.effective) overlaps PatientEncounter.period
  )

// High Risk -- Sex Exchanged for Drugs/Money
define "Patient is at High Risk Due to exchanging sex for money and/or drugs":
  exists(
    (HC.QualifiedObservations(HDE."Sexual Activity - Exchanged for Sex")) SexExchanged
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(SexExchanged.effective) overlaps PatientEncounter.period
  )

// High Risk -- Multiple Sex Partners since previous HIV Screening for Patient or their partner
define "Patient is at High Risk Due to Multiple Sex Partners since last screening":
  (
    (Last(
      (
        HC.QualifiedObservations(HDE."HIV Test")
        union HC.QualifiedObservations(HDE."Previous HIV Screening")
      ) HIVScreening
      sort by end of FC.ToInterval(effective)
  )) HIVScreening
    with (
      HC.QualifiedObservations(HDE."Sexual Activity - Number of Partners")
      union HC.QualifiedObservations(HDE."Sexual Activity - Partners Number of Partners")
    ) NumberOfPartners
      such that FC.ToInterval(HIVScreening.effective) before FC.ToInterval(NumberOfPartners.effective)
  ) is not null

define "Patient is at High Risk for HIV":
  "Patient is at High Risk Due to a STD"
  or "Patient is at High Risk Due to Injection Drug Use"
  or "Patient is at High Risk Due to Drug Abuse"
  or "Patient is at High Risk Due to Sexual Partner having HIV"
  or "Patient is at High Risk Due to exchanging sex for money and/or drugs"
  or "Patient is at High Risk Due to Multiple Sex Partners since last screening"


/* MODERATE RISK */
// Sexually active MSM, Transgender patient sexually active with men, Gay and bisexual men unless documented not sexually active

// Moderate Risk -- Any sexually active MSM
define "Sexually Active MSM Patient":
  if "Patient is Male" then
    (
      exists(
        (HC.QualifiedObservations(HDE."Sexual Activity - Men")) MSMObserved
          with "Patient Encounter" PatientEncounter
            such that FC.ToInterval(MSMObserved.effective) overlaps PatientEncounter.period
      )
    )
  else false

// Moderate Risk -- Transgender patients sexually active with men
define "Transgender Patient Sexually Active With Men":
  if "Patient is Transgender" then
    (
      exists(
        (HC.QualifiedObservations(HDE."Sexual Activity - Men")) MSMObserved
          with "Patient Encounter" PatientEncounter
            such that FC.ToInterval(MSMObserved.effective) overlaps PatientEncounter.period
      )
    )
  else false

// Moderate Risk -- All gay or bisexual men unless documented not sexually active
define "Male, Gay, or Bisexual Patient Not Documented Sexually Inactive":
  "Patient is Male" and "Patient is Gay or Bisexual" and not "Patient is not Sexually Active"

define "Patient is at Moderate Risk for HIV":
  "Sexually Active MSM Patient"
  or "Transgender Patient Sexually Active With Men"
  or "Male, Gay, or Bisexual Patient Not Documented Sexually Inactive"


/* No Risk */
// Not Sexually Active
define "Patient is not Sexually Active":
  (
    (
      Last
      (
        (
          HC.QualifiedObservations(HDE."Sexual Activity - Past Year")
          union HC.QualifiedObservations(HDE."Sexual Activity - History")
          union HC.QualifiedObservations(HDE."Sexual Activity - Men")
          union HC.QualifiedObservations(HDE."Sexual Activity - Women")

        ) SexualHistory
            where Coalesce(Lower(SexualHistory.value as string) in { 'no' }, SexualHistory.value as boolean = false)
              sort by Coalesce(effective, issued)
      )
    ) SexualHistory
      with "Patient Encounter" Encounter
        such that Coalesce(FC.ToInterval(SexualHistory.effective), FC.ToInterval(SexualHistory.issued)) during Encounter.period
  ) is not null

define "Patient is at No Risk for HIV":
  "Patient is not Sexually Active"


/* LOW RISK */
// Not sexually active
define "Patient is at Low Risk for HIV":
  not "Patient is at High Risk for HIV"
  and not "Patient is at Moderate Risk for HIV"
  and not "Patient is at No Risk for HIV"


/* Women & Men Workflow */
// All Women and Men between the ages 13-64 and/or those who are seeking treatment for an STD
define "Patient is Seeking Treatment for an STD":
  exists(
    (HC.QualifiedObservations(HDE."Seeking STD Treatment")) SeekingTreatment
      with "Patient Encounter" PatientEncounter
        such that FC.ToInterval(SeekingTreatment.effective) overlaps PatientEncounter.period
  )


/* Pregnant Women Workflow */
// All Women should be screened at Initial Prenatal Visit
// All women should be retested in the third trimester if they're high risk
// NOTE: This definition implementation is naive and does not take into effect multiple pregnancies. Consider use of an EpisodeOfCare resource.
define "Patient is at First Prenatal Visit":
  (
    (First(
      (HC.QualifiedEncounters(HDE."Pregnancy Encounters")) PregnancyEncounter
      sort by end of period
    )) PregnancyEncounter
      with "Patient Encounter" PatientEncounter
        such that PregnancyEncounter.id = PatientEncounter.id
  ) is not null

define "Patient is in Third Trimester of Pregnancy":
  (
    (Last(
      (HC.QualifiedEncounters(HDE."Third Trimester Encounters")) ThirdTrimesterEncounter
    sort by end of period
    )) ThirdTrimesterEncounter
      with "Patient Encounter" PatientEncounter
        such that ThirdTrimesterEncounter.id = PatientEncounter.id
  ) is not null

define "Patient is High Risk in Third Trimester of Pregnancy":
  "Patient is at High Risk for HIV"
  and "Patient is in Third Trimester of Pregnancy"


/* MSM (Men who have sex with men) */
// At Least Annually for sexually active MSM if HIV status isn't positive and if patient/partner has had more than 1 partner since previous screening
// For sexually active MSM Tests should occur every 3 months if the patient has experienced prep
define "Patient is a Sexually Active MSM without HIV":
  "Sexually Active MSM Patient"
  and "Active Diagnosis of HIV During Patient Visit" is null

define "Patient is a Sexually Active MSM with Multiple Sex Partners":
  "Patient is a Sexually Active MSM without HIV"
  and "Patient is at High Risk Due to Multiple Sex Partners since last screening"

define "Patient is a Sexually Active MSM who should be Screened Annually":
  "Patient is a Sexually Active MSM with Multiple Sex Partners"
  and "Over a Year has Past Since Previous HIV Screening"

define "Patient is a Sexually Active MSM who should be Screened Every 3 Months":
  "Patient is a Sexually Active MSM without HIV"
  and "Patient has Received Pre Exposure Prophylaxis"
  and "Over 3 Months has Past Since Previous HIV Screening"


/* Drug Abuse Screning Test (DAST-10) Questionnaire */
// Score acquired either by tallying codes for DAST-10 questions or by the value field of DAST-10 Questionnaire or result codes
// High Risk: >= 6
// Normal Risk: 3 - 5
// Low Risk: 1 - 2
// No Risk: 0

define "DAST 10 Result Score":
  NC.MostRecent(HDE."DAST 10 Score").value as integer

define "All DAST 10 Questions":
  {
    NC.MostRecent(HDE."DAST 10 Question 1"),
    NC.MostRecent(HDE."DAST 10 Question 2"),
    NC.MostRecent(HDE."DAST 10 Question 3"),
    NC.MostRecent(HDE."DAST 10 Question 4"),
    NC.MostRecent(HDE."DAST 10 Question 5"),
    NC.MostRecent(HDE."DAST 10 Question 6"),
    NC.MostRecent(HDE."DAST 10 Question 7"),
    NC.MostRecent(HDE."DAST 10 Question 8"),
    NC.MostRecent(HDE."DAST 10 Question 9"),
    NC.MostRecent(HDE."DAST 10 Question 10")
  }

define "Latest DAST 10 Questions Date":
  date from start of FC.ToInterval(NC.MostRecent("All DAST 10 Questions").effective)

define "DAST 10 Questions Score":
  Count(
    "All DAST 10 Questions" question
      where question.value as boolean is true
  )

define "Latest DAST 10 Screening Date":
  date from start of FC.ToInterval(NC.MostRecent(
    HDE."DAST 10 Score"
      union "All DAST 10 Questions"
  ).effective)

//"Patient is at High Risk Due to a STD"
define "Patient Has High Degree Of Problems Related To Drug Abuse":
  ("DAST 10 Result Score" in "DAST 10 High Risk Score")
  or
  ("DAST 10 Questions Score" in "DAST 10 High Risk Score")

define "Patient Has Moderate Degree Of Problems Related To Drug Abuse":
  ("DAST 10 Result Score" in "DAST 10 Moderate Risk Score")
  or
  ("DAST 10 Questions Score" in "DAST 10 Moderate Risk Score")

define "Patient Has Low Degree Of Problems Related To Drug Abuse":
  ("DAST 10 Result Score" in "DAST 10 Low Risk Score")
  or
  ("DAST 10 Questions Score" in "DAST 10 Low Risk Score")

define "Patient Has Low To Moderate Degree Of Problems Related To Drug Abuse":
  "Patient Has Low Degree Of Problems Related To Drug Abuse"
  or
  "Patient Has Moderate Degree Of Problems Related To Drug Abuse"

define "Patient Has No Problems Related To Drug Abuse":
  ("DAST 10 Result Score" in "DAST 10 No Risk Score")
  or
  ("DAST 10 Questions Score" is null)

define "Patient Not Screened For Drug Abuse Or Screening Expired":
  ("Latest DAST 10 Screening Date" is null)
  or
  (difference in years between "Latest DAST 10 Screening Date" and Today() >= 1)

define "DAST 10 High Risk Score":
  Interval[6,10]

define "DAST 10 Moderate Risk Score":
  Interval[3,5]

define "DAST 10 Low Risk Score":
  Interval[1,2]

define "DAST 10 No Risk Score":
  Interval[0,0]
