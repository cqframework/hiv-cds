library HIVContactDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include NACHCCommon called NC
include HIVCommon called AC
include HIVConcepts called Cx

context Encounter

/*
  @dataElement: NACHC.A1.DE1 HIV infection as a condition
  @activity: NACHC.A1 HIV
  @description: HIV
*/
define "HIV infection as a condition":
  [Condition: Cx."HIV infection as a condition"]

/*
  @dataElement: NACHC.A2.DE1 HIV-1 HIV 2 Ab Ag tests
  @activity: NACHC.A2 HIV test
  @description: HIV Test
*/
define "HIV-1 HIV 2 Ab Ag tests":
  [Observation: Cx."HIV-1 HIV 2 Ab Ag tests"]

/*
  @dataElement: NACHC.A2.DE172 HIV Viral Load
  @activity: NACHC.A2 HIV test
  @description: HIV Test
*/
define "HIV Viral Load":
  [Observation: Cx."HIV Viral Load"]

/*
  @dataElement: NACHC.B1.DE1 Hepatitis C Virus Infection (Disorders)
  @activity: NACHC.B1 HCV
  @description: HCV
*/
define "Hepatitis C Virus Infection (Disorders)":
  [Condition: Cx."Hepatitis C Virus Infection (Disorders)"]

/*
  @dataElement: NACHC.B1.DE31 Chronic Infection of liver due to Hepatitis C virus
  @activity: NACHC.B1 HCV
  @description: HCV
*/
define "Chronic Infection of liver due to Hepatitis C virus":
  [Condition: Cx."Chronic Infection of liver due to Hepatitis C virus"]

/*
  @dataElement: NACHC.B1.DE34 HCV Infection (Organism or Substance in Lab Results)
  @activity: NACHC.B1 HCV
  @description: HCV
*/
define "HCV Infection (Organism or Substance in Lab Results)":
  [Condition: Cx."HCV Infection (Organism or Substance in Lab Results)"]

/*
  @dataElement: NACHC.B1.DE65 Hepatitis C condition
  @activity: NACHC.B1 HCV
  @description: HCV
*/
define "Hepatitis C condition":
  [Condition: Cx."Hepatitis C condition"]

/*
  @dataElement: NACHC.B2.DE1 Hepatitis C Ag
  @activity: NACHC.B2 HCV test
  @description: HCV Test
*/
define "Hepatitis C Ag":
  [Observation: Cx."Hepatitis C Ag"]

/*
  @dataElement: NACHC.B2.DE4 Hepatitis C nucleic acid
  @activity: NACHC.B2 HCV test
  @description: HCV Test
*/
define "Hepatitis C nucleic acid":
  [Observation: Cx."Hepatitis C nucleic acid"]

/*
  @dataElement: NACHC.B2.DE40 Hepatitis C virus antibody test using Immunoblotting (IB) method
  @activity: NACHC.B2 HCV test
  @description: HCV Test
*/
define "Hepatitis C virus antibody test using Immunoblotting (IB) method":
  [Observation: Cx."Hepatitis C virus antibody test using Immunoblotting (IB) method"]

/*
  @dataElement: NACHC.B2.DE60 Hepatitis C virus antibody test
  @activity: NACHC.B2 HCV test
  @description: HCV Test
*/
define "Hepatitis C virus antibody test":
  [Observation: Cx."Hepatitis C virus antibody test"]

/*
  @dataElement: NACHC.B2.DE80 Hepatitis C virus nucleic (RNA) test
  @activity: NACHC.B2 HCV test
  @description: HCV Test
*/
define "Hepatitis C virus nucleic (RNA) test":
  [Observation: Cx."Hepatitis C virus nucleic (RNA) test"]

/*
  @dataElement: NACHC.C1.DE1 Syphilis
  @activity: NACHC.C1 Syphilis
  @description: Syphilis
*/
define "Syphilis":
  [Condition: Cx."Syphilis"]

/*
  @dataElement: NACHC.C1.DE184 Syphilis (Organism or Substance in Lab Results)
  @activity: NACHC.C1 Syphilis
  @description: Syphilis
*/
define "Syphilis (Organism or Substance in Lab Results)":
  [Condition: Cx."Syphilis (Organism or Substance in Lab Results)"]

