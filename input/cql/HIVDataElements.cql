library HIVDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include NACHCCommon called NC
include HIVCommon called AC
include HIVConcepts called Cx

context Patient

/*
  @dataElement: NACHC.A0.DE55 Gender Identity
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Gender Identity Elements
*/
define "Gender Identity":
  NC.MostRecent(
    [Observation: Cx."Gender Identity"] O
      where O.status in { 'final', 'amended', 'corrected' }
  ).value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.A0.DE1 Encounter Type
  @activity: NACHC.A0 Contact & Profile
  @description: The type of patient encounter
*/
define "Encounter Type":
  [Encounter: Cx."Encounter Type Codes"] E
    where E.status = 'finished'


/*
  @dataElement: NACHC.A0.DE48 Sexual Orientation
  @activity: NACHC.A0 Contact & Profile
  @description: Concepts Associated with Sexual Orientation Elements
*/
define "Sexual Orientation":
  NC.MostRecent(
    [Observation: Cx."Sexual Orientation"] O
      where O.status in { 'final', 'amended', 'corrected' }
  ).value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.A1.DE1 HIV Diagnosis
  @activity: NACHC.A1 HIV
  @description: Concepts Associated with HIV Diagnosis
*/
define "HIV Diagnosis":
  [Condition: Cx."HIV infection as a condition Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.A2.DE1 HIV Test
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with HIV Testing
*/
define "HIV Test":
  [Observation: Cx."HIV Test"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.A2.DE216 HIV Test Ordered
  @activity: NACHC.A2 HIV test
  @description: Concepts Associated with Ordering an HIV Test
*/
define "HIV Test Ordered":
  [ServiceRequest: Cx."HIV Test Ordered Codes"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SR.doNotPerform is not true
    //return SR.code


/*
  @dataElement: NACHC.B1.DE1 Hepatitis C Diagnosis
  @activity: NACHC.B1 HCV
  @description: Concepts Associated with HCV Diagnosis
*/
define "Hepatitis C Diagnosis":
  [Condition: Cx."Hepatitis C Diagnosis Codes Grouper"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.B2.DE112 Hepatitis C Procedures
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Procedures
*/
define "Hepatitis C Procedures":
  [Procedure: Cx."Hepatitis C Procedures Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.B2.DE1 Hepatitis C Test
  @activity: NACHC.B2 HCV test
  @description: Concepts Associated with HCV Testing
*/
define "Hepatitis C Test":
  [Observation: Cx."Hepatitis C Test"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.C1.DE1 Syphilis Diagnosis
  @activity: NACHC.C1 Syphilis
  @description: Concepts Associated with Syphilis Diagnosis
*/
define "Syphilis Diagnosis":
  [Condition: Cx."Syphilis Diagnosis Codes Grouper"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.C2.DE1 Syphilis Test
  @activity: NACHC.C2 Syphilis test
  @description: Concepts Associated with Syphilis Testing
*/
define "Syphilis Test":
  [Observation: Cx."Syphilis Test"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.D1.DE1 Gonorrhea Diagnosis
  @activity: NACHC.D1 Gonorrhea
  @description: Concepts Associated with Gonorrhea Diagnosis
*/
define "Gonorrhea Diagnosis":
  [Condition: Cx."Gonorrhea Diagnosis Codes Grouper"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.D2.DE1 Gonorrhea Test
  @activity: NACHC.D2 Gonorrhea test
  @description: Concepts Associated with Gonorrhea Testing
*/
define "Gonorrhea Test":
  [Observation: Cx."Gonorrhea Test"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.E1.DE1 Chlamydia Diagnosis
  @activity: NACHC.E1 Chlamydia
  @description: Concepts Associated with Chlamydia Diagnosis
*/
define "Chlamydia Diagnosis":
  [Condition: Cx."Chlamydia Diagnosis Codes Grouper"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.E2.DE1 Chlamydia Test
  @activity: NACHC.E2 Chlamydia test
  @description: Concepts Associated with Chlamydia Testing
*/
define "Chlamydia Test":
  [Observation: Cx."Chlamydia Test"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.F1.DE1 Drug Rehabilitation
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use Rehabiliation
*/
define "Drug Rehabilitation":
  [Procedure: Cx."Drug Rehabilitation Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.F1.DE200 Injection Drug Use
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to Injection Drug Use History
*/
define "Injection Drug Use":
  [MedicationStatement: Cx."Injection Drug Use Codes"]

/*
  @dataElement: NACHC.F1.DE15 Injection Drug Use Diagnosis
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts Associated with Injection Drug Use Diagnosis
*/
define "Injection Drug Use Diagnosis":
  [Condition: Cx."Injection Drug Use Diagnosis Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.F1.DE12 Injection Findings
  @activity: NACHC.F1 Injection Drug Use
  @description: Concepts related to findings or observations related to Injection Drug Usage
*/
define "Injection Findings":
  [Observation: Cx."Injection Findings"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.F2.DE108 Maternal Care
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identifying Maternal Care for Pregnancy
*/
define "Maternal Care":
  [Procedure: Cx."Maternal Care Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.F2.DE1131 Pregnancy Conditions
  @activity: NACHC.F2 Pregnancy
  @description: Conditions identified for Pregnancy
*/
define "Pregnancy Conditions":
  [Condition: Cx."Pregnancy Conditions Codes"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
    //return C.code


/*
  @dataElement: NACHC.F2.DE1 Pregnancy Encounters
  @activity: NACHC.F2 Pregnancy
  @description: Encounters in the usage of Pregnancy
*/
define "Pregnancy Encounters":
  [Encounter: Cx."Pregnancy Encounters Codes"] E
    where E.status = 'finished'
    //return E.type


/*
  @dataElement: NACHC.F2.DE904 Pregnancy Observations
  @activity: NACHC.F2 Pregnancy
  @description: Observations identified for Pregnancy
*/
define "Pregnancy Observations":
  [Observation: Cx."Pregnancy Observations Codes"] O
    where O.status in { 'final', 'amended', 'corrected' }
    //return O.value as FHIR.CodeableConcept


/*
  @dataElement: NACHC.F2.DE672 Pregnancy Procedures
  @activity: NACHC.F2 Pregnancy
  @description: Procedures identified for Pregnancy
*/
define "Pregnancy Procedures":
  [Procedure: Cx."Pregnancy Procedures Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.F2.DE42 Pregnancy Supervision
  @activity: NACHC.F2 Pregnancy
  @description: Procedures in the usage of the Supervision of Pregnancy
*/
define "Pregnancy Supervision":
  [Procedure: Cx."Pregnancy Supervision Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.F2.DE38 Third Trimester Encounters
  @activity: NACHC.F2 Pregnancy
  @description: Third Trimester Encounters in the usage of Pregnancy
*/
define "Third Trimester Encounters":
  [Encounter: Cx."Third Trimester Encounters Codes"] E
    where E.status = 'finished'
    //return E.type


/*
  @dataElement: NACHC.G1.DE143 PEP Dispensed Medications
  @activity: NACHC.G1 Pep
  @description: List of Medications Provisioned and Supplied for Non-Occupational Post Exposure Prophylaxis
*/
define "PEP Dispensed Medications":
  [MedicationDispense: Cx."PEP Dispensed Medications Codes Grouper"]

/*
  @dataElement: NACHC.G1.DE5 PEP Medication Prescriptions
  @activity: NACHC.G1 Pep
  @description: List of Medication Prescriptions for Non-Occupational Post Exposure Prophylaxis
*/
define "PEP Medication Prescriptions":
  [MedicationRequest: Cx."PEP Medication Prescriptions Codes Grouper"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is not true
    //return MR.medication as FHIR.CodeableConcept


/*
  @dataElement: NACHC.G1.DE1 Post Exposure Prophylaxis
  @activity: NACHC.G1 Pep
  @description: Concepts and Procedures Identifying Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis":
  [Procedure: Cx."Post Exposure Prophylaxis Codes"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
    //return P.code


/*
  @dataElement: NACHC.G2.DE26 Prep Dispensed Medications
  @activity: NACHC.G2 Prep
  @description: List of Medications Provisioned and Supplied for Non-Occupational Pre Exposure Prophylaxis
*/
define "Prep Dispensed Medications":
  [MedicationDispense: Cx."Prep Dispensed Medications Codes Grouper"]

/*
  @dataElement: NACHC.G2.DE1 Prep Medication Prescriptions
  @activity: NACHC.G2 Prep
  @description: List of Medication Prescriptions for Non-Occupational Pre Exposure Prophylaxis
*/
define "Prep Medication Prescriptions":
  [MedicationRequest: Cx."Prep Medication Prescriptions Codes Grouper"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is not true
    //return MR.medication as FHIR.CodeableConcept


/*
  @dataElement: NACHC.H1.DE3 Patient Currently Pregnant
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient is currently pregnant?
*/
define "Patient Currently Pregnant":
  [Observation: Cx."Patient Currently Pregnant"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE7 Patient Diagnosed with Chlamydia
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Chlamydia?
*/
define "Patient Diagnosed with Chlamydia":
  [Observation: Cx."Patient Diagnosed with Chlamydia"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE6 Patient Diagnosed with Gonorrhea
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Gonorrhea?
*/
define "Patient Diagnosed with Gonorrhea":
  [Observation: Cx."Patient Diagnosed with Gonorrhea"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE4 Patient Diagnosed with HCV
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with HCV?
*/
define "Patient Diagnosed with HCV":
  [Observation: Cx."Patient Diagnosed with HCV"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE5 Patient Diagnosed with Syphilis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been diagnosed with Syphilis?
*/
define "Patient Diagnosed with Syphilis":
  [Observation: Cx."Patient Diagnosed with Syphilis"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE8 Patient has used Injection Drugs
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has been using Injection Drugs?
*/
define "Patient has used Injection Drugs":
  [Observation: Cx."Patient has used Injection Drugs"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE10 Previous experience with PREP
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been given PREP?
*/
define "Previous experience with PREP":
  [Observation: Cx."Previous experience with PREP"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE2 Previous HIV Diagnosis
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been diagnosed with HIV?
*/
define "Previous HIV Diagnosis":
  [Observation: Cx."Previous HIV Diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE1 Previous HIV Screening
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient has previously been screened for HIV?
*/
define "Previous HIV Screening":
  [Observation: Cx."Previous HIV Screening"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE9 Seeking STD Treatment
  @activity: NACHC.H1 Risk Factors
  @description: Whether the patient is currently seeking evaluation and treatment of an STD?
*/
define "Seeking STD Treatment":
  [Observation: Cx."Seeking STD Treatment"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE22 Sexual Activity - Coercion
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been coerced or pressured to have sex?
*/
define "Sexual Activity - Coercion":
  [Observation: Cx."Sexual Activity - Coercion"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE20 Sexual Activity - Drug or Alcohol Use
  @activity: NACHC.H1 Risk Factors
  @description: Have you or any of your partners used alcohol or drugs when you had sex?
*/
define "Sexual Activity - Drug or Alcohol Use":
  [Observation: Cx."Sexual Activity - Drug or Alcohol Use"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE21 Sexual Activity - Exchanged for Sex
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever exchanged sex for drugs or money?
*/
define "Sexual Activity - Exchanged for Sex":
  [Observation: Cx."Sexual Activity - Exchanged for Sex"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE12 Sexual Activity - History
  @activity: NACHC.H1 Risk Factors
  @description: Have you ever been sexually active?
*/
define "Sexual Activity - History":
  [Observation: Cx."Sexual Activity - History"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE23 Sexual Activity - Kind of Sex - Anal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had anal sex?
*/
define "Sexual Activity - Kind of Sex - Anal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Anal"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE26 Sexual Activity - Kind of Sex - Vaginal
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months have you had vaginal sex?
*/
define "Sexual Activity - Kind of Sex - Vaginal":
  [Observation: Cx."Sexual Activity - Kind of Sex - Vaginal"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE25 Sexual Activity - Male - Kind of Sex - Insertive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had insertive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Insertive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Insertive Anal"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE24 Sexual Activity - Male - Kind of Sex - Receptive Anal
  @activity: NACHC.H1 Risk Factors
  @description: If Male: In the past 3 months have you had receptive anal sex?
*/
define "Sexual Activity - Male - Kind of Sex - Receptive Anal":
  [Observation: Cx."Sexual Activity - Male - Kind of Sex - Receptive Anal"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE13 Sexual Activity - Men
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with men?
*/
define "Sexual Activity - Men":
  [Observation: Cx."Sexual Activity - Men"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE16 Sexual Activity - New Partner Past 3 Months
  @activity: NACHC.H1 Risk Factors
  @description: In the past 3 months, have you had sex with someone you didn’t know or had just met?
*/
define "Sexual Activity - New Partner Past 3 Months":
  [Observation: Cx."Sexual Activity - New Partner Past 3 Months"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE15 Sexual Activity - Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Have you had more than 1 sexual partner since last being tested for HIV?
*/
define "Sexual Activity - Number of Partners":
  [Observation: Cx."Sexual Activity - Number of Partners"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE17 Sexual Activity - Partners History
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has other sexual partners?
*/
define "Sexual Activity - Partners History":
  [Observation: Cx."Sexual Activity - Partners History"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE19 Sexual Activity - Partners HIV History
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has HIV?
*/
define "Sexual Activity - Partners HIV History":
  [Observation: Cx."Sexual Activity - Partners HIV History"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE18 Sexual Activity - Partners Number of Partners
  @activity: NACHC.H1 Risk Factors
  @description: Do you know whether your partner has had more than 1 sexual partner since their last HIV test?
*/
define "Sexual Activity - Partners Number of Partners":
  [Observation: Cx."Sexual Activity - Partners Number of Partners"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE11 Sexual Activity - Past Year
  @activity: NACHC.H1 Risk Factors
  @description: Have you been sexually active in the past year?
*/
define "Sexual Activity - Past Year":
  [Observation: Cx."Sexual Activity - Past Year"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H1.DE14 Sexual Activity - Women
  @activity: NACHC.H1 Risk Factors
  @description: Do you have sex with women?
*/
define "Sexual Activity - Women":
  [Observation: Cx."Sexual Activity - Women"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE1 DAST 10 Question 1
  @activity: NACHC.H2 DAST 10
  @description: Have you used drugs other than those required for medical reasons?
*/
define "DAST 10 Question 1":
  [Observation: Cx."DAST 10 Question 1"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE10 DAST 10 Question 10
  @activity: NACHC.H2 DAST 10
  @description: Have you had medical problems as a result of your drug use (e.g., memory loss, hepatitis, convulsions, bleeding, etc.)?
*/
define "DAST 10 Question 10":
  [Observation: Cx."DAST 10 Question 10"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE2 DAST 10 Question 2
  @activity: NACHC.H2 DAST 10
  @description: Do you use more than one drug at a time?
*/
define "DAST 10 Question 2":
  [Observation: Cx."DAST 10 Question 2"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE3 DAST 10 Question 3
  @activity: NACHC.H2 DAST 10
  @description: Are you always able to stop using drugs when you want to?
*/
define "DAST 10 Question 3":
  [Observation: Cx."DAST 10 Question 3"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE4 DAST 10 Question 4
  @activity: NACHC.H2 DAST 10
  @description: Have you had blackouts or flashbacks as a result of drug use?
*/
define "DAST 10 Question 4":
  [Observation: Cx."DAST 10 Question 4"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE5 DAST 10 Question 5
  @activity: NACHC.H2 DAST 10
  @description: Do you ever feel bad or guilty about your drug use? 
*/
define "DAST 10 Question 5":
  [Observation: Cx."DAST 10 Question 5"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE6 DAST 10 Question 6
  @activity: NACHC.H2 DAST 10
  @description: Does your spouse (or parents) ever complain about your involvement with drugs?
*/
define "DAST 10 Question 6":
  [Observation: Cx."DAST 10 Question 6"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE7 DAST 10 Question 7
  @activity: NACHC.H2 DAST 10
  @description: Have you neglected your family because of your use of drugs?
*/
define "DAST 10 Question 7":
  [Observation: Cx."DAST 10 Question 7"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE8 DAST 10 Question 8
  @activity: NACHC.H2 DAST 10
  @description: Have you engaged in illegal activities in order to obtain drugs?
*/
define "DAST 10 Question 8":
  [Observation: Cx."DAST 10 Question 8"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE9 DAST 10 Question 9
  @activity: NACHC.H2 DAST 10
  @description: Have you ever experienced withdrawal symptoms (felt sick) when you stopped taking drugs?
*/
define "DAST 10 Question 9":
  [Observation: Cx."DAST 10 Question 9"] O
    where O.status in { 'final', 'amended', 'corrected' }


/*
  @dataElement: NACHC.H2.DE11 DAST 10 Score
  @activity: NACHC.H2 DAST 10
  @description: Substance Abuse Prescription Illicit Substance Over the Counter Product Screening Test Score
*/
define "DAST 10 Score":
  [Observation: Cx."DAST 10 Score"] O
    where O.status in { 'final', 'amended', 'corrected' }
