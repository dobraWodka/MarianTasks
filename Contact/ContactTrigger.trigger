/**
 * Created by yurii.bubis on 9/10/2022.
 */

trigger ContactTrigger on Contact (before insert, before update) {
    if (Org_Specific_Setting__mdt.getInstance('Run_All_Triggers')?.Value__c == true) {
        TriggerHandler handler = new ContactTriggerHandler(Trigger.isExecuting, Trigger.size);

        switch on Trigger.operationType {
            when BEFORE_UPDATE {
                handler.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
            }
            when BEFORE_INSERT  {
                handler.beforeInsert(Trigger.New, Trigger.newMap);
            }
        }
    }
}