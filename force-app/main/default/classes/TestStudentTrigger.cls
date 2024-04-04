@isTest
public class TestStudentTrigger {

    @isTest
    static void testStudentUpdate() {
        // Create test data
        Student__c oldStudent = new Student__c(Name = 'TestStudent2', Aadhaar_Number__c = '123499999', City__c = 'Sample City2');
        insert oldStudent;

        // Modify the student record
        oldStudent.City__c = 'Delhi';
        update oldStudent;

        // Verify that the Student_History__c record is created
        List<Student_History__c> historyRecords = [SELECT Id FROM Student_History__c WHERE Record__c = :oldStudent.Id];
        System.assertEquals(1, historyRecords.size(), 'Expected one Student History record to be created');
    }
}