/*
  @dataElement: NACHC.C1.DE191 Syphilis condition
  @activity: NACHC.C1 Syphilis
  @description: Syphilis
*/
define "Syphilis condition":
  [Condition: Cx."Syphilis condition"]

/*
  @dataElement: NACHC.C2.DE1 Syphilis (Tests for Treponema pallidum Nucleic Acid)
  @activity: NACHC.C2 Syphilis test
  @description: Syphilis Test
*/
define "Syphilis (Tests for Treponema pallidum Nucleic Acid)":
  [Observation: Cx."Syphilis (Tests for Treponema pallidum Nucleic Acid)"]

/*
  @dataElement: NACHC.C2.DE7 Syphilis (Tests for Treponemal or Non Treponemal Antibody)
  @activity: NACHC.C2 Syphilis test
  @description: Syphilis Test
*/
define "Syphilis (Tests for Treponemal or Non Treponemal Antibody)":
  [Observation: Cx."Syphilis (Tests for Treponemal or Non Treponemal Antibody)"]

/*
  @dataElement: NACHC.D1.DE1 Gonococcal Infections and Venereal Diseases
  @activity: NACHC.D1 Gonorrhea
  @description: Gonorrhea
*/
define "Gonococcal Infections and Venereal Diseases":
  [Condition: Cx."Gonococcal Infections and Venereal Diseases"]

/*
  @dataElement: NACHC.D1.DE184 Gonorrhea [Neisseria gonorrhoeae] (Organism or Substance in Lab Results)
  @activity: NACHC.D1 Gonorrhea
  @description: Gonorrhea
*/
define "Gonorrhea [Neisseria gonorrhoeae] (Organism or Substance in Lab Results)":
  [Condition: Cx."Gonorrhea [Neisseria gonorrhoeae] (Organism or Substance in Lab Results)"]

/*
  @dataElement: NACHC.D1.DE196 Gonorrhea [Neisseria species Unspecified] (Organism or Substance in Lab Results)
  @activity: NACHC.D1 Gonorrhea
  @description: Gonorrhea
*/
define "Gonorrhea [Neisseria species Unspecified] (Organism or Substance in Lab Results)":
  [Condition: Cx."Gonorrhea [Neisseria species Unspecified] (Organism or Substance in Lab Results)"]

/*
  @dataElement: NACHC.D1.DE201 Gonorrhea [Secondary Sites Complications Chronic] (Disorders)
  @activity: NACHC.D1 Gonorrhea
  @description: Gonorrhea
*/
define "Gonorrhea [Secondary Sites Complications Chronic] (Disorders)":
  [Condition: Cx."Gonorrhea [Secondary Sites Complications Chronic] (Disorders)"]

/*
  @dataElement: NACHC.D2.DE1 Gonorrhea Tests for Neisseria gonorrhea by Culture
  @activity: NACHC.D2 Gonorrhea test
  @description: Gonorrhea Test
*/
define "Gonorrhea Tests for Neisseria gonorrhea by Culture":
  [Observation: Cx."Gonorrhea Tests for Neisseria gonorrhea by Culture"]

/*
  @dataElement: NACHC.D2.DE100 Gonorrhea Tests and Chlamydia/Gonorrhea Combined Tests
  @activity: NACHC.D2 Gonorrhea test
  @description: Gonorrhea Test
*/
define "Gonorrhea Tests and Chlamydia/Gonorrhea Combined Tests":
  [Observation: Cx."Gonorrhea Tests and Chlamydia/Gonorrhea Combined Tests"]

/*
  @dataElement: NACHC.D2.DE16 Gonorrhea (Tests for Neisseria gonorrhoeae Nucleic Acid)
  @activity: NACHC.D2 Gonorrhea test
  @description: Gonorrhea Test
*/
define "Gonorrhea (Tests for Neisseria gonorrhoeae Nucleic Acid)":
  [Observation: Cx."Gonorrhea (Tests for Neisseria gonorrhoeae Nucleic Acid)"]

/*
  @dataElement: NACHC.D2.DE59 Gonorrhea (Tests for Neisseria species by Culture and Identification Method)
  @activity: NACHC.D2 Gonorrhea test
  @description: Gonorrhea Test
*/
define "Gonorrhea (Tests for Neisseria species by Culture and Identification Method)":
  [Observation: Cx."Gonorrhea (Tests for Neisseria species by Culture and Identification Method)"]

