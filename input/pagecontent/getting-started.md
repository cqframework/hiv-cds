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


