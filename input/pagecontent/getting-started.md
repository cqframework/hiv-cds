### Overview

This implementation guide provides technical artifacts to aid in the implementation of appropriate HIV screening. The artifacts include data element definitions, data collection questionnaires, and logic for determining HIV risk and appropriate screening and follow-up.

The artifacts in this implementation guide consist of:

* **[Terminology](#terminology)**: FHIR [value sets](http://hl7.org/fhir/valueset.html) containing groups of standard codes used to represent concepts in the HIV screening artifacts
* **[Data Elements](#data-elements)**: FHIR [profiles](http://hl7.org/fhir/profiling.html) defining the data elements used in HIV screening artifacts
* **[Questionnaires](#questionnaires)**: FHIR [questionnaires](http://hl7.org/fhir/questionnaire.html) defining data to be collected
* **[Rules](#rules)**: FHIR [rules](https://hl7.org/fhir/clinicalreasoning-knowledge-artifact-representation.html#event-condition-action-rule) defining when activities should be recommended

### Minimal integration

A minimal integration approach would be to use the Risk Factors questionnaire to collect specific information related to assessing patient risk, enabling the decision support for risk factor determination to evaluate and recommend a screening test based on that risk. The Drug Abuse Screening Test (DAST-10) questionnaire could also be used as part of this integration.

### Implementation

The artifacts in this implementation guide can be used in the following ways:

* **[Reference](#reference)**: The artifacts can be used as a reference for implementing HIV screening within existing clinical system software capabilities.
* **[Ingestion](#ingestion)**: For systems that support import of clinical quality improvement artifacts, the artifacts can be used either directly, or through transformation to another format.
* **[Integration](#integration)**: The artifacts can be used by configuring existing systems to invoke applications and/or services that can use the technical artifacts in this implementation guide directly.

#### Reference

As a reference, the artifacts in this implementation guide can be used as a blueprint to implement HIV screening practices by configuring existing software capabilities based on the artifacts provided here. For example, the value sets and questionnaires provided here can be copied into existing customization editors such as a value set builder or form builder. In addition, the logic provided for determining screening appropriateness can be used as a reference to create equivalent logic in a clinical system's configurable rules engine.

#### Ingestion

For systems that support importing artifacts such as questionnaires and rules, the artifacts can be used either directly, if the clinical systems support import of [HL7 FHIR CPG-compliant](https://hl7.org/fhir/uv/cpg) artifacts, or they can be transformed into the format accepted by the clinical system. For example, many clinical systems support import of questionnaires and form definitions using system-specific formats.

#### Integration

Open source services and applications exist that are capable of rendering the technical artifacts in this implementation guide including questionnaire-rendering, decision support services, and with some additional development effort, custom SMART-on-FHIR applications. There are two main integration approaches:

* **[Services](#services)**: Integration via a service integration such as CDS Hooks
* **[Application](#application)**: Integration via a SMART-on-FHIR application

##### Services

Integration as a service is most commonly implemented via [HL7 CDS Hooks](https://cds-hooks.hl7.org), though for systems that do not support the CDS Hooks standard, service integration is still possible if the clinical system supports a decision support service integration. For more information on this approach, refer to the [Architecture](architecture.html) topic in this guide.

##### Application

There are existing open source [SMART-on-FHIR](https://www.hl7.org/fhir/smart-app-launch/) applications that support rendering questionnaires (both patient-facing and provider-facing), as well as more general provider-facing capabilities such as summary and management dashboards and shared decision making. This approach is the most flexible, but requires custom development, generally starting from one of the existing open source applications, such as:

* https://github.com/cqframework/AHRQ-CDS-Connect-PAIN-MANAGEMENT-SUMMARY
* https://github.com/cqframework/cds4cpm-mypain
* https://github.com/asbi-cds-tools/asbi-screening-app
* https://github.com/asbi-cds-tools/asbi-intervention-app

### Use Case: Building the HIV CDS Tool for an AthenaOne client 

Building the HIV CDS Tool for an athenaOne client differs from implementation with a FHIR server in several ways. Methods described below were arrived at as an output of collaboration between Healthflow.io, athenahealth, and NACHC in order to fulfill the goals stated in the implementation guide found at https://build.fhir.org/ig/cqframework/hiv-cds/ . Key differences are listening strategies, data endpoints for storage which can be described as consistent and inconsistent endpoints, and chart alteration as an alternative to messaging. Where an endpoint is mentioned (example EP1) the corresponding RESTful API can be found in the chart at the end of the document (figure 1).

To start, as of the writing of this report there are no pub/sub design patterns such as webhooks that exist for interacting with Athena. Polling has to substitute for these functions and requires two steps to set up. First requesting a cache using EP,1 and then using EP2 to retrieve a list of changes since the last poll. Athena’s standard is that polling should be no more frequent than every 2 minutes. The request will result in a list of appointments that each correspond to a clinical encounter and a patient. After filtering down to only appointments that correspond to an encounter that is open, any information needed for future EPs can be captured. Closed encounters cannot be altered using the methods described below and can be discarded. Conceptually, this corresponds to the idea that the program will be providing information to a provider in real time, during a visit with a patient. 

Using the information captured in the previous process, a program should be able to access EP3 through EP5 in order to collect patient data. These three endpoints fall into the category of consistent data, which meets the criteria of accessibility and availability in the same way across an athenaOne based practice. Patient objects, Labresult objects, and Problems objects are universally supported with the same structure across all Athena. Additional filtering through the response by SNOMED, ICD9, and ICD10 codes for relevant data will be necessary. A list of some but not all relevant codes can be found in Fig . Inconsistent data meets the criteria that it is limited to a subset of practices and are designed as proprietary to a specific practice or group of practices. Information that falls under this category tends to be qualitative data about a patient’s life or social history such as Social Determinants of Health. Coordinating with staff from the practice that this is developed for will be required to discover how this information is stored and how to retrieve it.

Athena has no support for a pop up message or a disruptive alert to notify the provider that is seeing the patient. Instead an alteration to the patient chart by modifying their open encounter will be necessary to accomplish this goal. Use EP6 to append new information to the end of an encounter-reason so that when the provider checks they’ll see any recommendations provided by the CDS Tool.

Following this guide and using Athena’s standards for security will result in a solution for patient data retrieval for analysis that is approved by Athena’s support group and enables sufficient data for review of the CDS Tool as described by NACHC.

**Figure 1**
| Endpoint | Method |
|----------|--------|
| EP1      | POST   |
| | /v1/{practiceid}/appointments/changed/subscription |   
| EP2      | GET    |
| |/v1/{practiceid}/appointments/changed |   
| EP3      | GET    |
| | /v1/{practiceid}/patients/{patientid} |   
| EP4      | GET    |
| | /v1/{practiceid}/chart/{patientid}/labresults |   
| EP5      | GET    |
| | /v1/{practiceid}/chart/{patientid}/problems |   
| EP6      | POST   |
| | /v1/{practiceid}/chart/encounter/{encounterid}/encounterreasonnote |   

**Figure 2**

```

"RELEVANT_DIAGNOSES_CODES" : {
       "ICD10": {
           “Chlamydia”: ["A55" , "A56" , "A71" , "A74.9"] , 
					 “Gonorrhea”: ["A54"] ,
           “HepC”: ["B18.2" , "B17.1" , "B19.2"] , 
           “Syphilis”: [ "A50" , "A51" , "A52" , "A53" ] ,
           “Tuberculosis”: ["A15" , "A16" , "A17" ,
           "A18" , "A19" ] , 
    “HIV”: [ "B20" ] , 
 },
       "ICD9": {
           “Chlamydia”: ["099.5"] , 
           “Gonorrhea”: ["098"] , 
           “HepC”: ["070.41" , "070.44" , "070.51" ,
           "070.54" , "070.7" ] , 
           “Syphilis”: ["090" , "091" , "092" ,

```

