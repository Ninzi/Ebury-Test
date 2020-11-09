public with sharing class createPostChatter {

    public static void tradePostChatter(List<Trade__c> tradeList) {

        List<User> lstUser = [SELECT Id FROM User WHERE Id IN (SELECT UserOrGroupId FROM GroupMember WHERE Group.DeveloperName = 'Trade_reviewers')];

        if(lstUser.size()>0){

            List<FeedItem> lstFeedItem = new List<FeedItem>();
        
            for(Trade__c trade : tradeList){
    
                String bodyFeeItem = 'A new trade has been created with the following data: '+ '\n';
                bodyFeeItem += 'Sell Currency: ' + trade.Sell_Currency__c + '\n';
                bodyFeeItem += 'Sell Amount: ' + trade.Sell_Amount__c + '\n';
                bodyFeeItem += 'Buy Currency: ' + trade.Buy_Currency__c + '\n';
                bodyFeeItem += 'Buy Amount: ' + trade.Buy_Amount__c + '\n';
                bodyFeeItem += 'Rate: ' + trade.Rate__c + '\n';
                bodyFeeItem += 'Booked Date: ' + trade.Date_Booked__c + '\n';
                bodyFeeItem += 'Link to the trade: ' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + trade.Id;

                for(User u : lstUser){
                    FeedItem item = new FeedItem(
                        parentId = u.id, // where to post message
                        body = bodyFeeItem
                    ); 
                    lstFeedItem.add(item);
                }
    
            }

            if(lstFeedItem.size()>0){
                insert lstFeedItem;
            }

        }

    }

}
