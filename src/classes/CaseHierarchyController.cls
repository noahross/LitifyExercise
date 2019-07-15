public with sharing class CaseHierarchyController {
    @AuraEnabled
    public static CaseHierarchyModels.Main instantiateMain(Id caseId) {
        return new CaseHierarchyModels.Main(caseId);
    }

}