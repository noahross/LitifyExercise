/**
 * Created by neoro on 7/20/2019.
 */

({
    fireEvent: function(component, event, changeType, record) {
        var event = component.getEvent("caseHierarchyChange");
        console.log(event);
        event.setParams({
            "changeType": changeType,
            "record": record
        });
        event.fire();
    }
});