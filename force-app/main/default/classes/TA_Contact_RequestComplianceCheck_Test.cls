@isTest
public class TA_Contact_RequestComplianceCheck_Test {

    // Validate that the Compliance_Check__c record is created after a Contact insert
    @isTest
    static void testAfterInsert_CreateComplianceCheck() {
        // Create a test Contact record
        Contact testContact = new Contact(LastName = 'User', FirstName = 'Test');
        insert testContact;
        
        // Query for the related Compliance_Check__c record
        List<Compliance_Check__c> complianceChecks = [SELECT Id, Contact__c, Status__c FROM Compliance_Check__c WHERE Contact__c = :testContact.Id];
        
        // Assert that one Compliance_Check__c record is created and that the Status__c is 'Requested'
        System.assertEquals(1, complianceChecks.size(), 'One Compliance_Check__c should be created for the Contact.');
        System.assertEquals('Requested', complianceChecks[0].Status__c, 'The status should be "Requested".');
        System.assertEquals(testContact.Id, complianceChecks[0].Contact__c, 'The Contact__c should match the inserted Contact Id.');
    }

    // Test bulk behavior
    @isTest
    static void testAfterInsert_BulkInsertComplianceCheck() {
        // Create a list of Contact records
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 5; i++) {
            testContacts.add(new Contact(LastName = 'User' + i, FirstName = 'Test' + i));
        }
        insert testContacts;

        // Query for the related Compliance_Check__c records
        List<Compliance_Check__c> complianceChecks = [SELECT Id, Contact__c, Status__c FROM Compliance_Check__c WHERE Contact__c IN :testContacts];

        // Assert that 5 Compliance_Check__c records are created and that the Status__c for each Compliance_Check__c is 'Requested'
        System.assertEquals(5, complianceChecks.size(), 'Five Compliance_Check__c records should be created.');
        for (Compliance_Check__c cc : complianceChecks) {
            System.assertEquals('Requested', cc.Status__c, 'The status should be "Requested" for each Compliance_Check__c.');
        }
    }
}