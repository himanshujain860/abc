trigger CouponTrigger on Coupon__c (before insert,after insert) {

    if(Trigger.isBefore)
    {
          CouponTriggerHandler.checkAmount(Trigger.new);
    }
    if(Trigger.isAfter)
    {
        CouponTriggerHandler.createRewardTransaction(Trigger.new);
    }
  
}