trigger StudentTriggerTask2 on Student__c (after update) {
   
    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            StudentTrigger.studentUpdate(Trigger.oldMap,Trigger.new);
           
        }
    }
    
}