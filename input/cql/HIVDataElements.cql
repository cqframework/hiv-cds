library HIVDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include NACHCCommon called NC
include HIVCommon called HC
include HIVConcepts called Cx

context Patient

/*
  @dataElement: NACHC.A0.DE48 Sexual Orientation
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Sexual Orientation Elements
*/
define "Sexual Orientation":
  [Patient] P
    return HC.GetSexualOrientation(P)

/*
  @dataElement: NACHC.A0.DE55 Gender Identity
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Gender Identity Elements
*/
define "Gender Identity":
  [Patient] P
    return HC.GetGenderIdentity(P)

/*
  @dataElement: NACHC.A0.DE1 Patient Encounter
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Patient Encounters
*/
define "Patient Encounter":
  [Encounter: Cx."Patient Encounter Choices"]

/*
  @dataElement: NACHC.A0.DE63 DAST 10 Questionnaire
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with DAST-10 Questionnaire Elements
*/
define "DAST 10 Questionnaire":
  [Observation: Cx."DAST 10 Questionnaire Choices"]

/*
  @dataElement: NACHC.A1.DE1 HIV Diagnosis
  @activity: NACHC.A1 HIV
  @description: Concepts Associated with HIV Diagnosis
*/
define "HIV Diagnosis":
  [Condition: Cx."HIV infection as a condition Choices"]

/*
  @dataElement: NACHC.A2.DE1 HIV Test
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with HIV Testing
*/
define "HIV Test":
  [Observation: Cx."HIV Test"] HIVTest
    where HIVTest.value as CodeableConcept in Cx."HIV Test Choices Grouper"

/*
  @dataElement: NACHC.A2.DE216 HIV Test Ordered
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with Ordering an HIV Test
*/
define "HIV Test Ordered":
  [ServiceRequest: Cx."HIV Test Ordered Choices"]

/*
  @dataElement: NACHC.B1.DE1 Hepatitis C Diagnosis
  @activity: NACHC.B1 HCV
  @description: Concepts Associated with HCV Diagnosis
*/
define "Hepatitis C Diagnosis":
  [Condition: Cx."Hepatitis C Diagnosis Choices Grouper"]

/*
  @dataElement: NACHC.B2.DE1 Hepatitis C Test
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Testing
*/
define "Hepatitis C Test":
  [Observation: Cx."Hepatitis C Test"] HepCTest
    where HepCTest.value as CodeableConcept in Cx."Hepatitis C Test Choices Grouper"

/*
  @dataElement: NACHC.B2.DE112 Hepatitis C Procedures
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Procedures
*/
define "Hepatitis C Procedures":
  [Procedure: Cx."Hepatitis C Procedures Choices"]

/*
  @dataElement: NACHC.C1.DE1 Syphilis Diagnosis
  @activity: NACHC.C1 Syphilis
  @description: Concepts Associated with Syphilis Diagnosis
*/
define "Syphilis Diagnosis":
  [Condition: Cx."Syphilis Diagnosis Choices Grouper"]

/*
  @dataElement: NACHC.C2.DE1 Syphilis Test
  @activity: NACHC.C2 Syphilis test
  @description: Concepts Associated with Syphilis Testing
*/
define "Syphilis Test":
  [Observation: Cx."Syphilis Test"] SyphTest
    where SyphTest.value as CodeableConcept in Cx."Syphilis Test Choices Grouper"

/*
  @dataElement: NACHC.D1.DE1 Gonorrhea Diagnosis
  @activity: NACHC.D1 Gonorrhea
  @description: Concepts Associated with Gonorrhea Diagnosis
*/
define "Gonorrhea Diagnosis":
  [Condition: Cx."Gonorrhea Diagnosis Choices Grouper"]

/*
  @dataElement: NACHC.D2.DE1 Gonorrhea Test
  @activity: NACHC.D2 Gonorrhea test
  @description: Concepts Associated with Gonorrhea Testing
*/
define "Gonorrhea Test":
  [Observation: Cx."Gonorrhea Test"] GonoTest
    where GonoTest.value as CodeableConcept in Cx."Gonorrhea Test Choices Grouper"

