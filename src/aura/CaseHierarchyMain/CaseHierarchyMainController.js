({
    doInit: function(component, event, helper) {
        var action = component.get("c.instantiateMain");
        action.setParam("caseId", component.get("v.recordId"));

        action.setCallback(this, function(response) {
            console.log("instantiateMain called back.");
            if(response.getState() === 'SUCCESS' && component.isValid()) {
                var main = response.getReturnValue();
                var associations = main.associations;
                component.set("v.associations", associations);
                console.log(main.associations);

                var items = [];
                var count = 1;
                for(var i = 0; i < associations.length; i++) {
                    var item = helper.createAssociationItem(component, event, associations[i]);
                    count++;
                    console.log(item);

                    var roles = associations[i].Member_Roles__r;
                    var roleItems = [];
                    for(var r = 0; r < roles.length; r++) {
                        var roleItem = helper.createMemberRoleItem(component, event, roles[r]);
                        count++;
                        console.log(roleItem);
                        roleItems.push(roleItem);
                    }

                    if(roleItems.length > 0) {
                        item.items = roleItems;
                    }
                    items.push(item);
                }

                console.log("items: ", items);
                console.log(items.length);
                component.set("v.items", items);
            }
        });

        $A.enqueueAction(action);
    },

    changeHierarchy: function(component, event, helper) {
        console.log("changeHierarchy called.");
        var record = event.getParam("record");
        if(record != undefined) {
            console.log(JSON.stringify(record));
            var changeType = event.getParam("changeType");
            console.log("changeType: " + changeType);
            if(changeType === "") {
                helper.closeEditPanel(component, event);
            } else {
                if(changeType === "remove") {
                    helper.removeItem(component, event, record.Id);
                } else if(changeType === "add") {
                    helper.addItem(component, event, record);
                } else {
                    //TODO: make this work
                    helper.updateItem(component, event, helper.createMemberRoleItem(component, event, record));
                }
                helper.closeEditPanel(component, event);
            }
        }
    },

    newRecord: function(component, event, helper) {
        helper.openEditPanel(component, event, 'Member_Role__c');
    },

    selectItem: function(component, event, helper) {
        console.log(event.getParam("name"));
        var name = event.getParam("name");
        var objectApiName = "Member_Role__c";
        var associations = component.get("v.associations");
        for(var i = 0; i < associations.length; i++) {
            console.log(name + " | " + associations[i].Id.toString());
            if(name === associations[i].Id) {
                objectApiName = "Association__c";
                break;
            }
        }
        console.log(objectApiName);
        helper.openEditPanel(component, event, objectApiName, event.getParam("name"));
    }
});