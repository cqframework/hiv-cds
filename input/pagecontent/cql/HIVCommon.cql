library HIVCommon

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

include FHIRCommon called FC

context Patient

define function Official(identifiers List<Identifier>):
  singleton from (identifiers I where I.use = 'official')

define function Official(names List<HumanName>):
  singleton from (names N where N.use = 'official')

define function Only(observations List<Observation>):
  singleton from observations

define function Earliest(observations List<Observation>):
  First(
    observations O
      sort by issued
  )

define function Latest(observations List<Observation>):
  Last(
    observations O
      sort by issued
  )

define function MostRecent(observations List<Observation>):
  Last(
    observations O
      sort by issued
  )

define function Lowest(observations List<Observation>):
  First(
    observations O
      sort by (value as FHIR.Quantity)
  )

define function Highest(observations List<Observation>):
  Last(
    observations O
      sort by (value as FHIR.Quantity)
  )


/*
NOTE: Extensions are not the preferred approach, but are used as a way to access
content that is defined by extensions but not yet surfaced in the
CQL model info.
*/

define function QICoreModifierExtensions(domainResource DomainResource, url String):
  domainResource.modifierExtension E
    where E.url = ('http://hl7.org/fhir/us/qicore/StructureDefinition/' + url)
    return E

define function QICoreModifierExtension(domainResource DomainResource, url String):
  singleton from QICoreModifierExtensions(domainResource, url)

define function QICoreExtensions(domainResource DomainResource, url String):
  domainResource.extension E
    where E.url = ('http://hl7.org/fhir/us/qicore/StructureDefinition/' + url)
    return E

define function QICoreExtension(domainResource DomainResource, url String):
  singleton from QICoreExtensions(domainResource, url)

define function GetBaseModifierExtensions(domainResource DomainResource, url String):
  domainResource.modifierExtension E
	  where E.url = ('http://hl7.org/fhir/StructureDefinition/' + url)
		return E

define function GetBaseModifierExtension(domainResource DomainResource, url String):
  singleton from GetBaseModifierExtensions(domainResource, url)

define function GetBaseExtensions(domainResource DomainResource, url String):
  domainResource.extension E
	  where E.url = ('http://hl7.org/fhir/StructureDefinition/' + url)
		return E

define function GetBaseExtension(domainResource DomainResource, url String):
  singleton from GetBaseExtensions(domainResource, url)

define function GetUSModifierExtensions(domainResource DomainResource, url String):
  domainResource.modifierExtension E
	  where E.url = ('http://hl7.org/fhir/us/core/StructureDefinition/' + url)
		return E

define function GetUSModifierExtension(domainResource DomainResource, url String):
  singleton from GetUSModifierExtensions(domainResource, url)

define function GetUSExtensions(domainResource DomainResource, url String):
  domainResource.extension E
	  where E.url = ('http://hl7.org/fhir/us/core/StructureDefinition/' + url)
		return E

define function GetUSExtension(domainResource DomainResource, url String):
  singleton from GetUSExtensions(domainResource, url)

define function GetExtensionValue(extension Extension):
  extension.value.value

define function GetHIVExtensions(domainResource DomainResource, url String):
  domainResource.extension E
	  where E.url = ('http://fhir.org/guides/nachc/hiv-cds/StructureDefinition/' + url)
		return E

define function GetHIVExtension(domainResource DomainResource, url String):
  singleton from GetHIVExtensions(domainResource, url)


/* QI-CORE Extensions */
define function GetResourceNotDone(notDone DomainResource):
  QICoreModifierExtension(notDone, 'qicore-notDone')

define function GetResourceNotDoneReason(notDoneReason DomainResource):
  QICoreExtension(notDoneReason, 'qicore-notDoneReason')

define function GetResourceDoNotPerformReason(doNotPerformReason DomainResource):
  QICoreExtension(doNotPerformReason, 'qicore-doNotPerformReason')

define function GetResourceNotDoneRecorded(recorded DomainResource):
  QICoreExtension(recorded, 'qicore-recorded')

define function GetResourceNotDoneRecorded(choice Choice<FHIR.Observation, FHIR.Procedure, FHIR.MedicationAdministration, FHIR.MedicationDispense, FHIR.Communication>):
  case
    when choice is FHIR.Observation then
      QICoreExtension(choice as FHIR.Observation, 'qicore-recorded')
    when choice is FHIR.Procedure then
      QICoreExtension(choice as FHIR.Procedure, 'qicore-recorded')
    when choice is FHIR.MedicationAdministration then
      QICoreExtension(choice as FHIR.MedicationAdministration, 'qicore-recorded')
    when choice is FHIR.MedicationDispense then
      QICoreExtension(choice as FHIR.MedicationDispense, 'qicore-recorded')
    when choice is FHIR.Communication then
      QICoreExtension(choice as FHIR.Communication, 'qicore-recorded')
    else null
  end


define function GetSexualOrientation(resource DomainResource):
  GetHIVExtension(resource, 'sexualorientation')

define function GetGenderIdentity(resource DomainResource):
  GetHIVExtension(resource, 'genderidentity')


/* Common Resource Qualifications */
define function QualifiedEncounters(value List<FHIR.Encounter>):
  value Encounter
    where (
      //planned | arrived | triaged | in-progress | onleave | finished | cancelled | entered-in-error | unknown
      Encounter.status ~ 'arrived'
      or Encounter.status ~ 'in-progress'
      or Encounter.status ~ 'finished'
    )

define function QualifiedConditions(value List<FHIR.Condition>):
  value Condition
    where (
      FHIRHelpers.ToConcept(Condition.clinicalStatus) ~ FC."active"
    )
    and (
      FHIRHelpers.ToConcept(Condition.verificationStatus) ~ FC."confirmed"
    )

define function QualifiedProcedures(value List<FHIR.Procedure>):
  value Procedure
    where (
      //preparation | in-progress | not-done | on-hold | stopped | completed | entered-in-error | unknown
      Procedure.status ~ 'completed'
    )

define function QualifiedObservations(value List<FHIR.Observation>):
  value Observation
		where (
      //registered | preliminary | final | amended | corrected | cancelled | entered-in-error | unknown
      Observation.status ~ 'preliminary'
      or Observation.status ~ 'final'
			or Observation.status ~ 'amended'
			or Observation.status ~ 'corrected'
		)

define function QualifiedMedicationRequests(value List<FHIR.MedicationRequest>):
  value MedicationRequest
    where (
      //active | on-hold | cancelled | completed | entered-in-error | stopped | draft | unknown
      (MedicationRequest.status ~ 'active'
        or MedicationRequest.status ~ 'completed'
      )
        and (
          MedicationRequest.doNotPerform is null
          or MedicationRequest.doNotPerform = false
        )
    )

define function QualifiedMedicationStatements(value List<FHIR.MedicationStatement>):
  value MedicationStatement
    where (
      // active | completed | entered-in-error | intended | stopped | on-hold | unknown | not-taken
      MedicationStatement.status ~ 'active'
      or MedicationStatement.status ~ 'completed'
    )

define function QualifiedMedicationDispenses(value List<FHIR.MedicationDispense>):
  value MedicationDispense
    // preparation | in-progress | cancelled | on-hold | completed | entered-in-error | stopped | declined | unknown
    where (
      MedicationDispense.status ~ 'preparation'
      or MedicationDispense.status ~ 'in-progress'
      or MedicationDispense.status ~ 'completed'
    )
