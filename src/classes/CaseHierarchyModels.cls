public with sharing class CaseHierarchyModels {
    public class Main {
        @AuraEnabled
        public Legal_Case__c legalCase = new Legal_Case__c();
        @AuraEnabled
        public List<Association__c> associations = new List<Association__c>();
        @AuraEnabled
        public List<Member_Role__c> memberRoles = new List<Member_Role__c>();

        public Main(Id caseId) {
            if(caseId != null) {
                this.legalCase = [
                        SELECT Id,
                                Name
                        FROM Legal_Case__c
                        WHERE Id = :caseId
                        LIMIT 1
                ];

                this.associations = CaseServices.getRelatedAssociations(caseId);
                this.memberRoles = CaseServices.getRelatedMemberRoles(caseId);
            }
        }

    }
}