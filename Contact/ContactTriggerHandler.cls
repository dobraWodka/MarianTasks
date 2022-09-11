/**
 * Created by yurii.bubis on 9/10/2022.
 */

public with sharing class ContactTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public ContactTriggerHelper helper;

    public ContactTriggerHandler(Boolean triggerIsExecuting, Integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
        this.helper = new ContactTriggerHelper();
    }

    public void beforeInsert(List<Contact> newContacts, Map<Id, SObject> newContactsMap) {
        helper.setRelatedAccountStatus(newContacts);
        // helper.doTask2();Re
    }
    public void beforeUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<Id, sObject> oldContactMap, Map<Id, sObject> newContactMap) {

    }
    public void beforeDelete(List<Contact> oldContacts, Map<Id, sObject> oldContactMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<Contact> newContacts, Map<Id, sObject> newContactMap) {
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<Id, sObject> oldContactMap, Map<Id, sObject> newContactMap) {
        // helper.doTask4();
        // helper.doTask5();
    }
    public void afterDelete(List<Contact> oldContacts, Map<Id, sObject> oldContactMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<Contact> newContacts, Map<Id, sObject> newContactMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
}