@IsTest
private class CaseServicesTest {
    @IsTest
    private static void getRelatedAssociations_EmptyCaseId_ReturnEmptyList() {
        // Arrange
        Id caseId = null;
        // Act
        Test.startTest();

        List<Association__c> associations = CaseServices.getRelatedAssociations(caseId);

        Test.stopTest();

        // Assert
        System.assert(associations.isEmpty());
    }

    @IsTest
    private static void getRelatedAssociations_ValidCaseId_ReturnRelatedAssociations() {
        // Arrange
        Legal_Case__c legalCase = [SELECT Id, (SELECT Id FROM Associations__r) FROM Legal_Case__c LIMIT 1];

        // Act
        Test.startTest();

        List<Association__c> associations = CaseServices.getRelatedAssociations(legalCase.Id);

        Test.stopTest();

        //Assert
        System.assertEquals(legalCase.Associations__r.size(), associations.size(), 'Returned incorrect amount.');
    }

    @IsTest
    private static void getRelatedMemberRoles_EmptyCaseId_ReturnEmptyList() {
        // Arrange
        Id caseId = null;
        // Act
        Test.startTest();

        List<Member_Role__c> memberRoles = CaseServices.getRelatedMemberRoles(caseId);

        Test.stopTest();
        // Assert
        System.assert(memberRoles.isEmpty());
    }

    @IsTest
    private static void getRelatedMemberRoles_ValidCaseId_ReturnRelatedAssociations() {
        // Arrange
        Legal_Case__c legalCase = [SELECT Id, (SELECT Id FROM Associations__r) FROM Legal_Case__c LIMIT 1];
        List<Member_Role__c> expectedMemberRoles = [
                SELECT Id
                FROM Member_Role__c
                WHERE Association__c IN :legalCase.Associations__r
        ];

        // Act
        Test.startTest();

        List<Member_Role__c> actualMemberRoles = CaseServices.getRelatedMemberRoles(legalCase.Id);

        Test.stopTest();

        //Assert
        System.assertEquals(expectedMemberRoles.size(), actualMemberRoles.size(), 'Returned incorrect amount.');
    }

    @TestSetup
    private static void setupData() {
        // Create and insert Accounts
        List<Account> accounts = TestDataFactory.createAccounts(2);

        accounts[0].Industry = 'Healthcare';
        accounts[1].Industry = 'Insurance';

        insert accounts;

        // Create and insert Contacts
        List<String> picklistValues = TestDataService.getPicklistValues('Member_Role__c', 'Role__c');
        List<Contact> contacts = TestDataFactory.createContacts(picklistValues.size());
        Id accountId = accounts[0].Id;

        for(Integer i = 0; i < contacts.size(); i++) {
            if(i == 2) {
                accountId = accounts[1].Id;
            }
            contacts[i].AccountId = accountId;
        }

        insert contacts;

        // Create and Insert Legal Cases
        List<Legal_Case__c> legalCases = TestDataFactory.createLegalCases(1);
        insert legalCases;

        // Create and Insert Associations
        List<Association__c> associations = TestDataFactory.createAssociations(2);

        for(Integer i = 0; i < accounts.size(); i++) {
            associations[i].Association__c = accounts[i].Id;
            associations[i].Case__c = legalCases[0].Id;
        }

        insert associations;

        // Create and Insert Member Roles
        Set<String> noAssociationRoles = new Set<String>{'Victim', 'Family Member'};
        List<Member_Role__c> memberRoles = TestDataFactory.createMemberRoles(picklistValues.size());

        Id associationId = associations[0].Id;
        for(Integer i = 0; i < memberRoles.size(); i++) {
            if(i == Math.round(memberRoles.size()/2)) {
                associationId = associations[1].Id;
            }
            memberRoles[i].Role__c = picklistValues[i];
            if(!noAssociationRoles.contains(memberRoles[i].Role__c)) {
                memberRoles[i].Association__c = associationId;
            }
        }

        insert memberRoles;
    }
}