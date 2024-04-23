public with sharing class LWCAssignment2Controller {
    
    // Method to retrieve a list of sObjects available in the org
    @AuraEnabled(cacheable=true)
    public static List<String> getSObjects() {
        List<String> sObjectNames = new List<String>();
        // Retrieve all sObject describe results
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        // Add each sObject name to the list
        for (String name : gd.keySet()) {
            sObjectNames.add(name);
        }
        sObjectNames.sort();
        return sObjectNames;
    }

    // Method to retrieve the fields for a given sObject
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getFieldsForSObject(String sObjectName) {
        List<Map<String, String>> fieldOptions = new List<Map<String, String>>();
        try {
            // Describe the sObject to get its fields
            Schema.DescribeSObjectResult describeResult = Schema.getGlobalDescribe().get(sObjectName).getDescribe();
            // Get the fields for the sObject
            Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();
            // Iterate through each field and add its label and API name to the list
            for (String fieldName : fieldMap.keySet()) {
                Schema.SObjectField field = fieldMap.get(fieldName);
                Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
                Map<String, String> fieldOption = new Map<String, String>();
                fieldOption.put('label', fieldDescribe.getLabel());
                fieldOption.put('value', fieldName);
                fieldOptions.add(fieldOption);
            }
        } catch (Exception e) {
            // Handle any exceptions, such as if the sObject does not exist
            System.debug('Error retrieving fields for sObject: ' + sObjectName + ', Error: ' + e.getMessage());
        }
        return fieldOptions;
    }
}