import { LightningElement,track,wire } from 'lwc';
import getSObjects from '@salesforce/apex/LWCAssignment2Controller.getSObjects';
import getFieldsForSObject from '@salesforce/apex/LWCAssignment2Controller.getFieldsForSObject';


export default class LWCAssignment2 extends LightningElement {

    @track objectOptions = [];
    @track selectedObject;
    @track fieldOptions = null;
    @track selectedFields = null;
    @track query;
    @track temp = false;

    @wire(getSObjects)
    wiredSObjectNames({ error, data }) {
        if (data) {
            this.objectOptions = [{ label: '-- Select sObject --', value: null }];
            this.objectOptions = this.objectOptions.concat(data.map(obj => ({ label: obj, value: obj })));
        } else if (error) {
            console.error('Error retrieving sObject names', error);
            this.objectOptions = [{ label: '-- Error fetching sObjects --', value: null }];
        }
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        if (this.selectedObject === null) {
            this.temp = false;
        } else {
            this.temp = true;
        }
        this.selectedFields=null;
        this.query=null;
    }
      
    get generateButtonVisible() {
        return this.selectedFields && this.selectedFields.length > 0;
    }


    @wire(getFieldsForSObject, { sObjectName: '$selectedObject' })
    wiredFields({ error, data }) {
        if (data) {

            if (!this.temp) {
                this.fieldOptions = null;
            } else {
                this.fieldOptions = data.map(field => {
                    return { label: field.label, value: field.value };
                });
            }
            
        } else if (error) {
            
            console.error('Error retrieving fields for sObject', error);
        }
    }

    

    handleFieldChange(event) {
        this.selectedFields = event.detail.value;
    }
    generateQuery() {
        if (this.selectedFields.length > 0) {
            this.query = `SELECT ${this.selectedFields.join(', ')} FROM ${this.selectedObject}`;
        } else {
            this.query = 'Please select at least one field.';
        }
    }  
}