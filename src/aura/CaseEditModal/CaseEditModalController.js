/**
 * Created by neoro on 7/20/2019.
 */

({
    doInit: function(component, event, helper) {

    },

    changeHierarchy: function(component, event, helper) {
        console.log("changeHierarchy called.");
        var record = {};
        //var fullJSON = JSON.stringify(event.getParams());
        //console.log("fullJSON: ", fullJSON);
        var apiName = event.getParams().apiName;
        console.log("apiName: ", apiName);
        if(apiName === "Member_Role__c") {
            var memberRole = event.getParams().fields;
            console.log("memberRole: ", memberRole);
            record.Id = event.getParams().id;
            console.log(record.Id);
            record.Name = memberRole.Name.value;
            console.log(record.Name);
            record.Role__c = memberRole.Role__c.value;
            console.log(record.Role__c);
            record.Member__c = memberRole.Member__c.value;
            var member = {};
            member.Name = memberRole.Member__r.value.fields.Name.value;
            record.Member__r = member;
            console.log(record.Member__r.Name);
            record.Association__c = memberRole.Association__c.value;
            console.log(record.Association__c);
            console.log(record);
        }
        var changeType = "update";
        if(component.get("v.recordId") === undefined) {
            changeType = "add";
        }
        helper.fireEvent(component, event, changeType, record);
    },

    closeEditPanel: function(component, event, helper) {
        helper.fireEvent(component, event, "", {});
    }
});