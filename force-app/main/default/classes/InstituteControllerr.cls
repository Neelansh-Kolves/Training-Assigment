public class InstituteControllerr {
    
   @AuraEnabled
    public static List<Institute__c> getInstitutes() {
        return [SELECT Id, Name FROM Institute__c];
    }
    
    @AuraEnabled
    public static List<Mentor__c> getMentorsForInstitute(Id instituteId) {
        return [SELECT Id, Name, Designation__c FROM Mentor__c WHERE Institute__c = :instituteId];
    }
    
    @AuraEnabled
    public static List<Student__c> getStudentsByMentorId(Id mentorId) {
        return [SELECT Id, Name, City__c, State__c FROM Student__c WHERE Mentor__c = :mentorId];
    }
}