/*
  @dataElement: NACHC.E1.DE1 Chlamydia Diagnosis
  @activity: NACHC.E1 Chlamydia
  @description: Concepts Associated with Chlamydia Diagnosis
*/
define "Chlamydia Diagnosis":
  [Condition: Cx."Chlamydia Diagnosis Choices Grouper"]

/*
  @dataElement: NACHC.E2.DE1 Chlamydia Test
  @activity: NACHC.E2 Chlamydia test
  @description: Concepts Associated with Chlamydia Testing
*/
define "Chlamydia Test":
  [Observation: Cx."Chlamydia Test"] ChlaTest
    where ChlaTest.value as CodeableConcept in Cx."Chlamydia Test Choices Grouper"

/*
  @dataElement: NACHC.F1.DE1 Drug Rehabilitation
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use Rehabiliation
*/
define "Drug Rehabilitation":
  [Procedure: Cx."Drug Rehabilitation Choices"]

/*
  @dataElement: NACHC.F1.DE12 Injection Findings
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to findings or observations related to Injection Drug Usage
*/
define "Injection Findings":
  [Observation: Cx."Injection Findings"] IDUFindings
    where IDUFindings.value as CodeableConcept in Cx."Injection Findings Choices"

/*
  @dataElement: NACHC.F1.DE15 Injection Drug Use Diagnosis
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts Associated with Injection Drug Use Diagnosis
*/
define "Injection Drug Use Diagnosis":
  [Condition: Cx."Injection Drug Use Diagnosis Choices"]

/*
  @dataElement: NACHC.F1.DE200 Injection Drug Use
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use History
*/
define "Injection Drug Use":
  [MedicationStatement: Cx."Injection Drug Use Choices"]

/*
  @dataElement: NACHC.F2.DE1 Pregnancy Encounters
  @activity: NACHC.F2 Pregnancy
  @description: Encounters in the usage of Pregnancy
*/
define "Pregnancy Encounters":
  [Encounter: Cx."Pregnancy Encounters Choices"]

/*
  @dataElement: NACHC.F2.DE108 Maternal Care
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identifying Maternal Care for Pregnancy
*/
define "Maternal Care":
  [Procedure: Cx."Maternal Care Choices"]

/*
  @dataElement: NACHC.F2.DE1131 Pregnancy Conditions
  @activity: NACHC.F2 Pregnancy
  @description: Conditions identified for Pregnancy
*/
define "Pregnancy Conditions":
  [Condition: Cx."Pregnancy Conditions Choices"]

/*
  @dataElement: NACHC.F2.DE38 Third Trimester Encounters
  @activity: NACHC.F2 Pregnancy
  @description: Third Trimester Encounters in the usage of Pregnancy
*/
define "Third Trimester Encounters":
  [Encounter: Cx."Third Trimester Encounters Choices"]

/*
  @dataElement: NACHC.F2.DE42 Pregnancy Supervision
  @activity: NACHC.F2 Pregnancy
  @description: Procedures in the usage of the Supervision of Pregnancy
*/
define "Pregnancy Supervision":
  [Procedure: Cx."Pregnancy Supervision Choices"]

/*
  @dataElement: NACHC.F2.DE672 Pregnancy Procedures
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identified for Pregnancy
*/
define "Pregnancy Procedures":
  [Procedure: Cx."Pregnancy Procedures Choices"]

/*
  @dataElement: NACHC.F2.DE904 Pregnancy Observations
  @activity: NACHC.F2 Pregnancy
  @description: Observations identified for Pregnancy
*/
define "Pregnancy Observations":
  [Observation: Cx."Pregnancy Observations"] PregnancyObservations
    where PregnancyObservations.value as CodeableConcept in Cx."Pregnancy Observations Choices"

