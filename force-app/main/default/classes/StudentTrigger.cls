public class StudentTrigger {
    
    public static void studentUpdate(Map<ID,Student__c> oldMap,List<Student__c> newList)
    {
        List<Student_History__c> historyRecords = new List<Student_History__c>();
        
        
        Map<String, Schema.SObjectField> studentFieldsMap = Student__c.SObjectType.getDescribe().fields.getMap();
        
        for (Student__c newRecord : newList) {
            
            //if(newRecord.Name == 'Prachi'){
            //  System.debug(newRecord.Id);  
            //}
            
            Student__c oldRecord = oldMap.get(newRecord.Id);
            
            for (String fieldName : studentFieldsMap.keySet()) {
                
                if (fieldName != 'Id' && fieldName != 'CreatedDate' && fieldName != 'LastModifiedDate' && 
                    studentFieldsMap.get(fieldName).getDescribe().isUpdateable()){
                        
                        if (newRecord.get(fieldName) != oldRecord.get(fieldName)) {
                            
                            String fieldLabel = studentFieldsMap.get(fieldName).getDescribe().getLabel();
                            
                            Student_History__c historyRecord = new Student_History__c();
                            historyRecord.Name = fieldLabel;
                            historyRecord.Old_Value__c = String.valueOf(oldRecord.get(fieldName));
                            historyRecord.New_Value__c = String.valueOf(newRecord.get(fieldName));
                            historyRecord.Record__c = newRecord.Id;
                            historyRecords.add(historyRecord);
                        }
                        
                    }
            }
        }
        
        if (!historyRecords.isEmpty()) {
            insert historyRecords;
        }
    }
}