trigger tradeTrigger on Trade__c (after insert) {

    if(Trigger.isAfter && Trigger.isInsert) {
        tradeTriggerHandler.handleAfterInsert(Trigger.new);
    }

}