/*
  @dataElement: NACHC.G1.DE1 Post Exposure Prophylaxis
  @activity: NACHC.G1 Pep
  @description: Concepts and Procedures Identifying Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis":
  [Procedure: Cx."Post Exposure Prophylaxis Choices"]

/*
  @dataElement: NACHC.G1.DE143 Post Exposure Prophylaxis Dispensed Medications
  @activity: NACHC.G1 Pep
  @description: List of Medications Provisioned and Supplied for Non-Occupational Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis Dispensed Medications":
  [MedicationDispense: Cx."Prep Dispensed Medications Choices Grouper"]

/*
  @dataElement: NACHC.G1.DE5 Post Exposure Prophylaxis Medication Prescriptions
  @activity: NACHC.G1 Pep
  @description: List of Medication Prescriptions for Non-Occupational Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis Medication Prescriptions":
  [MedicationRequest: Cx."PEP Medication Prescriptions Choices Grouper"]

/*
  @dataElement: NACHC.G2.DE1 Pre Exposure Prophylaxis Medication Prescriptions
  @activity: NACHC.G2 Prep
  @description: List of Medication Prescriptions for Non-Occupational Pre Exposure Prophylaxis
*/
define "Pre Exposure Prophylaxis Medication Prescriptions":
  [MedicationRequest: Cx."Prep Medication Prescriptions Choices Grouper"]

/*
  @dataElement: NACHC.G2.DE26 Pre Exposure Prophylaxis Dispensed Medications
  @activity: NACHC.G2 Prep
  @description: List of Medications Provisioned and Supplied for Non-Occupational Pre Exposure Prophylaxis
*/
define "Pre Exposure Prophylaxis Dispensed Medications":
  [MedicationDispense: Cx."PEP Dispensed Medications Choices Grouper"]

