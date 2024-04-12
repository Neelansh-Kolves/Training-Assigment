({
    init : function(component, event, helper) {
        var action = component.get("c.getInstitutes");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var institutes = response.getReturnValue();
                component.set("v.instituteOptions", institutes);
            } else {
                console.log("Failed to retrieve institutes");
            }
            
        });
        $A.enqueueAction(action);
    },
    
    
    getRelatedMentors : function(component, event, helper) {
        var selectedInstituteId = component.get("v.selectedInstitute");
        if (selectedInstituteId) {
            var action = component.get("c.getMentorsForInstitute");
            action.setParams({ instituteId : selectedInstituteId });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var mentors = response.getReturnValue();
                    component.set("v.mentors", mentors);
                } else {
                    console.log("Failed to retrieve mentors for the selected institute");
                }
                component.set("v.students", null);
            });
            $A.enqueueAction(action);
        }
    },
    
    
    getRelatedStudents : function(component, event, helper) {
        var mentorId = event.currentTarget.dataset.id;
        if (mentorId) {
            var action = component.get("c.getStudentsByMentorId");
            action.setParams({ "mentorId": mentorId });
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var students = response.getReturnValue();
                    component.set("v.students", students);
                } else {
                    console.log("Failed to retrieve students");
                }
            });
            $A.enqueueAction(action);
        }
    }
    
    
})