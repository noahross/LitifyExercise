/**
 * Created by neoro on 7/20/2019.
 */

({
    createAssociationItem: function(component, event, association) {
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
        var roleItem = {};
        roleItem.label = memberRole.Member__r.Name;
        roleItem.name = memberRole.Id;
        roleItem.metatext = memberRole.Role__c;
        return roleItem;
    },

    openEditPanel: function(component, event, objectApiName, recordId) {
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
    },

    closeEditPanel: function(component, event) {
        var editPanel = [];
        component.set("v.editPanel", editPanel);
    },

    addItem: function(component, event, record) {
        var items = component.get("v.items");
        if(record.Association__c != undefined) {
            for(var i = 0; i < items.length; i++) {
                if(items[i].name === record.Association__c) {
                    items[i].items.push(this.createMemberRoleItem(component, event, record));
                    component.set("v.items", items);
                    break;
                }
            }
        } else {
            items.push(this.createAssociationItem(component, event, record));
        }
        component.set("v.items", items);
    },

    removeItem: function(component, event, recordId) {
        var items = component.get("v.items");
        for(var i = items.length - 1; i >= 0; i--) {
            if(items[i].name === recordId) {
                items.splice(i, 1);
                component.set("v.items", items);
                break;
            }
            for(var r = items[i].items.length - 1; r >= 0; r--) {
                if(items[i].items[r].name === recordId) {
                    items[i].items.splice(r, 1);
                    component.set("v.items", items);
                    break;
                }
            }
        }
    }
});