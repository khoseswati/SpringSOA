trigger CreateContactTrigger on Contact (after insert) {
    // create a set to store the account IDs of the new contacts
    Set<Id> accountIds = new Set<Id>();
    for (Contact c : Trigger.new) {
        accountIds.add(c.AccountId);
    }
    
    // retrieve the related accounts for the new contacts
    List<Account> accounts = [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account WHERE Id IN :accountIds];
    
    // loop through the accounts and update the contact count
    for (Account a : accounts) {
        a.Number_of_Contacts__c = a.Contacts.size();
    }
    
    // update the accounts in bulk
    update accounts;
}