public with sharing class CaseHierarchyModels {
    public class Main {
        @AuraEnabled
        public List<Association__c> associations = new List<Association__c>();

        public Main(Id caseId) {
            System.debug('constructor on Main called.');
            if(caseId != null) {
                this.associations = CaseServices.getRelatedAssociationsWithRoles(caseId);
            }
        }

    }
}