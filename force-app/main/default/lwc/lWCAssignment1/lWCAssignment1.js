import { LightningElement,wire,api,track}  from 'lwc';
import getInstitutes from '@salesforce/apex/LWCAssignmentController.getInstitutes';
import getMentorsForInstitute from '@salesforce/apex/LWCAssignmentController.getMentorsForInstitute';
import getStudentsByMentorId from '@salesforce/apex/LWCAssignmentController.getStudentsByMentorId';




export default class LWCAssignment1 extends LightningElement {


@track selectedInstitute;
@track instituteOptions;
@track mentors;
@track selectedMentor;
@track students = [];



@wire(getInstitutes)
wiredInstitutes({ error, data }) {
    if (data) {
        // Add default option
        this.instituteOptions = [{ label: '--Select Institute--', value: '' }];
        // Add fetched institute options
        this.instituteOptions.push(...data.map(inst => ({ label: inst.Name, value: inst.Id })));
    } else if (error) {
        console.error('Error fetching institutes', error);
    }
}

handleInstituteChange(event) {
    this.selectedInstitute = event.detail.value;
    // Handle selected institute
}

@wire(getMentorsForInstitute, { instituteId: '$selectedInstitute' })
wiredMentors({ error, data }) {
    if (data) {
        this.mentors = data;
    } else if (error) {
        console.error('Error fetching mentors', error);
    }
    this.students=null;
}


handleMentorSelection(event) {
    const mentorId = event.currentTarget.dataset.id; // Get the mentor Id from the clicked link's data-id attribute
    this.selectedMentor = mentorId; // Set the selected mentor Id

    // Trigger the wire method to fetch students for the selected mentor
    getStudentsByMentorId({ mentorId: this.selectedMentor })
        .then(result => {
            this.students = result;
        })
        .catch(error => {
            console.error('Error fetching students', error);
        });
}



@wire(getStudentsByMentorId, { mentorId: '$selectedMentor' })
wiredStudents({ error, data }) {
    if (data) {
        this.students = data;
    } else if (error) {
        console.error('Error fetching students', error);
    }
}

}