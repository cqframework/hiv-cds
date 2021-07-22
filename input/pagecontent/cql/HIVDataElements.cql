library HIVDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include NACHCCommon called NC
include HIVCommon called AC
include HIVConcepts called Cx

context Patient

/*
  @dataElement: NACHC.A0.DE1 Patient Encounter
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Patient Encounters
*/
define "Patient Encounter":
  [Encounter: Cx."Patient Encounter"]

/*
  @dataElement: NACHC.A1.DE1 HIV Diagnosis
  @activity: NACHC.A1 HIV
  @description: Concepts Associated with HIV Diagnosis
*/
define "HIV Diagnosis":
  [Condition: Cx."HIV Diagnosis"]

/*
  @dataElement: NACHC.A2.DE1 HIV Test
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with HIV Testing
*/
define "HIV Test":
  [Observation: Cx."HIV Test"]

/*
  @dataElement: NACHC.A2.DE216 HIV Test Ordered
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with Ordering an HIV Test
*/
define "HIV Test Ordered":
  [ServiceRequest: Cx."HIV Test Ordered"]

/*
  @dataElement: NACHC.B1.DE1 Hepatitis C Diagnosis
  @activity: NACHC.B1 HCV
  @description: Concepts Associated with HCV Diagnosis
*/
define "Hepatitis C Diagnosis":
  [Condition: Cx."Hepatitis C Diagnosis"]

/*
  @dataElement: NACHC.B2.DE1 Hepatitis C Test
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Testing
*/
define "Hepatitis C Test":
  [Observation: Cx."Hepatitis C Test"]

/*
  @dataElement: NACHC.B2.DE1 Hepatitis C Procedures
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Procedures
*/
define "Hepatitis C Procedures":
  [Observation: Cx."Hepatitis C Procedures"]

/*
  @dataElement: NACHC.C1.DE1 Syphilis Diagnosis
  @activity: NACHC.C1 Syphilis
  @description: Concepts Associated with Syphilis Diagnosis
*/
define "Syphilis Diagnosis":
  [Condition: Cx."Syphilis Diagnosis"]

/*
  @dataElement: NACHC.C2.DE1 Syphilis Test
  @activity: NACHC.C2 Syphilis test
  @description: Concepts Associated with Syphilis Testing
*/
define "Syphilis Test":
  [Observation: Cx."Syphilis Test"]

/*
  @dataElement: NACHC.D1.DE1 Gonorrhea Diagnosis
  @activity: NACHC.D1 Gonorrhea
  @description: Concepts Associated with Gonorrhea Diagnosis
*/
define "Gonorrhea Diagnosis":
  [Condition: Cx."Gonorrhea Diagnosis"]

/*
  @dataElement: NACHC.D2.DE1 Gonorrhea Test
  @activity: NACHC.D2 Gonorrhea test
  @description: Concepts Associated with Gonorrhea Testing
*/
define "Gonorrhea Test":
  [Observation: Cx."Gonorrhea Test"]

/*
  @dataElement: NACHC.E1.DE1 Chlamydia Diagnosis
  @activity: NACHC.E1 Chlamydia
  @description: Concepts Associated with Chlamydia Diagnosis
*/
define "Chlamydia Diagnosis":
  [Condition: Cx."Chlamydia Diagnosis"]

/*
  @dataElement: NACHC.E2.DE1 Chlamydia Test
  @activity: NACHC.E2 Chlamydia test
  @description: Concepts Associated with Chlamydia Testing
*/
define "Chlamydia Test":
  [Observation: Cx."Chlamydia Test"]

/*
  @dataElement: NACHC.F1.DE1 Drug Rehabilitation
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use Rehabiliation
*/
define "Drug Rehabilitation":
  [Procedure: Cx."Drug Rehabilitation"]

/*
  @dataElement: NACHC.F1.DE12 Injection Findings
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to findings or observations related to Injection Drug Usage
*/
define "Injection Findings":
  [Observation: Cx."Injection Findings"]

/*
  @dataElement: NACHC.F1.DE15 Injection Drug Use Diagnosis
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts Associated with Injection Drug Use Diagnosis
*/
define "Injection Drug Use Diagnosis":
  [Condition: Cx."Injection Drug Use Diagnosis"]

/*
  @dataElement: NACHC.F1.DE200 Injection Drug Use
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use History
*/
define "Injection Drug Use":
  [MedicationStatement: Cx."Injection Drug Use"]

