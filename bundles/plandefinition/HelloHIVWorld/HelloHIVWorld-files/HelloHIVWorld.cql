library HelloHIVWorld version '1.0.0'

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

valueset "Indicators of Human Immunodeficiency Virus (HIV)": 'http://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1056.52'

context Patient

define "Patient Has HIV":
  exists "Condition Indicating HIV"

define "Patient Name":
  First(Patient.name.given)
   + ' ' +
  First(Patient.name.family)

define "Condition Indicating HIV":
  ["Condition": "Indicators of Human Immunodeficiency Virus (HIV)"]
