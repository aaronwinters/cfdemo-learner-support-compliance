@IsTest
private class ComplianceCheckTrigger_Test {
    @TestSetup
    static void setup() {
        // Create test data
        Contact c = new Contact(FirstName = 'Test', LastName = 'User', External_Id__c = '12345');
        insert c;

        Compliance_Check__c cc1 = new Compliance_Check__c(
            Contact__c = c.Id,
            Status__c = 'Not Started'
        );
        Compliance_Check__c cc2 = new Compliance_Check__c(
            Contact__c = c.Id,
            Status__c = 'Not Started'
        );
        insert new List<Compliance_Check__c>{ cc1, cc2 };
    }

    @IsTest
    static void testComplianceCheckTrigger() {
        // Get the test data
        List<Compliance_Check__c> ccList = [SELECT Id, Status__c FROM Compliance_Check__c];

        // Start the test
        Test.startTest();

        // Update the Compliance_Check__c records
        for (Compliance_Check__c cc : ccList) {
            cc.Status__c = 'In Progress';
        }
        update ccList;

        // Stop the test
        Test.stopTest();

        // Verify the results
        List<Compliance_Check__c> updatedCCList = [SELECT Id, Status__c FROM Compliance_Check__c];
        for (Compliance_Check__c cc : updatedCCList) {
            System.assertEquals('In Progress', cc.Status__c, 'Compliance Check status should be updated to In Progress');
        }
    }
}
