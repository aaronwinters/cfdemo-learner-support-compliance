public class TA_ComplianceCheck_CompletedNotification implements TriggerAction.BeforeUpdate {
	@TestVisible
    private static final String COMPLETED = 'Completed';
    
    public void beforeUpdate (List<Compliance_Check__c> newList, List<Compliance_Check__c> oldList) { 
    	
        List<Compliance_Check_Completed__e> completedEvents = new List<Compliance_Check_Completed__e>();

        for (Compliance_Check__c cc : newList) {

            if (cc.Status__c == COMPLETED) {
                Compliance_Check_Completed__e completedEvent = new Compliance_Check_Completed__e(
                    Learner_External_Id__c = cc.Contact__c,
                    Completed_Date__c = cc.Completion_Date__c
                );

                completedEvents.add(completedEvent);
            }
        }

        if (!completedEvents.isEmpty()) {
            EventBus.publish(completedEvents);
        }
    }
}