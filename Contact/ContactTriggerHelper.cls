/**
 * Created by yurii.bubis on 9/10/2022.
 */

public with sharing class ContactTriggerHelper {
    public ContactTriggerHelper() {
        System.debug('Inside ContactTriggerHelper Constructor');
    }
    public void setRelatedAccountStatus(List<Contact> newContacts){
        System.debug('Inside method');
        // Робимо сет з id аккаунтів до яких привязані контакти в trigger.new
        Set<Id> relatedAccIds = new Set<Id>();
        for (Contact c : newContacts) {
            relatedAccIds.add(c.AccountId);
        }
        // Рахуємо кількість всіх привязаних контактів до кожного id
//        List<AggregateResult> countedConts = [
//                SELECT
//                       COUNT(Id), AccountId
//                FROM
//                        Contact
//                WHERE
//                        AccountId IN :relatedAccIds
//                GROUP BY
//                        AccountId
//        ];
//        System.debug(countedConts);
//
//        Map<Id, Integer> accIdToRelCount = new Map<Id, Integer>();
//
//        for (AggregateResult ar : countedConts) {
//           accIdToRelCount.put((String)ar.get('AccountId'), (Integer)ar.get('expr0'));
//        }
//        System.debug(accIdToRelCount);
        List<Account> accsToUpdate = [SELECT Id, Status__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :relatedAccIds];
        System.debug(accsToUpdate[0].Contacts.size());

        for (Account a : accsToUpdate) {
            if (a.Contacts.size() > 4) {
                a.Status__c = 'Completed';
                System.debug('Account with '+ a.Contacts.size() + 'has Status '+ a.Status__c);
            } else {
                a.Status__c = 'Draft';
                System.debug('Account with '+ a.Contacts.size() + 'has Status '+ a.Status__c);

            }
        }


        update accsToUpdate;
    }
}