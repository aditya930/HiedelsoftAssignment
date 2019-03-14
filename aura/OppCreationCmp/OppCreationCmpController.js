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
                    helper.toastThis("Opportunities Succesfully Created", "SUCCESS");
                }
                else if (state === "ERROR") {
                    
                }
            });
            $A.enqueueAction(action);
        }
        
    },

    
    calculateEuroAmt : function(component, event, helper) {
        var amountUSD = component.get("v.newOpp.Amount");
        if(amountUSD!=''){
           component.set("v.isSending",true); 
           var action = component.get("c.fetchEuroAmount");
           /*action.setParams({
               "oppAmt" : amountUSD
           });*/
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