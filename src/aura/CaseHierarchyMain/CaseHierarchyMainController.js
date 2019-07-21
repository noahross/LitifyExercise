({
    doInit: function(component, event, helper) {
        var action = component.get("c.instantiateMain");
        action.setParam("caseId", component.get("v.recordId"));

        action.setCallback(this, function(response) {
            if(response.getState() === 'SUCCESS' && component.isValid()) {
                var main = response.getReturnValue();
                var associations = main.associations;
                component.set("v.associations", associations);

                var items = [];
                var count = 1;
                for(var i = 0; i < associations.length; i++) {
                    var item = helper.createAssociationItem(component, event, associations[i]);
                    count++;

                    var roles = associations[i].Member_Roles__r;
                    var roleItems = [];
                    for(var r = 0; r < roles.length; r++) {
                        var roleItem = helper.createMemberRoleItem(component, event, roles[r]);
                        count++;
                        roleItems.push(roleItem);
                    }

                    if(roleItems.length > 0) {
                        item.items = roleItems;
                    }
                    items.push(item);
                }

                component.set("v.items", items);
            }
        });

        $A.enqueueAction(action);
    },

    changeHierarchy: function(component, event, helper) {
        var record = event.getParam("record");
        if(record != undefined) {
            var changeType = event.getParam("changeType");
            if(changeType === "") {
                helper.closeEditPanel(component, event);
            } else {
                if(changeType === "remove") {
                    helper.removeItem(component, event, record.Id);
                } else if(changeType === "add") {
                    helper.addItem(component, event, record);
                } else {
                    helper.removeItem(component, event, record.Id);
                    helper.addItem(component, event, record);
                }
                helper.closeEditPanel(component, event);
            }
        }
    },

    newRecord: function(component, event, helper) {
        helper.openEditPanel(component, event, 'Member_Role__c');
    },

    selectItem: function(component, event, helper) {
        var name = event.getParam("name");
        var objectApiName = "Member_Role__c";
        var associations = component.get("v.associations");
        for(var i = 0; i < associations.length; i++) {
            if(name === associations[i].Id) {
                objectApiName = "Association__c";
                break;
            }
        }

        helper.openEditPanel(component, event, objectApiName, event.getParam("name"));
    }
});