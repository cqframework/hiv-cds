library Screening

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
    1. Recommend Screening 3 months (High Risk - Implemented except DAST-10)
    2. Recommend Screening Annually (Moderate Risk - SOGI & Risk Factors)
    3. Recommend Screening Dont Order (Low/No Risk)
    4. Recommend Screening Custom Periods (3 months based on specific risk factor -- sexually active MSM w/ prep)
      // MSM / Pregnancy / CDC Recommendation (Already Implemented)

    // Test.Date duration from "Patient Encounter" > (Risk.period)

  High risk: Any of the factors we currently have

  Moderate risk: we also should use SO/GI, to figure out if the person is a men who has sex with men or a transgender person who has sex with men, which would make this people “moderate” risk, when there is nothing else elevating them to high risk. Moderate risk is when the person should be tested annually.

  No risk: Someone who is documented not sexually active.

  Low risk: Everybody else

  // - High Risk
    // CDC FACTORS (Already Exist)
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


  Snooze Options / Override:
    Accept - Place order
    Document Test - ACTION: Questionnaire to support documenting test
    Snooze - 1 month
    Snooze - 12 months
    Patient Declined - ACTION: Document patient preference

*/


define "Recommendation":
  if "Patient is a Sexually Active MSM who should be Screened Every 3 Months" then 'Three Month HIV Screening Recommended due to patient being a sexually active MSM who has been prescribed PrEP in the past.'
  else if "Patient is a Sexually Active MSM who should be Screened Annually" then 'Annual HIV Screening Recommended due to patient being a sexually active MSM without HIV and has had multiple sex partners.'
  else if "Patient is at First Prenatal Visit" then 'HIV Screening Recommended now due to patient being at first prenatal visit.'
  else if "Patient is High Risk in Third Trimester of Pregnancy" then 'HIV Screening Recommended due to patient being at high risk of HIV during third trimester of pregnancy.'
  else if "Patient is Seeking Treatment for an STD" then 'HIV Screening Recommended now due to patient interest.'
  else if not "Patient has had an HIV Screening" then 'HIV Screening Recommended once due to patient never having been tested.'
  else 'HIV Screening is not currently Recommended for this patient.'

/* Rational based on Recommendation Option (References to CDC Recommendations) */
define "Rationale":
  if "Patient is a Sexually Active MSM who should be Screened Every 3 Months" then 'For MSM who are prescribed preexposure prophylaxis, HIV testing every 3 months and immediate testing whenever signs and symptoms of acute HIV infection are reported is indicated.'
  else if "Patient is a Sexually Active MSM who should be Screened Annually" then 'Among young (aged 18--24 years) men who have sex with men (MSM) surveyed during 2004--2005 in five U.S. cities, 14% were infected with HIV; 79% of these HIV-infected MSM were unaware of their infection.'
  else if "Patient is at First Prenatal Visit" then 'To promote informed and timely therapeutic decisions, health-care providers should test women for HIV as early as possible during each pregnancy. Women who decline the test early in prenatal care should be encouraged to be tested at a subsequent visit.'
  else if "Patient is High Risk in Third Trimester of Pregnancy" then 'A second HIV test during the third trimester for women in settings with elevated HIV incidence (>17 cases per 100,000 person-years) is cost-effective and might result in substantial reductions in mother-to-child HIV transmission.'
  else if "Patient is Seeking Treatment for an STD" then 'All patients seeking treatment for STDs, including all patients attending STD clinics, should be screened routinely for HIV during each visit for a new complaint, regardless of whether the patient is known or suspected to have specific behavior risks for HIV infection.'
  else if not "Patient has had an HIV Screening" then 'CDC recommends that diagnostic HIV testing and opt-out HIV screening be a part of routine clinical care in all health-care settings while also preserving the patients option to decline HIV testing and ensuring a provider-patient relationship conducive to optimal clinical and preventive care.'
  else 'Patients should be informed orally or in writing that HIV testing will be performed unless they decline (opt-out screening). Oral or written information should include an explanation of HIV infection and the meanings of positive and negative test results, and the patient should be offered an opportunity to ask questions and to decline testing.
   With such notification, consent for HIV screening should be incorporated into the patients general informed consent for medical care on the same basis as are other screening or diagnostic tests; a separate consent form for HIV testing is not recommended.'

define "Indicator Status":
  if "Patient is a Sexually Active MSM who should be Screened Every 3 Months" then "Warning"
  else if "Patient is a Sexually Active MSM who should be Screened Annually" then "Warning"
  else if "Patient is at First Prenatal Visit" then "Info"
  else if "Patient is High Risk in Third Trimester of Pregnancy" then "Warning"
  else if "Patient is Seeking Treatment for an STD" then "Info"
  else if not "Patient has had an HIV Screening" then "Warning"
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
      HDE."Patient Encounter"
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
    HC.QualifiedMedicationRequests(HDE."Pre Exposure Prophylaxis Medication Prescriptions")
    union HC.QualifiedMedicationDispenses(HDE."Pre Exposure Prophylaxis Dispensed Medications")
    union HC.QualifiedObservations(HDE."Previous experience with PREP")
  ) PrEP


