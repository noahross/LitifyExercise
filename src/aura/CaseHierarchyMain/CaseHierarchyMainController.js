({
    doInit: function(component, event, helper) {
        var action = component.get("c.instantiateMain");
        action.setParam("caseId", component.get("caseId"));

        action.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS' && component.isValid()) {
                var main = response.getReturnValue();
                component.set("v.case", main.legalCase);
                component.set("v.associations", main.associations);
                component.set("v.roles", main.roles);
            }
        });

        $A.enqueueAction(action);
    }
});