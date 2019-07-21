/**
 * Created by neoro on 7/20/2019.
 */

({
    createAssociationItem: function(component, event, association) {
        console.log("createAssociationItem called.");
        var item = {};
        var label = "Victim";
        if(association.Association__r != undefined) {
            if(association.Association__r.Industry != undefined) {
                var label = association.Association__r.Industry;
            }
            if(association.Association__r.Name != undefined) {
                item.metatext = association.Association__r.Name;
            }
        }
        item.label = label;
        item.name = association.Id;
        return item;
    },

    createMemberRoleItem: function(component, event, memberRole) {
        console.log("createMemberRoleItem called.");
        var roleItem = {};
        roleItem.label = memberRole.Member__r.Name;
        roleItem.name = memberRole.Id;
        roleItem.metatext = memberRole.Role__c;
        return roleItem;
    },

    openEditPanel: function(component, event, objectApiName, recordId) {
        console.log("openEditPanel called.");
        console.log("objectApiName: " + objectApiName);
        console.log("recordId: " + recordId);
        $A.createComponent("c:CaseEditModal", {
            "aura:id": "editPanel",
            "objectApiName": objectApiName,
            "recordId": recordId
        },function(newComponent) {
            if(component.isValid()) {
                var editPanel = [];
                editPanel.push(newComponent);
                component.set("v.editPanel", editPanel);
            }
        });

        console.log("editPanel created.");
    },

    closeEditPanel: function(component, event) {
        console.log("closeEditPanel called.");
        var editPanel = [];
        component.set("v.editPanel", editPanel);
    },

    addItem: function(component, event, record) {
        console.log("addItem called.");
        var items = component.get("v.items");
        if(record.Association__c != undefined) {
            console.log("record.Association is defined.");
            console.log("record.Association__c: " + record.Association__c);
            for(var i = 0; i < items.length; i++) {
                console.log("items[i].Id: " + items[i].name);
                if(items[i].name === record.Association__c) {
                    console.log("found matching association.");
                    items[i].items.push(this.createMemberRoleItem(component, event, record));
                    component.set("v.items", items);
                    break;
                }
            }
        } else {
            console.log("item.Association is undefined.");
            items.push(this.createAssociationItem(component, event, record));
        }
        component.set("v.items", items);
    },

    removeItem: function(component, event, recordId) {
        var items = component.get("v.items");
        for(var i = items.length; i > 0; i--) {
            if(items[i].name === recordId) {
                items.slice(i);
                component.set("v.items", items);
                break;
            }
            for(var r = items[i].items.length; r > 0; r--) {
                if(items[i].items[r].name === recordId) {
                    items[i].items.slice(r);
                    component.set("v.items", items);
                    break;
                }
            }
        }
    },

    updateItem: function(component, event, item) {
        console.log("updateItem called.");
        var items = component.get("v.items");
        for(var i = items.length - 1; i >= 0; i--) {
            if(items[i].name === item.name) {
                items.splice(i, 1, item);
                component.set("v.items", items);
                break;
            }
            for(var r = items[i].items.length - 1; r >= 0; r--) {
                if(items[i].items[r].name === item.name) {
                    items[i].items.splice(r, 1, item);
                    component.set("v.items", items);
                    break;
                }
            }
        }
    }
});