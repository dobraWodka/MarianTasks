/**
 * Created by yurii.bubis on 9/10/2022.
 */

trigger ContactTrigger on Contact (after insert, after update) {
    if (Org_Specific_Setting__mdt.getInstance('Run_All_Triggers')?.Value__c == true) {
        TriggerHandler handler = new ContactTriggerHandler(Trigger.isExecuting, Trigger.size);

        switch on Trigger.operationType {
            when AFTER_UPDATE {
                System.debug('Run handler method');
                handler.afterUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
            }
            when AFTER_INSERT  {
                handler.afterInsert(Trigger.New, Trigger.newMap);
            }
            when AFTER_DELETE  {
                handler.afterDelete(Trigger.old, Trigger.oldMap);
            }

        }
    }
}