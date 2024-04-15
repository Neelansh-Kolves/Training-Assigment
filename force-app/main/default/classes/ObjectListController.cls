public class ObjectListController {
    
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjects() {
        List<String> sObjectNames = new List<String>();
        for (Schema.SObjectType sObjectType : Schema.getGlobalDescribe().values()) {
            // Filter out some standard objects if needed
            if (!sObjectType.getDescribe().isCustom()) {
                sObjectNames.add(sObjectType.getDescribe().getName());
            }
        }
        sObjectNames.sort();
        return sObjectNames;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsForSObject(String sObjectName) {
        List<String> fieldNames = new List<String>();
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjectName);
        if (sObjectType != null) {
            Schema.DescribeSObjectResult describeResult = sObjectType.getDescribe();
            for (Schema.SObjectField field : describeResult.fields.getMap().values()) {
                fieldNames.add(field.getDescribe().getName());
            }
        }
        return fieldNames;
    }
}