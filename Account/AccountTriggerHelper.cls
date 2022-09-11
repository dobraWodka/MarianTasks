/**
 * Created by yurii.bubis on 9/8/2022.
 */

public with sharing class AccountTriggerHelper {
    public AccountTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
    public void setStatus(List<Account> newAccounts, Map<Id, SObject> newAccountMap) {
        List<Contact> relatedConts = [SELECT Id, Name, AccountId FROM Contact WHERE AccountId IN :newAccountMap.keySet()];
        System.debug(relatedConts);

        Map<Id, Integer> accIdToCountOfRelated = new Map<Id, Integer>();

        for (Contact c : relatedConts) {
            if (!accIdToCountOfRelated.keySet().contains(c.AccountId)) {
                accIdToCountOfRelated.put(c.AccountId, 1);
            } else {
                accIdToCountOfRelated.put(c.AccountId, accIdToCountOfRelated.get(c.AccountId) + 1);
            }
        }
        System.debug(accIdToCountOfRelated);

        for (Account a : newAccounts) {
//          accIdToCountOfRelated.get(a.Id) >= 5 ? a.Status__c = 'Completed' : a.Status__c = 'Draft';
            if (accIdToCountOfRelated.get(a.Id) >= 5){
                a.Status__c = 'Completed';
            } else {
                a.Status__c = 'Draft';
            }
        }

    }

}