/* Determine Patient's Category (gender, pregnancy, MSM, sexual activity, etc) */
define "Patient is Male":
  if Patient.gender = 'male' then true else false

define "Patient is Female":
  if Patient.gender = 'female' then true else false

define "Patient is Pregnant":
  exists(
    (HC.QualifiedConditions(HDE."Pregnancy Conditions")) Pregnancy
      with "Patient Encounter" PatientEncounter
        such that FC.ToPrevalenceInterval(Pregnancy) overlaps PatientEncounter.period
  )

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


/* Determine Patient's Risk Level (High Risk, Normal Risk, None, etc) */
// Predominantly based off elements built from the risk-factors questionnaire
// RISKS: STIs, Injection Drug Use, Sex partner has HIV, Sex Exchanged for Drugs/Money, More than 1 Partner since previous screening (for themselves or their partners)

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
  or "Patient is at High Risk Due to Sexual Partner having HIV"
  or "Patient is at High Risk Due to exchanging sex for money and/or drugs"
  or "Patient is at High Risk Due to Multiple Sex Partners since last screening"


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
  "Sexually Active MSM Patient"
  and "Patient is at High Risk Due to Multiple Sex Partners since last screening"

define "Patient is a Sexually Active MSM who should be Screened Annually":
  "Patient is a Sexually Active MSM without HIV"
  and "Patient is a Sexually Active MSM with Multiple Sex Partners"
  and "Over a Year has Past Since Previous HIV Screening"

define "Patient is a Sexually Active MSM who should be Screened Every 3 Months":
  "Sexually Active MSM Patient"
  and "Patient has Received Pre Exposure Prophylaxis"
  and "Over 3 Months has Past Since Previous HIV Screening"

/* Drug Abuse Screning Test (DAST-10) Questionnaire */
// Score acquired either by tallying codes for DAST-10 questions or by the value field of DAST-10 Questionnaire or result codes
// High Risk: >= 6
// Normal Risk: 3 - 5
// Low Risk: 1 - 2
// No Risk: 0

define "DAST 10 Result Score":
  (Last(
    (HDE."Drug Abuse" screening
      where screening.value is not null) notNullScreening
      sort by start of FC.ToInterval(effective))
  ) latestScreening
  return latestScreening.value as integer

define "All DAST 10 Questions":
  HDE."DAST 10 Question 1"
  union HDE."DAST 10 Question 2"
  union HDE."DAST 10 Question 3"
  union HDE."DAST 10 Question 4"
  union HDE."DAST 10 Question 5"
  union HDE."DAST 10 Question 6"
  union HDE."DAST 10 Question 7"
  union HDE."DAST 10 Question 8"
  union HDE."DAST 10 Question 9"
  union HDE."DAST 10 Question 10"

define "Latest DAST 10 Questions Date":
  (Last(
    ("All DAST 10 Questions") questions
    sort by start of FC.ToInterval(effective))
  ) latestQuestion
  return date from start of FC.ToInterval(latestQuestion.effective)

define "DAST 10 Questions Score":
  Count(
    "All DAST 10 Questions" question
      where start of FC.ToInterval(question.effective) same day as "Latest DAST 10 Questions Date"
  )

define "Latest DAST 10 Screening Date":
  (Last(
    (HDE."Drug Abuse"
    union "All DAST 10 Questions") results
    sort by start of FC.ToInterval(effective))
  ) latestScreening
  return date from start of FC.ToInterval(latestScreening.effective)

define "Patient Has High Degree Of Problems Related to Drug Abuse":
  ("DAST 10 Result Score" is not null and "DAST 10 Result Score" in "DAST 10 High Risk Score")
  or
  ("DAST 10 Questions Score" is not null and "DAST 10 Questions Score" in "DAST 10 High Risk Score")

define "Patient Has Moderate Degree Of Problems Related to Drug Abuse":
  ("DAST 10 Result Score" is not null and "DAST 10 Result Score" in "DAST 10 Moderate Risk Score")
  or
  ("DAST 10 Questions Score" is not null and "DAST 10 Questions Score" in "DAST 10 Moderate Risk Score")

define "Patient Has Low Degree Of Problems Related to Drug Abuse":
  ("DAST 10 Result Score" is not null and "DAST 10 Result Score" in "DAST 10 Low Risk Score")
  or
  ("DAST 10 Questions Score" is not null and "DAST 10 Questions Score" in "DAST 10 Low Risk Score")

define "Patient Has No Problems Related to Drug Abuse":
  ("DAST 10 Result Score" is not null and "DAST 10 Result Score" in "DAST 10 No Risk Score")
  or
  ("DAST 10 Result Score" is not null and "DAST 10 Questions Score" is null)

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