/*
  @dataElement: NACHC.F2.DE1 Pregnancy Encounters
  @activity: NACHC.F2 Pregnancy
  @description: Encounters in the usage of Pregnancy
*/
define "Pregnancy Encounters":
  [Encounter: Cx."Pregnancy Encounters"]

/*
  @dataElement: NACHC.F2.DE104 Maternal Care
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identifying Maternal Care for Pregnancy
*/
define "Maternal Care":
  [Procedure: Cx."Maternal Care"]

/*
  @dataElement: NACHC.F2.DE1128 Pregnancy Conditions
  @activity: NACHC.F2 Pregnancy
  @description: Conditions identified for Pregnancy
*/
define "Pregnancy Conditions":
  [Condition: Cx."Pregnancy Conditions"]

/*
  @dataElement: NACHC.F2.DE38 Pregnancy Supervision
  @activity: NACHC.F2 Pregnancy
  @description: Procedures in the usage of the Supervision of Pregnancy
*/
define "Pregnancy Supervision":
  [Procedure: Cx."Pregnancy Supervision"]

/*
  @dataElement: NACHC.F2.DE668 Pregnancy Procedures
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identified for Pregnancy
*/
define "Pregnancy Procedures":
  [Procedure: Cx."Pregnancy Procedures"]

/*
  @dataElement: NACHC.F2.DE900 Pregnancy Observations
  @activity: NACHC.F2 Pregnancy
  @description: Observations identified for Pregnancy
*/
define "Pregnancy Observations":
  [Observation: Cx."Pregnancy Observations"]

/*
  @dataElement: NACHC.G1.DE1 Post Exposure Prophylaxis
  @activity: NACHC.G1 Post Exposure Prophylaxis
  @description: Concepts and Procedures Identifying Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis":
  [Procedure: Cx."Post Exposure Prophylaxis"]

/*
  @dataElement: NACHC.G1.DE143 Post Exposure Prophylaxis Dispensed Medications
  @activity: NACHC.G1 Post Exposure Prophylaxis
  @description: List of Medications Provisioned and Supplied for Non-Occupational Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis Dispensed Medications":
  [MedicationDispense: Cx."Post Exposure Prophylaxis Dispensed Medications"]

/*
  @dataElement: NACHC.G1.DE5 Post Exposure Prophylaxis Medication Prescriptions
  @activity: NACHC.G1 Post Exposure Prophylaxis
  @description: List of Medication Prescriptions for Non-Occupational Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis Medication Prescriptions":
  [MedicationRequest: Cx."Post Exposure Prophylaxis Medication Prescriptions"]

/*
  @dataElement: NACHC.G2.DE1 Pre Exposure Prophylaxis Medication Prescriptions
  @activity: NACHC.G2 Pre Exposure Prophylaxis
  @description: List of Medication Prescriptions for Non-Occupational Pre Exposure Prophylaxis
*/
define "Pre Exposure Prophylaxis Medication Prescriptions":
  [MedicationRequest: Cx."Pre Exposure Prophylaxis Medication Prescriptions"]

/*
  @dataElement: NACHC.G2.DE26 Pre Exposure Prophylaxis Dispensed Medications
  @activity: NACHC.G2 Pre Exposure Prophylaxis
  @description: List of Medications Provisioned and Supplied for Non-Occupational Pre Exposure Prophylaxis
*/
define "Pre Exposure Prophylaxis Dispensed Medications":
  [MedicationDispense: Cx."Pre Exposure Prophylaxis Dispensed Medications"]

/*
  @dataElement: NACHC.H1.DE1 Previous HIV Screening
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been screened for HIV?
*/
define "Previous HIV Screening":
  [Observation: Cx."HIV Test"]

/*
  @dataElement: NACHC.H1.DE10 Sexual Activity - Past Year
  @activity: NACHC.H1 Risk Factors
  @description: Have you been sexually active in the past year?
*/
define "Sexual Activity - Past Year":
  [Observation: Cx."Sexual Activity - Past Year"]

/*
  @dataElement: NACHC.H1.DE11 Sexual Activity -  History
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been sexually active?
*/
define "Sexual Activity -  History":
  [Observation: Cx."Sexual Activity -  History"]

/*
  @dataElement: NACHC.H1.DE12 Sexual Activity - Men
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with men?
*/
define "Sexual Activity - Men":
  [Observation: Cx."Sexual Activity - Men"]

/*
  @dataElement: NACHC.H1.DE13 Sexual Activity -  Women
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with women?
*/
define "Sexual Activity -  Women":
  [Observation: Cx."Sexual Activity -  Women"]

