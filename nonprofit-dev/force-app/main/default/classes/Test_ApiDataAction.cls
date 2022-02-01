@isTest
public with sharing class Test_ApiDataAction {
    
    @testSetup static void setup() {
        Contact contact = new Contact();
        contact.FirstName = 'testUser';
        contact.LastName = 'Ranosys';
        contact.Email = 'test@gmail.com';
        insert contact;        
    }
    
    static testMethod void testContactgetApi(){
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();  
        req.requestURI = 'services/apexrest/Contact'; 
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response= res;
        Test.startTest();
        List<Contact> con = ApiDataAction.getRecord();
        Test.stopTest();
        System.assertEquals(50,con[0].Profile_Strength__c);
    }
    
    
    static testMethod void testContactPostApi()
    {   
        RestRequest req = new RestRequest();
        req.requestURI = 'services/apexrest/Contact'; 
        req.httpMethod = 'POST';
        Contact contact = new Contact();
        contact.FirstName = 'testUser1';
        contact.LastName = 'Ranosys1';
        contact.Email = 'test1@gmail.com';
        req.requestBody = Blob.valueOf(JSON.serializePretty(contact));
        RestContext.request = req;
        Test.startTest();
        ApiDataAction.insertRecord();
        Test.stopTest();
    }
    
    static testMethod void testContactPutApi()
    {
        Contact contact = new Contact();
        contact.Email='test67@gmail.com';
        RestRequest req = new RestRequest();
        Contact con=[Select id from Contact ];
        req.requestURI = 'services/apexrest/Contact/'+con.Id; 
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf(JSON.serializePretty(contact));
        RestContext.request = req;
        Test.startTest();
        ApiDataAction.updateRecord();
        Test.stopTest();
        Contact cont=[Select id,Email from Contact ];
        System.assertEquals('test67@gmail.com', cont.Email, 'msg');
    }
}