/**
 * Created by yurii.bubis on 9/8/2022.
 */

@IsTest
private class AccountTriggerTest {
    @TestSetup
    static void setup(){
        List<Account> newAccs = new List<Account>();
        List<Contact> newConts = new List<Contact>();

        for (Integer i = 0; i<20; i++) {
            Account acc = new Account();
            acc.Name = 'Zalupa ' + i;
            newAccs.add(acc);
        }

        insert newAccs;

        for (Account a : newAccs){
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
    static void testBehavior() {
        List<Account> accs = [SELECT Id, Name, Status__c, (SELECT Id, AccountId FROM Contacts) FROM Account];
        System.debug(accs[0].Status__c);
        System.debug(accs[0].Contacts.size());

        Test.startTest();

        for (Account acc : accs) {
             acc.Phone = '1234' + accs.indexOf(acc);
        }

        List<Database.SaveResult> result = Database.update(accs);

        Test.stopTest();

        List<Account> newAccs = [SELECT Id, Status__c, (SELECT Id FROM Contacts) FROM Account];

        for (Account acc : newAccs) {
            if (acc.Contacts.size() >= 5) {
                System.assertEquals('Completed', acc.Status__c,
                        'Account with '+ acc.Contacts.size() + ' have status ' + acc.Status__c
                );
            } else {
                System.assertEquals('Draft', acc.Status__c,
                        'Account with '+ acc.Contacts.size() + ' have status ' + acc.Status__c
                );
            }
        }
    }
}