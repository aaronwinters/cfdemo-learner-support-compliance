public with sharing class TA_Contact_RequestComplianceCheck implements TriggerAction.AfterInsert {
    
    @TestVisible
    private static final String REQUESTED = 'Requested';

    public void afterInsert(List<Contact> newList){
        List<Compliance_Check__c> ccList = new List<Compliance_Check__c>();
        for (Contact con : newList) {
          Compliance_Check__c cc = new Compliance_Check__c (Contact__c = con.id, Status__c = REQUESTED);
          ccList.add(cc);
        }

        if (!ccList.isEmpty()) {
            insert ccList;
        }
      }
}