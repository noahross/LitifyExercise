/**
 * Created by neoro on 7/20/2019.
 */

({
    changeHierarchy: function(component, event, helper) {
        var record = {};
        var apiName = event.getParams().apiName;

        if(apiName === "Member_Role__c") {
            var memberRole = event.getParams().fields;
            record.Id = event.getParams().id;
            record.Name = memberRole.Name.value;
            record.Role__c = memberRole.Role__c.value;
            record.Member__c = memberRole.Member__c.value;
            var member = {};
            member.Name = memberRole.Member__r.value.fields.Name.value;
            record.Member__r = member;
            record.Association__c = memberRole.Association__c.value;
            var changeType = "update";
            if(component.get("v.recordId") === undefined) {
                changeType = "add";
            }
            helper.fireEvent(component, event, changeType, record);
        }
    },

    closeEditPanel: function(component, event, helper) {
        helper.fireEvent(component, event, "", {});
    }
});