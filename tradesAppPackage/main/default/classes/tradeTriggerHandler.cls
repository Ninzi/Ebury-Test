public with sharing class tradeTriggerHandler {

    public static void handleAfterInsert(List<Trade__c> tradeList)
    {   
        createPostChatter.tradePostChatter(tradeList);
    }

}
