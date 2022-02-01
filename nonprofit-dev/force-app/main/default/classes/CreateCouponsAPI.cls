@RestResource(urlMapping='/createCoupon/*')
global class CreateCouponsAPI {

    public static String couponsId = '';
    
    @HTTPGET
    global static Coupon__c getVOlunteers(){
        System.debug('cou11='+couponsId);
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String couponId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Coupon__c result =  [SELECT Id,Name,Contact__c,Amount__c,Coupon_Code__c FROM Coupon__c WHERE Id = :couponsId];
        return result;
    }
    
    @HTTPPOST
    global static String createCoupons(String volId,Decimal redPoints){
        
       COntact con =  [Select id,Balance_Rewards__c from Contact where Id=:volId LIMIT 1];
        Coupon__c coupons;
        if(redPoints>con.Balance_Rewards__c){
            System.debug('Insufficient Balance');
        }
        else{
            coupons = new Coupon__c(Contact__c = volId ,Amount__c = redPoints);
            insert coupons;
            couponsId = coupons.Coupon_Code__c;
        }
        return coupons.Coupon_Code__c;
    }
}