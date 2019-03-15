({
	toastThis : function(message, title,type) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"title": title,
			"message": message,
			"type": type,
			"mode": "sticky"
		});
		toastEvent.fire();
	}
})