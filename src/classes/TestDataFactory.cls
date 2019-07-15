public with sharing class TestDataFactory {
    // Returns a list of SObjects with all fields designated required filled
    public static List<SObject> createSObjects(String sObjectName, Integer amount) {
        List<Map<String,Object>> fieldMaps = TestDataService.populateMandatoryFields(sObjectName);
        Map<String,Object> fieldToValue = fieldMaps[0];
        Map<String,Integer> incrementFieldToLength = (Map<String,Integer>)fieldMaps[1];

        return TestDataService.genericFactory(amount, sObjectName, fieldToValue, incrementFieldToLength);
    }

    public static List<Account> createAccounts(Integer amount) {
        return (List<Account>)createSObjects('Account', amount);
    }

    public static List<Contact> createContacts(Integer amount) {
        return (List<Contact>)createSObjects('Contact', amount);
    }

    public static List<Legal_Case__c> createLegalCases(Integer amount) {
        return (List<Legal_Case__c>)createSObjects('Legal_Case__c', amount);
    }

    public static List<Association__c> createAssociations(Integer amount) {
        return (List<Association__c>)createSObjects('Association__c', amount);
    }

    public static List<Member_Role__c> createMemberRoles(Integer amount) {
        return (List<Member_Role__c>)createSObjects('Member_Role__c', amount);
    }
}