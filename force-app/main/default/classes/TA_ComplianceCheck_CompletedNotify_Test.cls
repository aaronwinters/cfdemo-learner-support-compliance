@isTest
private class TA_ComplianceCheck_CompletedNotify_Test {

    @IsTest
    public static void testBeforeUpdate() {
        List<Compliance_Check__c> oldList = new List<Compliance_Check__c>();
        List<Compliance_Check__c> newList = new List<Compliance_Check__c>();

        Contact contact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@test.com', External_Id__c = '123');
        insert contact;

        Compliance_Check__c cc1 = new Compliance_Check__c(
            Contact__c = contact.Id,
            Status__c = 'In Progress',
            Completion_Date__c = Date.today()
        );
        Compliance_Check__c cc2 = new Compliance_Check__c(
            Contact__c = contact.Id,
            Status__c = 'Completed',
            Completion_Date__c = Date.today()
        );
        insert new List<Compliance_Check__c>{cc1, cc2};

        oldList.add(cc1);
        newList.add(cc2);

        Test.startTest();
        TA_ComplianceCheck_CompletedNotification ta = new TA_ComplianceCheck_CompletedNotification();
        ta.beforeUpdate(newList, oldList);
        Test.stopTest();

        List<Compliance_Check__c> updatedChecks = [SELECT Id, Status__c FROM Compliance_Check__c WHERE Id IN :newList];

        System.assertEquals(1, updatedChecks.size(), 'One Compliance Check record should have been updated');
        System.assertEquals('Completed', updatedChecks[0].Status__c, 'The Compliance Check record should have been updated to Completed');
    }


}