({
	doInit : function(component, event, helper) {
		var action = component.get("c.fetchAccountWrapper");
        component.set("v.isSending",true);
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var AccountLstRes = response.getReturnValue();
                component.set('v.listOfAllAccounts', AccountLstRes);
                component.set("v.isSending",false);
            }
        });
        $A.enqueueAction(action);
	},
    
    createOpp : function(component,event,helper){
        var lstAllAccounts = component.get("v.listOfAllAccounts");
        var lstSelectedAccounts= [];
        for(var i=0;i<lstAllAccounts.length;i++){
            if(lstAllAccounts[i].isChecked){
                lstSelectedAccounts.push(lstAllAccounts[i]);
            }
        }
        if(lstSelectedAccounts == ''){
        	helper.toastThis("Please select Accounts", "No Account  Selected");
        }
        else{
           helper.createOpportunity(component,lstSelectedAccounts); 
        }
    }
})