/*
  @dataElement: NACHC.H1.DE1 Previous HIV Screening
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been screened for HIV?
*/
define "Previous HIV Screening":
  [Observation: Cx."HIV Test"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE10 Previous experience with PREP
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been given PREP?
*/
define "Previous experience with PREP":
  [Observation: Cx."Prep Medication Prescriptions Choices Grouper"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE11 Sexual Activity - Past Year
  @activity: NACHC.H1 Risk Factors
  @description: Have you been sexually active in the past year?
*/
define "Sexual Activity - Past Year":
  [Observation: Cx."Sexual Activity - Past Year"] Resource
    where (
      Resource.value is boolean
      or Resource.value is string
    )

/*
  @dataElement: NACHC.H1.DE12 Sexual Activity - History
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been sexually active?
*/
define "Sexual Activity - History":
  [Observation: Cx."Sexual Activity - History"] Resource
    where (
      Resource.value is boolean
      or Resource.value is string
    )

/*
  @dataElement: NACHC.H1.DE13 Sexual Activity - Men
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with men?
*/
define "Sexual Activity - Men":
  [Observation: Cx."Sexual Activity - Men"] Resource
    where (
      Resource.value is boolean
      or Resource.value is string
    )

/*
  @dataElement: NACHC.H1.DE14 Sexual Activity - Women
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with women?
*/
define "Sexual Activity - Women":
  [Observation: Cx."Sexual Activity - Women"] Resource
    where (
      Resource.value is boolean
      or Resource.value is string
    )

/*
  @dataElement: NACHC.H1.DE15 Sexual Activity - Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Have you had more than 1 sexual partner since last being tested for HIV?
*/
define "Sexual Activity - Number of Partners":
  [Observation: Cx."Sexual Activity - Number of Partners"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE16 Sexual Activity - New Partner Past 3 Months
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months, have you had sex with someone you didn’t know or had just met?
*/
define "Sexual Activity - New Partner Past 3 Months":
  [Observation: Cx."Sexual Activity - New Partner Past 3 Months"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE17 Sexual Activity - Partners History
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has other sexual partners?
*/
define "Sexual Activity - Partners History":
  [Observation: Cx."Sexual Activity - Partners History"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE18 Sexual Activity - Partners Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has had more than 1 sexual partner since their last HIV test?
*/
define "Sexual Activity - Partners Number of Partners":
  [Observation: Cx."Sexual Activity - Partners Number of Partners"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE19 Sexual Activity - Partners HIV History
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has HIV?
*/
define "Sexual Activity - Partners HIV History":
  [Observation: Cx."Sexual Activity - Partners HIV History"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE2 Previous HIV Diagnosis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been diagnosed with HIV?
*/
define "Previous HIV Diagnosis":
  [Observation: Cx."HIV Diagnosis"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE20 Sexual Activity - Drug or Alcohol Use
  @activity: NACHC.H1 Risk Factors
  @description: Have you or any of your partners used alcohol or drugs when you had sex?
*/
define "Sexual Activity - Drug or Alcohol Use":
  [Observation: Cx."Sexual Activity - Drug or Alcohol Use"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE21 Sexual Activity - Exchanged for Sex
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever exchanged sex for drugs or money?
*/
define "Sexual Activity - Exchanged for Sex":
  [Observation: Cx."Sexual Activity - Exchanged for Sex"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE22 Sexual Activity - Coercion
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been coerced or pressured to have sex?
*/
define "Sexual Activity - Coercion":
  [Observation: Cx."Sexual Activity - Coercion"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE23 Sexual Activity - Kind of Sex - Anal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had anal sex?
*/
define "Sexual Activity - Kind of Sex - Anal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Anal"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE24 Sexual Activity - Male - Kind of Sex - Receptive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had receptive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Receptive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Receptive Anal"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE25 Sexual Activity - Male - Kind of Sex - Insertive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had insertive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Insertive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Insertive Anal"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE26 Sexual Activity - Kind of Sex - Vaginal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had vaginal sex?
*/
define "Sexual Activity - Kind of Sex - Vaginal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Vaginal"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE3 Patient Currently Pregnant
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient is currently pregnant?
*/
define "Patient Currently Pregnant":
  [Observation: Cx."Patient Currently Pregnant"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE4 Patient Diagnosed with HCV
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with HCV?
*/
define "Patient Diagnosed with HCV":
  [Observation: Cx."Patient Diagnosed with HCV"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE5 Patient Diagnosed with Syphilis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Syphilis?
*/
define "Patient Diagnosed with Syphilis":
  [Observation: Cx."Patient Diagnosed with Syphilis"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE6 Patient Diagnosed with Gonorrhea
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Gonorrhea?
*/
define "Patient Diagnosed with Gonorrhea":
  [Observation: Cx."Patient Diagnosed with Gonorrhea"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE7 Patient Diagnosed with Chlamydia
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Chlamydia?
*/
define "Patient Diagnosed with Chlamydia":
  [Observation: Cx."Patient Diagnosed with Chlamydia"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE8 Patient has used Injection Drugs
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been using Injection Drugs?
*/
define "Patient has used Injection Drugs":
  [Observation: Cx."Patient has used Injection Drugs"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H1.DE9 Seeking STD Treatment
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient is currently seeking evaluation and treatment of an STD?
*/
define "Seeking STD Treatment":
  [Observation: Cx."Seeking STD Treatment"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE1 DAST 10 Question 1
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 1
*/
define "DAST 10 Question 1":
  [Observation: Cx."DAST 10 Question 1 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE3 DAST 10 Question 2
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 2
*/
define "DAST 10 Question 2":
  [Observation: Cx."DAST 10 Question 2 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE5 DAST 10 Question 3
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 3
*/
define "DAST 10 Question 3":
  [Observation: Cx."DAST 10 Question 3 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE7 DAST 10 Question 4
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 4
*/
define "DAST 10 Question 4":
  [Observation: Cx."DAST 10 Question 4 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE9 DAST 10 Question 5
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 5
*/
define "DAST 10 Question 5":
  [Observation: Cx."DAST 10 Question 5 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE11 DAST 10 Question 6
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 6
*/
define "DAST 10 Question 6":
  [Observation: Cx."DAST 10 Question 6 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE13 DAST 10 Question 7
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 7
*/
define "DAST 10 Question 7":
  [Observation: Cx."DAST 10 Question 7 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE15 DAST 10 Question 8
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 8
*/
define "DAST 10 Question 8":
  [Observation: Cx."DAST 10 Question 8 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE17 DAST 10 Question 9
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 9
*/
define "DAST 10 Question 9":
  [Observation: Cx."DAST 10 Question 9 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )

/*
  @dataElement: NACHC.H2.DE19 DAST 10 Question 10
  @activity: NACHC.H2 DAST 10
  @description: DAST 10 Question 10
*/
define "DAST 10 Question 10":
  [Observation: Cx."DAST 10 Question 10 Choices"] Resource
    where (
      Resource.value = true
      or Lower(Resource.value) = 'yes'
      or Lower(Resource.value) = 'y'
    )
