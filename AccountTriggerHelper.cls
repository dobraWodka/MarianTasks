/**
 * Created by yurii.bubis on 9/8/2022.
 */

public with sharing class AccountTriggerHelper {
    public AccountTriggerHelper() {
        System.debug('Inside AccountTriggerHelper Constructor');
    }
    public void selectStatus(List<Account> newAccounts) {
        System.debug('1');
        List<Contact> relatedContacts = [SELECT AccountId FROM Contact WHERE AccountId IN :newAccounts ];
        Map<Id, Integer> idToCount  = new Map<Id, Integer>();
        for(Contact c : relatedContacts){
            if(!idToCount.containsKey(c.AccountId)){
                idToCount.put(c.AccountId, 0);
            }
            idToCount.put(c.AccountId, idToCount.get(c.AccountId) + 1);
        }
        for(Account acc : newAccounts){
            if(idToCount.get(acc.Id) >= 5){
                acc.Status__c = 'Completed';
            }else{
                acc.Status__c = 'Draft';
            }
        }
    }
    public void doTask2() {
        System.debug('Inside Task 2');
    }
    public void doTask3() {
        System.debug('Inside Task 3');
    }
    public void doTask4() {
        System.debug('Inside Task 4');
    }
    public void doTask5() {
        System.debug('Inside Task 5');
    }
}