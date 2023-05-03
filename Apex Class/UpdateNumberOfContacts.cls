public with sharing class UpdateNumberOfContacts {
    
    // Get the number of contacts related to Account
    @AuraEnabled
    public static Integer getNumberofContact(Id record_Id){
        Integer count ;
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts)
                                    FROM Account 
                                    WHERE Id =: record_Id];

        for (Account account : accounts) {
            account.Number_of_Contacts__c = account.Contacts.size();
            count = account.Contacts.size();
        }
        update accounts;
        return count;
    }


    // Get the recently created 10 accounts 
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, CreatedDate FROM Account ORDER BY CreatedDate DESC LIMIT 10];
    }

    @AuraEnabled
    public static Object callHttp(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:BasicCallout');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('HTTP response body: ' + response.getBody());
        return response.getBody();
    }
}