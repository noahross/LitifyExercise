public with sharing class TestDataService {
    // Used to create sObject records for insertion of test data
    public static List<sObject> genericFactory(Integer amount, String sObjName, Map<String, Object> fieldToValue, Map<String, Integer> incrementFieldToLength) {
        List<sObject> sObjects = new List<sObject>();
        Schema.SObjectType t = Schema.getGlobalDescribe().get(sObjName);
        for (Integer i = 0; i < amount; i++) {
            sObject o = t.newSObject();
            for (String s : fieldToValue.keySet()) {
                if (!incrementFieldToLength.containsKey(s)) {
                    o.put(s, fieldToValue.get(s));
                } else {
                    o.put(s, fieldToValue.get(s) + Utility.addLeadingZeroes(incrementFieldToLength.get(s), String.valueOf(i)));
                }
            }
            sObjects.add(o);
        }
        return sObjects;
    }

    // Populates mandatory fields as two Maps
    // [0] is String (fieldName) to Object (value)
    // [1] is String (fieldName) of any fields to be incremented to Object (desiredIncrementLength) which must be cast to Map<String,Integer>
    public static List<Map<String, Object>> populateMandatoryFields(String sObjName) {
        List<Map<String, Object>> finalMaps = new List<Map<String, Object>>();
        Set<String> stringTypes = new Set<String>{
                'string', 'address', 'anytype', 'combobox', 'textarea', 'phone', 'url', 'email'
        };
        Set<String> numberTypes = new Set<String>{
                'currency', 'double', 'integer'
        };
        Set<String> picklistTypes = new Set<String>{
                'picklist', 'multipicklist'
        };
        Map<String, String> mandatoryFields = TestDataService.getMandatoryFields(sObjName);
        Map<String, Object> fieldToValue = new Map<String, Object>();
        Map<String, Integer> incrementFieldToLength = new Map<String, Integer>();
        for (String s : mandatoryFields.keySet()) {
            String fieldType = mandatoryFields.get(s).toLowerCase();
            if (stringTypes.contains(fieldType)) {
                if (fieldType == 'phone') {
                    fieldToValue.put(s, '602-555-');
                } else if (fieldType == 'url') {
                    fieldToValue.put(s, 'www.testdata.com/');
                } else if (fieldType == 'email') {
                    fieldToValue.put(s,'test@test.com');
                } else {
                    fieldToValue.put(s, 'Test Data');
                }
                incrementFieldToLength.put(s, 4);
            }
            if (numberTypes.contains(fieldType)) {
                if (fieldType == 'integer') {
                    fieldToValue.put(s, 1);
                } else {
                    fieldToValue.put(s, 1.00);
                }
            }
            if (fieldType == 'boolean') {
                fieldToValue.put(s, false);
            }
            if (fieldType == 'date') {
                fieldToValue.put(s, Date.today());
            }
            if (fieldType == 'time') {
                fieldToValue.put(s, System.now().time());
            }
            if (fieldType == 'datetime') {
                fieldToValue.put(s, System.now());
            }
            if (picklistTypes.contains(fieldType)) {
                String value = '';
                List<String> values = TestDataService.getPicklistValues(sObjName, s);
                if (values.size() > 0) {
                    value = values[0];
                }
                fieldToValue.put(s, value);
            }
        }
        finalMaps.add(fieldToValue);
        finalMaps.add(incrementFieldToLength);
        return finalMaps;
    }

    // Returns fieldName to Type of all mandatory fields on an sObject, excluding fields made mandatory via Validation Rules or Triggers.
    public static Map<String, String> getMandatoryFields(String sObjName) {
        Map<String, String> mandatoryFields = new Map<String, String>();
        if(Schema.getGlobalDescribe().get(sObjName) != null) {
            for (Schema.sObjectField f : Schema.getGlobalDescribe().get(sObjName).getDescribe().fields.getMap().values()) {
                if (isFieldMandatory(f) && isFieldWriteable(f, false) && f.getDescribe().getName() != 'OwnerId') {
                    mandatoryFields.put(f.getDescribe().getName(), String.valueOf(f.getDescribe().getType()));
                }
            }
        }
        return mandatoryFields;
    }

    // Returns true if field is mandatory and false otherwise
    public static Boolean isFieldMandatory(Schema.sObjectField field) {
        return !field.getDescribe().isNillable();
    }

    // Returns true if field is writeable and false otherwise
    public static Boolean isFieldWriteable(Schema.sObjectField field, Boolean up) {
        return field.getDescribe().isAccessible() && ((field.getDescribe().isCreateable() && !up) || (field.getDescribe().isUpdateable() && up));
    }

    // Returns a list of picklist values for a given field on a given sObject
    public static List<String> getPicklistValues(String sObjName, String field) {
        List<String> fields = new List<String>();
        for (Schema.PicklistEntry e : Schema.getGlobalDescribe().get(sObjName).getDescribe().fields.getMap().get(field).getDescribe().getPicklistValues()) {
            fields.add(e.getValue());
        }
        return fields;
    }
}