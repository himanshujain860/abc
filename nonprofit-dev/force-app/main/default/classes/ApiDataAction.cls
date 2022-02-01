@RestResource(urlMapping='/Contact/*')
global with sharing class ApiDataAction {

    @HttpGet
    global static List<Contact> getRecord() {
        
        List<Contact> contacts=[Select id,Name,Email,Phone,Profile_Strength__c from Contact LIMIT 10];
        return contacts;
    }
    
    @HTTPPost
    global static void insertRecord() {
        RestRequest contactRequest = RestContext.request;
        String requestBody = contactRequest.requestBody.toString();
        Contact contact;
        if(String.isNotEmpty(requestBody))
        {
            contact = (Contact) JSON.deserialize(requestBody, Contact.class);
            insert contact;
        }
    }
    
    @HTTPPatch
    global static void updateRecord() {
        RestRequest contactRequest = RestContext.request;
        String contactRequestURI = contactRequest.requestURI;
        String contactId = contactRequestURI.substring(contactRequestURI.lastIndexOf('/') + 1);
        String requestBody = contactRequest.requestBody.toString();
        Contact contact;
        if(String.isNotEmpty(contactId)) {
            // Deserializing the JSON response body and assigning it to the instance of Contact object
            contact = (Contact) JSON.deserialize(requestBody, Contact.class);
           // Assigning the contact id
            contact.Id = contactId;
            // Updating Contact
            update contact;
        }
    }
    
}