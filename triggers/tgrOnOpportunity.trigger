trigger tgrOnOpportunity on Opportunity(after INSERT, after UPDATE){
    
    if(AvoidRecursion.isFirstRun() && System.IsBatch() == false && System.isFuture() == false){
        OppCreationCls.updateOppEURValue(trigger.newMap.keySet());
        system.debug('future$$$$');
    }
    
}