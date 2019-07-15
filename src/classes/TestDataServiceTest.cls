/**
 * Created by neoroosta on 7/14/19.
 */

@IsTest
private class TestDataServiceTest {
    @IsTest
    private static void validateGenericFactory() {
        List<Map<String,Object>> fieldMaps = TestDataService.populateMandatoryFields('Account');
        Map<String,Object> fieldToValue = fieldMaps[0];
        Map<String,Integer> incrementFieldToLength = (Map<String,Integer>)fieldMaps[1];

        List<Account> accs = (List<Account>)TestDataService.genericFactory(40, 'Account', fieldToValue, incrementFieldToLength);
        System.assertEquals(40,accs.size());

        Map<String,sObject> accNameMap = Utility.mapetize(accs,'Name');
        Set<String> accString = Utility.setitize(accs,'Name');

        fieldMaps = TestDataService.populateMandatoryFields('Contact');
        fieldToValue = fieldMaps[0];
        incrementFieldToLength = (Map<String,Integer>)fieldMaps[1];

        List<Contact> cons = (List<Contact>)TestDataService.genericFactory(40, 'Contact', fieldToValue, incrementFieldToLength);
        System.assertEquals(40,cons.size());

        cons = Utility.uniformUpdateFields(cons,fieldToValue);

        Map<String,Schema.SObjectType> typesMap = Schema.getGlobalDescribe();
        List<String> types = new List<String>();
        for(String s : typesMap.keySet()) {
            if(typesMap.get(s).getDescribe().isCreateable()) {
                types.add(s);
            }
        }
        Integer max = 20;
        if(types.size() < 20) {
            max = types.size();
        }
        for(Integer i=0;i<max;i++) {
            fieldMaps = TestDataService.populateMandatoryFields(types[i]);
            fieldToValue = fieldMaps[0];
            incrementFieldToLength = (Map<String,Integer>)fieldMaps[1];

            List<sObject> objs = TestDataService.genericFactory(40, types[i], fieldToValue, incrementFieldToLength);
            System.assertEquals(40,objs.size());
        }
    }

    @IsTest
    private static void validateGetPicklistValues() {
        TestDataService.getPicklistValues('Account','Type');
    }

    @IsTest
    private static void validateAddLeadingZeroes() {
        System.assertEquals('0000352',Utility.addLeadingZeroes(7, '352'));
    }
}