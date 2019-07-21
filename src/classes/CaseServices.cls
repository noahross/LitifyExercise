public with sharing class CaseServices {
    public static List<Association__c> getRelatedAssociations(Id caseId) {
        if(caseId == null) {
            return new List<Association__c>();
        }

        return [
            SELECT Id,
                    Name,
                    Association__c,
                    Association__r.Name,
                    Association__r.Industry,
                    OwnerId,
                    Owner.Name,
                    Case__c
            FROM Association__c
            WHERE Case__c = :caseId
        ];
    }

    public static List<Association__c> getRelatedAssociationsWithRoles(Id caseId) {
        if(caseId == null) {
            return new List<Association__c>();
        }

        return [
                SELECT Id,
                        Name,
                        Association__c,
                        Association__r.Name,
                        Association__r.Industry,
                        OwnerId,
                        Owner.Name,
                        Case__c,
                (
                        SELECT Id,
                                Name,
                                Role__c,
                                Member__c,
                                Member__r.Name,
                                Association__c
                        FROM Member_Roles__r
                )
                FROM Association__c
                WHERE Case__c = :caseId
        ];
    }

    public static List<Member_Role__c> getRelatedMemberRoles(Id caseId) {
        if(caseId == null) {
            return new List<Member_Role__c>();
        }

        return [
                SELECT Id,
                        Name,
                        Role__c,
                        Member__c,
                        Member__r.Name,
                        Association__c,
                        Association__r.Name,
                        Association__r.Case__c
                FROM Member_Role__c
                WHERE Association__r.Case__c = :caseId
        ];
    }
}