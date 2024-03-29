public class InstituteController {
    public List<SelectOption> instituteOptions { get; set; }
    public String selectedInstituteId { get; set; }
    public List<Mentor__c> mentors { get; set; }
    public List<Student__c> students { get; set; }
    public String selectedMentorId { get; set; }
    public Boolean showTable { get; set; }
    public Boolean showStudentTable { get; set; }
    
    public InstituteController() {
        instituteOptions = getInstituteOptions();
    }
    
    public List<SelectOption> getInstituteOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for(Institute__c inst : [SELECT Id, Name FROM Institute__c]) {
            options.add(new SelectOption(inst.Id, inst.Name));
        }
        return options;
    }
    
    public void getMentors() {
        
        if(selectedInstituteId != null) {
            mentors = [SELECT Id, Name, Designation__c FROM Mentor__c WHERE Institute__c = :selectedInstituteId];
            System.debug(mentors);
            showTable = !mentors.isEmpty();
        }
        else {
            mentors = new List<Mentor__c>();
            showTable = !mentors.isEmpty();
        }
        
        students = null;
        if(students == null){
            showStudentTable = false;
        }
    }
  
    public void fetchStudents() {
        
        if(selectedMentorId != null) {
            students = [SELECT Id,Name,City__c,State__c FROM Student__c WHERE Mentor__c = :selectedMentorId];
            showStudentTable = !students.isEmpty();
        } else {
            students = new List<Student__c>();
            showStudentTable = !students.isEmpty();
        }

    }
}