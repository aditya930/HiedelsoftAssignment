({
    doInit : function(component,event,helper){
    	var action = component.get("c.getStagePicklistValues");
        action.setCallback(this,function(response){
           var state = response.getState();
            if(state === "SUCCESS"){
                var lst = response.getReturnValue();
                component.set("v.stagePicklistValLst",lst);
            }
        });
        $A.enqueueAction(action);
    },
    
    //Function to insert Opportunities
    handleComponentEvent : function(component,event,helper) {
        var selectedAccounts = event.getParam("lstSelectedAccs"); 
		var validOpp = component.find('oppForm').reduce(function (validSoFar, inputCmp) {
            inputCmp.showHelpMessageIfInvalid();
            return validSoFar && inputCmp.get('v.validity').valid;
        }, true);
        
        if(validOpp){
            component.set("v.isSending",true); 
            var action = component.get("c.insertOpportunity");
            action.setParams({
                   "accountJSON" : JSON.stringify(selectedAccounts),
                    "oppObj" : component.get("v.newOpp")
               });
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state==="SUCCESS"){
                    component.set("v.isSending",false);
                    if(response.getReturnValue() === "ERROR"){
                        helper.toastThis("Server Error", "ERROR","error");
                    }
                    else{
                        helper.toastThis("Opportunities Succesfully Created", "SUCCESS","success");
                    }
                 }
                else if (state === "ERROR") {
                    helper.toastThis("Server Error", "ERROR","error");
                }
            });
            $A.enqueueAction(action);
        }
        
    },

    //Function to Calculate EUR Amount based on the USD amount value using the Conversion rate
    calculateEuroAmt : function(component, event, helper) {
        var amountUSD = component.get("v.newOpp.Amount");
        if(amountUSD!=''){
           component.set("v.isSending",true); 
           var action = component.get("c.fetchEuroAmount");
           action.setCallback(this,function(response){
            var state = response.getState();
            if(state==="SUCCESS"){
                var convRate = response.getReturnValue();
                var eurAmount = amountUSD/convRate;
                component.set("v.newOpp.Amount_in_Euro__c",eurAmount);
                component.set("v.isSending",false);
            }
            else if (state === "ERROR") {
       
    		}
        });
           $A.enqueueAction(action);
        }
	}
})