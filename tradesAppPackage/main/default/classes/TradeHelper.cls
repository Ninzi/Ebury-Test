public with sharing class TradeHelper {
    @AuraEnabled(cacheable=true)
    public static List<Trade__c> getTradeList() {
        return [SELECT Name, Buy_Amount__c, Buy_Currency__c,
        Date_Booked__c, Rate__c, Sell_Amount__c, Sell_Currency__c
            FROM Trade__c ORDER BY Date_Booked__c Desc];
    }
}