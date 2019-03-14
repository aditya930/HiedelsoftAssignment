@isTest
public class tgrOnOpportunityTest {
    @testSetup static void testSetupMethod() {
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }

        INSERT testAccts;   
    }
    static testMethod void validateOpportunity() {
        List<OppCreationCls.accountListWrapper> accWrapperTest = new List<OppCreationCls.accountListWrapper>();
        accWrapperTest = OppCreationCls.fetchAccountWrapper();
        accWrapperTest.remove(0);
        Opportunity testOpp2 = new Opportunity();
            testOpp2.Amount = 609;
            testOpp2.StageName = 'Closed Won';
            testOpp2.CloseDate = Date.today();
        OppCreationCls.insertOpportunity(JSON.serialize(accWrapperTest),testOpp2);
        OppCreationCls.getStagePicklistValues();
        Account acct = [SELECT Id FROM Account WHERE Name='TestAcct0' LIMIT 1];
        Test.setMock(HttpCalloutMock.class, new ConversionRateMock());
          Test.startTest();
            Opportunity testOpp = new Opportunity();
            testOpp.Name = 'TestOpportunity';
            testOpp.Amount = 66;
            testOpp.StageName = 'Closed Won';
            testOpp.CloseDate = Date.today();
            INSERT testOpp;
          Test.stopTest();

        
     }

}