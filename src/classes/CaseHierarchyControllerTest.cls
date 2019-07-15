/**
 * Created by neoroosta on 7/14/19.
 */

@IsTest
private class CaseHierarchyControllerTest {
    @IsTest
    private static void instantiateMain_nullId_EmptyLists() {
        // Arrange
        Id caseId = null;

        // Act
        Test.startTest();

        CaseHierarchyModels.Main main = CaseHierarchyController.instantiateMain(caseId);

        Test.stopTest();

        // Assert
        System.assertEquals(null, main.legalCase.Id, 'constructor returned Legal Case.');
        System.assert(main.associations.isEmpty(), 'Association list not empty.');
        System.assert(main.memberRoles.isEmpty(), 'Member Roles list not empty.');
    }

    @IsTest
    private static void instantiateMain_validId_ComponentFullyPopulated() {
        // Arrange
        Id caseId = [
                SELECT Id
                FROM Legal_Case__c
                LIMIT 1
        ].Id;

        // Act
        Test.startTest();

        CaseHierarchyModels.Main main = CaseHierarchyController.instantiateMain(caseId);

        Test.stopTest();

        // Assert
        System.assertEquals(caseId, main.legalCase.Id, 'constructor returned erroneous Legal Case.');
        System.assert(!main.associations.isEmpty(), 'Association list is empty.');
        System.assert(!main.memberRoles.isEmpty(), 'Member Roles list is empty.');

        for(Association__c association : main.associations) {
            System.assertEquals(caseId, association.Case__c, 'Association related to different Legal Case.');
        }

        for(Member_Role__c memberRole : main.memberRoles) {
            System.assertEquals(caseId, memberRole.Association__r.Case__c, 'Role related to different Legal Case.');
        }
    }

    @TestSetup
    private static void setupData() {
        // Create and insert Accounts
        List<Account> accounts = TestDataFactory.createAccounts(1);

        accounts[0].Industry = 'Healthcare';

        insert accounts;

        // Create and insert Contacts
        List<String> picklistValues = TestDataService.getPicklistValues('Member_Role__c', 'Role__c');
        List<Contact> contacts = TestDataFactory.createContacts(picklistValues.size());

        for(Integer i = 0; i < contacts.size(); i++) {
            contacts[i].AccountId = accounts[0].Id;
        }

        insert contacts;

        // Create and Insert Legal Cases
        List<Legal_Case__c> legalCases = TestDataFactory.createLegalCases(1);
        insert legalCases;

        // Create and Insert Associations
        List<Association__c> associations = TestDataFactory.createAssociations(1);

        associations[0].Association__c = accounts[0].Id;
        associations[0].Case__c = legalCases[0].Id;

        insert associations;

        // Create and Insert Member Roles
        // TODO: Can there be Roles without Associations?
        Set<String> noAssociationRoles = new Set<String>{'Victim', 'Family Member'};
        List<Member_Role__c> memberRoles = TestDataFactory.createMemberRoles(picklistValues.size());

        for(Integer i = 0; i < memberRoles.size(); i++) {
            memberRoles[i].Role__c = picklistValues[i];
            if(!noAssociationRoles.contains(memberRoles[i].Role__c)) {
                memberRoles[i].Association__c = associations[0].Id;
            }
        }

        insert memberRoles;
    }
}