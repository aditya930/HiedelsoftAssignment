({
	toastThis : function(message, title) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"title": title || "Error:",
			"message": message,
			"type": "error",
			"mode": "sticky"
		});
		toastEvent.fire();
	},
    
    createOpportunity : function(component,lstSelectedAccounts){
        var cmpEvent = component.getEvent("accCmpEvt");
		cmpEvent.setParams({
            "lstSelectedAccs" : lstSelectedAccounts
        });
        cmpEvent.fire();
    }
})