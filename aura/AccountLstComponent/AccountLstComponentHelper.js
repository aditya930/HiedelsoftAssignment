({
	toastThis : function(message, title,type) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"title": title || "Error:",
			"message": message,
			"type": type,
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