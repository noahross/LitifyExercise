public with sharing class Utility {
    //Turns list into String set using fieldName
    public static Set<String> setitize(List<sObject> records, String fieldName) {
        Set<String> newSet = new Set<String>();
        for(sObject record : records) {
            newSet.add(String.valueOf(record.get(fieldName)));
        }
        return newSet;
    }

    //Turns list into map using fieldName
    public static Map<String,sObject> mapetize(List<sObject> records, String fieldName) {
        Map<String,sObject> newMap = new Map<String,sObject>();
        for(sObject record : records) {
            newMap.put(String.valueOf(record.get(fieldName)),record);
        }
        return newMap;
    }

    // Populates fields in keySet with the corresponding values for every record in list and returns list without DML
    public static List<sObject> uniformUpdateFields(List<sObject> sObjects, Map<String, Object> fieldToValue) {
        for (sObject sObj : sObjects) {
            for (String s : fieldToValue.keySet()) {
                sObj.put(s, fieldToValue.get(s));
            }
        }
        return sObjects;
    }

    // Adds leading Zeroes to a startString to achieve the length desired
    public static String addLeadingZeroes(Integer length, String startString) {
        String finalString = '';
        Integer amount = length - startString.length();
        for (Integer i = 0; i < amount; i++) {
            finalString += '0';
        }
        finalString += startString;
        return finalString;
    }
}