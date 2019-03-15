public class OppCreationCls {
    @future(callout=true)
    public static void updateOppEURValue(Set<Id> lstNewOppIds){
        List<Opportunity> lstUpdateOpps = new List<Opportunity>();
        Decimal conversionRateUSD = Decimal.valueOf(fetchEuroAmount());
        for(Opportunity opp : [SELECT Id,Name,Amount_in_Euro__c,Amount FROM Opportunity WHERE Id IN : lstNewOppIds]){
            opp.Amount_in_Euro__c = opp.Amount/conversionRateUSD;
            lstUpdateOpps.add(opp);
        }
        if(!lstUpdateOpps.isEmpty()){
            Database.update(lstUpdateOpps,false);
        }
    }

    @AuraEnabled
    public static List<String> getStagePicklistValues(){
        List<String> lstOppStageValues = new List<String>();
        Schema.DescribeSObjectResult res = Opportunity.SObjectType.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get('StageName').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            lstOppStageValues.add(pickListVal.getLabel());
        }
        return lstOppStageValues;
    }
    
    @AuraEnabled
    public static String fetchEuroAmount(){
        //system.debug('oppAmt:::' + oppAmt);
        String retText = '';
        String conversionRate;
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://api.exchangeratesapi.io/latest');
        HttpResponse response = new HttpResponse();
        response = h.send(req);
        if(response.getStatusCode() == 200){
            JSONParser parser = JSON.createParser(response.getBody());
            while (parser.nextToken() != null) {
                if(parser.getCurrentName() == 'USD') {
                    parser.nextValue();
                    conversionRate = parser.getText();
                }
            }
            if(conversionRate!=NULL){
                //retText = String.valueOf(oppAmt/conversionRate);
                retText = conversionRate;
            }
        }
        
        else{
            retText ='ERROR';
        }
        return retText;
    }
    
    @AuraEnabled
    public static void insertOpportunity(String accountJSON, Opportunity oppObj){
        List<Opportunity> lstOppsToInsert = new List<Opportunity>();
        List<OppCreationCls.accountListWrapper> wrapper = new List<OppCreationCls.accountListWrapper>();
        wrapper = (List<OppCreationCls.accountListWrapper>)JSON.deserialize(accountJSON,List<OppCreationCls.accountListWrapper>.class);
        for(OppCreationCls.accountListWrapper wrapObj : wrapper){
            Opportunity opp = new Opportunity();
            opp.CloseDate = oppObj.CloseDate;
            opp.StageName = oppObj.StageName;
            opp.Amount = oppObj.Amount;
            opp.Amount_in_Euro__c = oppObj.Amount_in_Euro__c;
            opp.Name = 'New auto opportunity create for '+ wrapObj.objAccount.Name;
            opp.AccountId = wrapObj.objAccount.Id;
            lstOppsToInsert.add(opp);
        }
        if(!lstOppsToInsert.isEmpty()){
            Database.insert(lstOppsToInsert,false);
        }
    }
    
    @AuraEnabled
    public static List<accountListWrapper> fetchAccountWrapper(){
        List<accountListWrapper> lstaccountListWrapper = new List<accountListWrapper>();
        for(Account acc : [Select id,Name,Type,Phone
                           From Account
                           Limit 6]){
                               lstaccountListWrapper.add(new accountListWrapper(false,acc));
                           } 
        return lstaccountListWrapper;
    }
    
    public class accountListWrapper {
        @AuraEnabled public boolean isChecked {get;set;}
        @AuraEnabled public  account objAccount{get;set;}
        public accountListWrapper(boolean isChecked, account objAccount){
            this.isChecked = isChecked;
            this.objAccount = objAccount;
        }
    }
}