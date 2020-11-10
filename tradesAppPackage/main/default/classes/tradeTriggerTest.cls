@isTest
public class tradeTriggerTest {

    @testSetup static void setup() {

        Group tradeReviewersGroup = new Group(Name='Trade reviewers', Type='Queue');
        insert tradeReviewersGroup;

        QueuesObject tradeReviewersQueue = new QueueSObject(QueueID = tradeReviewersGroup.id);
        insert tradeReviewersQueue;

        User u = new User(FirstName = 'My', LastName = 'User', 
                           Alias = 'myuse', Email = 'my.user@email.com',
                           Username = 'my.user@email.com', CommunityNickname = 'MyUser',
                           ProfileId = [SELECT Id FROM Profile WHERE Name = 'Test'].Id, TimeZoneSidKey = 'Europe/Madrid',
                           LocaleSidKey = 'IT', EmailEncodingKey = 'UTF-8',
                           LanguageLocaleKey = 'it', IsActive = true);
        system.debug(u);

        GroupMember member = new GroupMember();
        member.UserOrGroupId = u.Id;
        member.GroupId = tradeReviewersGroup.Id;
        insert member;

        //Id userId = UserInfo.getUserId();
    }

    @isTest 
    static void newTrade() {

        Group tradeReviewersGroup = [Select ID from Group where Name ='Trade reviewers'];
        
        System.runAs(new User(Id = UserInfo.getUserId())) {   
            GroupMember member = new GroupMember();
            member.UserOrGroupId = UserInfo.getUserID();
            member.GroupId = tradeReviewersGroup.Id;
            insert member;
        }

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
