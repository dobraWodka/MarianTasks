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
    }
    public void beforeUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<Id, sObject> oldContactMap, Map<Id, sObject> newContactMap) {
    }
    public void beforeDelete(List<Contact> oldContacts, Map<Id, sObject> oldContactMap) {
    }
    public void afterInsert(List<Contact> newContacts, Map<Id, sObject> newContactMap) {
        System.debug('Inside helper insert method');
        helper.setRelatedAccountStatus(newContacts);
    }
    public void afterUpdate(List<Contact> oldContacts, List<Contact> newContacts, Map<Id, sObject> oldContactMap, Map<Id, sObject> newContactMap) {
        helper.setRelatedAccountStatus(newContacts);
        System.debug('Inside helper update method');
    }
    public void afterDelete(List<Contact> oldContacts, Map<Id, sObject> oldContactMap) {
        System.debug('Inside helper delete method');
        helper.setRelatedAccountStatus(oldContacts);
    }
    public void afterUndelete(List<Contact> newContacts, Map<Id, sObject> newContactMap) {

    }
}