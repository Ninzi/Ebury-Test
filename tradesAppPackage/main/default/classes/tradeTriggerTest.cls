@isTest
public class tradeTriggerTest {

    @testSetup static void setup() {
        
        Group tradeReviewersGroup;
        
        try{
            tradeReviewersGroup = new Group(DeveloperName='Trade_reviewers', Type='Queue');
            insert tradeReviewersGroup;
    
            QueuesObject tradeReviewersQueue = new QueueSObject(QueueID = tradeReviewersGroup.id, SobjectType = 'Trade__c');
            insert tradeReviewersQueue;
            
        } catch(exception e) {
            tradeReviewersGroup = [Select ID from Group where DeveloperName = 'Trade_reviewers'];
        }
        
        User u = new User(FirstName = 'My', LastName = 'User', 
                           Alias = 'myuse', Email = 'my.user@email.com',
                           Username = 'my.user@email.com', CommunityNickname = 'MyUser',
                           ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id, TimeZoneSidKey = 'Europe/Rome',
                           LocaleSidKey = 'ES', EmailEncodingKey = 'UTF-8',
                           LanguageLocaleKey = 'es', IsActive = true);
        insert u;

        GroupMember member = new GroupMember();
        member.UserOrGroupId = u.Id;
        member.GroupId = tradeReviewersGroup.Id;
        insert member;

    }

    @isTest 
    static void newTrade() {

        Test.startTest();
        Trade__c trade = new Trade__c();
        trade.Sell_Currency__c = 'EUR';
        trade.Sell_Amount__c = 5.10;
        trade.Buy_Currency__c = 'USD';
        trade.Rate__c = 0.99;
        trade.Date_Booked__c = system.now();
        trade.Buy_Amount__c = trade.Sell_Amount__c * trade.Rate__c;
        insert trade;
        Test.stopTest();

    }
}