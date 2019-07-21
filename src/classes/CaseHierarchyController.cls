public with sharing class CaseHierarchyController {
    @AuraEnabled
    public static CaseHierarchyModels.Main instantiateMain(String caseId) {
        return new CaseHierarchyModels.Main((Id)caseId);
    }

}