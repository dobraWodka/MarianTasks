/**
 * Created by yurii.bubis on 9/8/2022.
 */

public with sharing class AccountTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public AccountTriggerHelper helper;

    public AccountTriggerHandler(Boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new AccountTriggerHelper();
    }

    public void beforeInsert(List<Account> newAccounts, Map<Id, SObject> newAccountsMap) {

        // helper.doTask2();Re
    }
    public void beforeUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<Id, sObject> oldAccountMap, Map<Id, sObject> newAccountMap) {
        helper.setStatus(newAccounts, newAccountMap);
    }
    public void beforeDelete(List<Account> oldAccounts, Map<Id, sObject> oldAccountMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<Account> newAccounts, Map<Id, sObject> newAccountMap) {
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<Account> oldAccounts, List<Account> newAccounts, Map<Id, sObject> oldAccountMap, Map<Id, sObject> newAccountMap) {
        // helper.doTask4();
        // helper.doTask5();
    }
    public void afterDelete(List<Account> oldAccounts, Map<Id, sObject> oldAccountMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<Account> newAccounts, Map<Id, sObject> newAccountMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
}