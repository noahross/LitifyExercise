/**
 * Created by neoroosta on 7/14/19.
 */

@IsTest
private class TestDataFactoryTest {
    @IsTest
    private static void createSObjects_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<SObject> sObjects = TestDataFactory.createSObjects('Account', 0);

        Test.stopTest();

        // Assert
        System.assert(sObjects.isEmpty(), 'SObjects created erroneously.');
    }

    @IsTest
    private static void createSObjects_InvalidSObjectName_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<SObject> sObjects = TestDataFactory.createSObjects('', 0);

        Test.stopTest();

        // Assert
        System.assert(sObjects.isEmpty(), 'SObjects created erroneously.');
    }

    @IsTest
    private static void createAccounts_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<Account> accounts = TestDataFactory.createAccounts(0);

        Test.stopTest();

        // Assert
        System.assert(accounts.isEmpty(), 'Accounts created erroneously.');
    }

    @IsTest
    private static void createAccounts_5_5AccountsInList() {
        // Arrange
        // Act
        Test.startTest();

        List<Account> accounts = TestDataFactory.createAccounts(5);

        Test.stopTest();

        // Assert
        System.assertEquals(5, accounts.size(), 'Incorrect number of accounts.');
    }

    @IsTest
    private static void createContacts_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<Contact> contacts = TestDataFactory.createContacts(0);

        Test.stopTest();

        // Assert
        System.assert(contacts.isEmpty(), 'Contacts created erroneously.');
    }

    @IsTest
    private static void createContacts_5_5AccountsInList() {
        // Arrange
        // Act
        Test.startTest();

        List<Contact> contacts = TestDataFactory.createContacts(5);

        Test.stopTest();

        // Assert
        System.assertEquals(5, contacts.size(), 'Incorrect number of Contacts.');
    }

    @IsTest
    private static void createLegalCases_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<Legal_Case__c> legalCases = TestDataFactory.createLegalCases(0);

        Test.stopTest();

        // Assert
        System.assert(legalCases.isEmpty(), 'Legal Cases created erroneously.');
    }

    @IsTest
    private static void createLegalCases_5_5AccountsInList() {
        // Arrange
        // Act
        Test.startTest();

        List<Legal_Case__c> legalCases = TestDataFactory.createLegalCases(5);

        Test.stopTest();

        // Assert
        System.assertEquals(5, legalCases.size(), 'Incorrect number of Legal Cases.');
    }

    @IsTest
    private static void createAssociations_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<Association__c> associations = TestDataFactory.createAssociations(0);

        Test.stopTest();

        // Assert
        System.assert(associations.isEmpty(), 'Associations created erroneously.');
    }

    @IsTest
    private static void createAssociations_5_5AccountsInList() {
        // Arrange
        // Act
        Test.startTest();

        List<Association__c> associations = TestDataFactory.createAssociations(5);

        Test.stopTest();

        // Assert
        System.assertEquals(5, associations.size(), 'Incorrect number of associations.');
    }

    @IsTest
    private static void createMemberRoles_0_EmptyList() {
        // Arrange
        // Act
        Test.startTest();

        List<Member_Role__c> memberRoles = TestDataFactory.createMemberRoles(0);

        Test.stopTest();

        // Assert
        System.assert(memberRoles.isEmpty(), 'Member Roles created erroneously.');
    }

    @IsTest
    private static void createMemberRoles_5_5AccountsInList() {
        // Arrange
        // Act
        Test.startTest();

        List<Member_Role__c> memberRoles = TestDataFactory.createMemberRoles(5);

        Test.stopTest();

        // Assert
        System.assertEquals(5, memberRoles.size(), 'Incorrect number of Member Roles.');
    }
}