/*
  @dataElement: NACHC.H1.DE14 Sexual Activity -  Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Have you had more than 1 sexual partner since last being tested for HIV?
*/
define "Sexual Activity -  Number of Partners":
  [Observation: Cx."Sexual Activity -  Number of Partners"]

/*
  @dataElement: NACHC.H1.DE15 Sexual Activity - New Partner Past 3 Months
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months, have you had sex with someone you didn’t know or had just met?
*/
define "Sexual Activity - New Partner Past 3 Months":
  [Observation: Cx."Sexual Activity - New Partner Past 3 Months"]

/*
  @dataElement: NACHC.H1.DE16 Sexual Activity -  Partners History
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has other sexual partners?
*/
define "Sexual Activity -  Partners History":
  [Observation: Cx."Sexual Activity -  Partners History"]

/*
  @dataElement: NACHC.H1.DE17 Sexual Activity -  Partners Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has had more than 1 sexual partner since their last HIV test?
*/
define "Sexual Activity -  Partners Number of Partners":
  [Observation: Cx."Sexual Activity -  Partners Number of Partners"]

/*
  @dataElement: NACHC.H1.DE18 Sexual Activity -  Coercion
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been coerced or pressured to have sex?
*/
define "Sexual Activity -  Coercion":
  [Observation: Cx."Sexual Activity -  Coercion"]

/*
  @dataElement: NACHC.H1.DE19 Sexual Activity - Kind of Sex - Anal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had anal sex?
*/
define "Sexual Activity - Kind of Sex - Anal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Anal"]

/*
  @dataElement: NACHC.H1.DE2 Previous HIV Diagnosis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been diagnosed with HIV?
*/
define "Previous HIV Diagnosis":
  [Observation: Cx."HIV Diagnosis"]

/*
  @dataElement: NACHC.H1.DE20 Sexual Activity - Male - Kind of Sex - Receptive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had receptive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Receptive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Receptive Anal"]

/*
  @dataElement: NACHC.H1.DE21 Sexual Activity - Male - Kind of Sex - Insertive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had insertive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Insertive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Insertive Anal"]

/*
  @dataElement: NACHC.H1.DE22 Sexual Activity - Kind of Sex - Vaginal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had vaginal sex?
*/
define "Sexual Activity - Kind of Sex - Vaginal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Vaginal"]

/*
  @dataElement: NACHC.H1.DE23 Sexual Activity - Drug or Alcohol Use
  @activity: NACHC.H1 Risk Factors
  @description: Have you or any of your partners used alcohol or drugs when you had sex?
*/
define "Sexual Activity - Drug or Alcohol Use":
  [Observation: Cx."Sexual Activity - Drug or Alcohol Use"]

/*
  @dataElement: NACHC.H1.DE24 Sexual Activity - Exchanged for Sex
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever exchanged sex for drugs or money?
*/
define "Sexual Activity - Exchanged for Sex":
  [Observation: Cx."Sexual Activity - Exchanged for Sex"]

/*
  @dataElement: NACHC.H1.DE3 Patient Currently Pregnant
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient is currently pregnant?
*/
define "Patient Currently Pregnant":
  [Observation: Cx."Pregnancy Conditions"]

/*
  @dataElement: NACHC.H1.DE4 Patient Diagnosed with HCV
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with HCV?
*/
define "Patient Diagnosed with HCV":
  [Observation: Cx."Hepatitis C Diagnosis"]

/*
  @dataElement: NACHC.H1.DE5 Patient Diagnosed with Syphilis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Syphilis?
*/
define "Patient Diagnosed with Syphilis":
  [Observation: Cx."Syphilis Diagnosis"]

/*
  @dataElement: NACHC.H1.DE6 Patient Diagnosed with Gonorrhea
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Gonorrhea?
*/
define "Patient Diagnosed with Gonorrhea":
  [Observation: Cx."Gonorrhea Diagnosis"]

/*
  @dataElement: NACHC.H1.DE7 Patient Diagnosed with Chlamydia
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Chlamydia?
*/
define "Patient Diagnosed with Chlamydia":
  [Observation: Cx."Chlamydia Diagnosis"]

/*
  @dataElement: NACHC.H1.DE8 Patient has used Injection Drugs
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been using Injection Drugs?
*/
define "Patient has used Injection Drugs":
  [Observation: Cx."Injection Drug Use Diagnosis"]

/*
  @dataElement: NACHC.H1.DE9 Previous experience with PREP
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been given PREP?
*/
define "Previous experience with PREP":
  [Observation: Cx."Pre Exposure Prophylaxis Medication Prescriptions"]