/*
  @dataElement: NACHC.D2.DE66 Gonorrhea test
  @activity: NACHC.D2 Gonorrhea test
  @description: Gonorrhea Test
*/
define "Gonorrhea test":
  [Observation: Cx."Gonorrhea test"]

/*
  @dataElement: NACHC.E1.DE1 Chlamydia
  @activity: NACHC.E1 Chlamydia
  @description: Chlamydia
*/
define "Chlamydia":
  [Condition: Cx."Chlamydia"]

/*
  @dataElement: NACHC.E1.DE26 Chlamydia Infections and Venereal Diseases
  @activity: NACHC.E1 Chlamydia
  @description: Chlamydia
*/
define "Chlamydia Infections and Venereal Diseases":
  [Condition: Cx."Chlamydia Infections and Venereal Diseases"]

/*
  @dataElement: NACHC.E1.DE31 Chlamydia trachomatis Infection [Secondary Sites Complications] (Disorders)
  @activity: NACHC.E1 Chlamydia
  @description: Chlamydia
*/
define "Chlamydia trachomatis Infection [Secondary Sites Complications] (Disorders)":
  [Condition: Cx."Chlamydia trachomatis Infection [Secondary Sites Complications] (Disorders)"]

/*
  @dataElement: NACHC.E1.DE62 Chlamydia trachomatis organism or Chlamydia trachomatis substance
  @activity: NACHC.E1 Chlamydia
  @description: Chlamydia
*/
define "Chlamydia trachomatis organism or Chlamydia trachomatis substance":
  [Condition: Cx."Chlamydia trachomatis organism or Chlamydia trachomatis substance"]

/*
  @dataElement: NACHC.E2.DE1 Chlamydia Screening
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Chlamydia Screening":
  [Observation: Cx."Chlamydia Screening"]

/*
  @dataElement: NACHC.E2.DE122 Chlamydia Trachomatis Tests, FPAR
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Chlamydia Trachomatis Tests, FPAR":
  [Observation: Cx."Chlamydia Trachomatis Tests, FPAR"]

/*
  @dataElement: NACHC.E2.DE124 Tests for Chlamydia trachomatis Antigen
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Tests for Chlamydia trachomatis Antigen":
  [Observation: Cx."Tests for Chlamydia trachomatis Antigen"]

/*
  @dataElement: NACHC.E2.DE153 Tests for Chlamydia trachomatis by Culture and Identification Method)
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Tests for Chlamydia trachomatis by Culture and Identification Method)":
  [Observation: Cx."Tests for Chlamydia trachomatis by Culture and Identification Method)"]

/*
  @dataElement: NACHC.E2.DE163 Tests for Chlamydia trachomatis Nucleic Acid
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Tests for Chlamydia trachomatis Nucleic Acid":
  [Observation: Cx."Tests for Chlamydia trachomatis Nucleic Acid"]

/*
  @dataElement: NACHC.E2.DE48 Chlamydia test
  @activity: NACHC.E2 Chlamydia test
  @description: Chlamydia Test
*/
define "Chlamydia test":
  [Observation: Cx."Chlamydia test"]

/*
  @dataElement: NACHC.F1.DE1 Drug Rehabilitation
  @activity: NACHC.F1 Injection Drug Use
  @description: Injection Drug Use
*/
define "Drug Rehabilitation":
  [Procedure: Cx."Drug Rehabilitation"]

/*
  @dataElement: NACHC.F1.DE12 Injection Findings
  @activity: NACHC.F1 Injection Drug Use
  @description: Injection Drug Use
*/
define "Injection Findings":
  [Observation: Cx."Injection Findings"]

/*
  @dataElement: NACHC.F1.DE15 IDU as a condition
  @activity: NACHC.F1 Injection Drug Use
  @description: Injection Drug Use
*/
define "IDU as a condition":
  [Condition: Cx."IDU as a condition"]

/*
  @dataElement: NACHC.F1.DE200 Injection Drug Use
  @activity: NACHC.F1 Injection Drug Use
  @description: Injection Drug Use
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
  @dataElement: NACHC.F3.DE1 Post Exposure Prophylaxis
  @activity: NACHC.F3 Post Exposure Prophylaxis
  @description: Post Exposure Prophylaxis
*/
define "Post Exposure Prophylaxis":
  [Procedure: Cx."Post Exposure Prophylaxis"]

