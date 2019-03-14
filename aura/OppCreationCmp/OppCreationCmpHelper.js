({
	toastThis : function(message, title) {
		var toastEvent = $A.get("e.force:showToast");
		toastEvent.setParams({
			"title": title,
			"message": message,
			"type": "success",
			"mode": "sticky"
		});
		toastEvent.fire();
	}
})