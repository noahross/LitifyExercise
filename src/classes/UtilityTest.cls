@IsTest
public with sharing class UtilityTest {
    @IsTest
    private static void validateSetAndMapetize() {
        Map<String,Account> nameToAccountMap = new Map<String,Account>();
        nameToAccountMap.put('Test Account',new Account(Name = 'Test Account'));
        nameToAccountMap.put('Test Account 2',new Account(Name = 'Test Account 2'));
        List<Account> accounts = new List<Account>();
        for(Account acc : nameToAccountMap.values()) {
            accounts.add(acc);
        }
        Test.startTest();
        Set<String> accNames = Utility.setitize(accounts,'Name');
        Map<String,sObject> accMap = Utility.mapetize(accounts,'Name');
        Test.stopTest();
        System.assertEquals(nameToAccountMap.keySet(),accNames,'Sets are not identical.');
        System.assertEquals(nameToAccountMap.keySet(),accMap.keySet(), 'Key sets are not identical.');
        for(String accName : nameToAccountMap.keySet()) {
            System.assertEquals(nameToAccountMap.get(accName),(Account)accMap.get(accName), 'Accounts do not match.');
        }
    }

    @IsTest
    private static void validateAddLeadingZeroes() {
        System.assertEquals('0000352',Utility.addLeadingZeroes(7, '352'));
    }
}