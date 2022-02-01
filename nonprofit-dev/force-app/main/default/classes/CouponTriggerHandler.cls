public class CouponTriggerHandler {

    
    public static void checkAmount(List<Coupon__c> coupons)
    {
        Contact con=[Select id,Name,Balance_Rewards__c from Contact where id=:coupons[0].Contact__c];
       for(Coupon__c cp:coupons)
       {
           if(con.Balance_Rewards__c <cp.Amount__c)
           {
               cp.addError('Not possible');
           }
       }
    }
    public static void createRewardTransaction(List<Coupon__c> coupons)
    {
        Contact con=[Select id,Name,Balance_Rewards__c from Contact where id=:coupons[0].Contact__c];
        
        Reward_Transaction__c rt=new Reward_Transaction__c();
        rt.Status__c='Reedemed';
        rt.Amount__c=coupons[0].Amount__c;
        rt.Contact__c=con.id;
        rt.Coupun_Code__c=coupons[0].Coupon_Code__c;
        rt.Coupon__c=coupons[0].id;
        insert rt;
            
        
       
    }
}