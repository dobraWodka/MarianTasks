/**
 * Created by yurii.bubis on 9/8/2022.
 */

trigger AccountTrigger on Account (before update) {
    if (Org_Specific_Setting__mdt.getInstance('Run_All_Triggers')?.Value__c == true) {
        TriggerHandler handler = new AccountTriggerHandler(Trigger.isExecuting, Trigger.size);

        switch on Trigger.operationType {
            when BEFORE_UPDATE {
                handler.beforeUpdate(Trigger.old, Trigger.new, Trigger.oldMap, Trigger.newMap);
            }
        }
    }
}