/*********************************************************************************
Class Name      : tgrOnOpportunity 
Description     : Trigger on Opportunity
                 
Created By      : Aditya M
Created Date    : 14-Mar-19   
Modification Log:
---------------------------------------------------------------------------------- ,
Developer                   Date                   Description
-----------------------------------------------------------------------------------            
Aditya M            	 14-Mar-19                   Initial Version
*********************************************************************************/
trigger tgrOnOpportunity on Opportunity(after INSERT, after UPDATE){
    
    if(AvoidRecursion.isFirstRun() && System.IsBatch() == false && System.isFuture() == false){
        OppCreationCls.updateOppEURValue(trigger.newMap.keySet());
    }
    
}