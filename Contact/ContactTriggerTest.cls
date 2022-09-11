/**
 * Created by yurii.bubis on 9/10/2022.
 */

@IsTest
private class ContactTriggerTest {
    @TestSetup
    static void setup() {
        List<Account> accsToInsert = new List<Account>();
        List<Contact> newConts = new List<Contact>();

        for (Integer i = 0; i<20; i++) {
            Account acc = new Account();
            acc.Name = 'Zalupa ' + i;
            accsToInsert.add(acc);
        }

        insert accsToInsert;

        for (Account a : accsToInsert){
            Integer randomInt = Integer.valueOf(Math.random()*10);
            for (Integer i = 0; i < randomInt; i++ ) {
                Contact c = new Contact();
                c.LastName = a.Name + ' Contact '+i;
                c.AccountId = a.Id;
                newConts.add(c);
            }
        }

        insert newConts;
    }
    @IsTest
    static void testInsert() {
        List<Account> accsToInsert = new List<Account>();
        List<Contact> newConts = new List<Contact>();

        for (Integer i = 0; i<20; i++) {
            Account acc = new Account();
            acc.Name = 'Zalupa ' + i;
            accsToInsert.add(acc);
        }

        insert accsToInsert;

        for (Account a : accsToInsert){
            Integer randomInt = Integer.valueOf(Math.random()*10);

            for (Integer i = 0; i < randomInt; i++ ) {
                Contact c = new Contact();
                c.LastName = a.Name + ' Contact '+i;
                c.AccountId = a.Id;
                newConts.add(c);
            }
        }
        Test.startTest();

        insert newConts;

        Test.stopTest();

        List<Account> newAccs = [SELECT Id, Status__c, (SELECT Id FROM Contacts ) FROM Account];

        for (Account a : newAccs) {
            if(a.Contacts.size() >= 5) {
                System.assertEquals('Completed', a.Status__c, a.Status__c + ' with ' + a.Contacts.size());
            } else {
                System.assertEquals('Draft', a.Status__c, a.Status__c + ' with ' + a.Contacts.size());
            }
        }
    }

//    @IsTest
//    static void testUpdate() {
//        List<Account> newAccs = [SELECT Id, Status__c, (SELECT Id FROM Contacts) FROM Account];
//        List<Contact> newConts = [SELECT Id, Account.Status__c, AccountId FROM Contact ];
//        List<Account> completedAccs = new List<Account>();
//        List<Account> draftAccs = new List<Account>();
//
//        for (Account a : newAccs) {
//            if(a.Contacts.size() >= 5) {
//                completedAccs.add(a);
//                System.assertEquals('Completed', a.Status__c, a.Status__c + ' with ' + a.Contacts.size());
//            } else {
//                draftAccs.add(a);
//                System.assertEquals('Draft', a.Status__c, a.Status__c + ' with ' + a.Contacts.size());
//            }
//        }
//        Account accToDelConts = completedAccs[0];
//        Account accToAddConts = draftAccs[0];
//
//        for (Contact c : accToDelConts.Contacts) {
//            c.AccountId = accToAddConts.Id;
//        }
//
//        update accToAddConts;
//
//        Account updatedAccs = [
//                SELECT
//                    Id, Status__c, (SELECT Id FROM Contacts)
//                FROM
//                    Account
//                WHERE
//                    Id = :accToDelConts.Id
//                LIMIT 1
//                ];
//        System.assertEquals('Draft', updatedAccs.Status__c);
//
//
//    }
}