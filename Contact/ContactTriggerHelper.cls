/**
 * Created by yurii.bubis on 9/10/2022.
 */

public with sharing class ContactTriggerHelper {
    public ContactTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
    public void setRelatedAccountStatus(List<Contact> newContacts){
        Map<Id, Integer> accIdToRelCount = new Map<Id, Integer>();

        for (Contact c : newContacts) {
            if (accIdToRelCount.keySet().contains(c.AccountId)) {
                accIdToRelCount.put(c.AccountId, accIdToRelCount.get(c.AccountId) + 1);
            } else {
                accIdToRelCount.put(c.AccountId, 1);
            }
        }
        System.debug(accIdToRelCount);

        List<Account> accsToUpdate = [SELECT Id, Status__c FROM Account WHERE Id IN :accIdToRelCount.keySet()];
        System.debug(accsToUpdate);

        for (Account a : accsToUpdate) {
            if (accIdToRelCount.get(a.Id) >= 5) {
                a.Status__c = 'Completed';
            } else {
                a.Status__c = 'Draft';
            }
        }

        update accsToUpdate;
    }
}