import { api, LightningElement, track, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import MAILINGSTREET_FIELD from "@salesforce/schema/Contact.MailingStreet";
import MAILINGCITY_FIELD from "@salesforce/schema/Contact.MailingCity";
import MAILINGCOUNTRY_FIELD from "@salesforce/schema/Contact.MailingCountry";
import MAILINGSTATE_FIELD from "@salesforce/schema/Contact.MailingState";
import MAILINGPOSTALCODE_FIELD from "@salesforce/schema/Contact.MailingPostalCode";

import validateAddress from'@salesforce/apex/addressValidation.validateAddress';

export default class AddressValidation extends LightningElement {
    @api recordId;
    @track showResult = false;
    @track result;
    @track contact = {
        street: '',
        city: '',
        country: '',
        province: '',
        postalCode: ''
    }

    @wire(getRecord, { 
        recordId: '$recordId', 
        fields: [
            MAILINGSTREET_FIELD,
            MAILINGCITY_FIELD,
            MAILINGCOUNTRY_FIELD,
            MAILINGSTATE_FIELD,
            MAILINGPOSTALCODE_FIELD
        ]
    })
    getContactRecord({data, error}) {
        
        if (data) {
            this.contact.street = data.fields?.MailingStreet?.value || '';
            this.contact.city = data.fields?.MailingCity?.value || '';
            this.contact.country = data.fields?.MailingCountry?.value || '';
            this.contact.province = data.fields?.MailingState?.value || '';
            this.contact.postalCode = data.fields?.MailingPostalCode?.value || '';
            
            this.showResult = true;
            this.result = 'Address loaded successfully';
        } else if (error) {
            console.log('Error:', error.body.message);
            this.showResult = true;
            this.result = 'Error: ' + error.body.message;
        }
    }
    handleFieldChange(event){
        this.contact.street = event.target.street;
        this.contact.city = event.target.city;
        this.contact.country = event.target.country;
        this.contact.province = event.target.province;
        this.contact.postalCode = event.target.postalCode;
    }

    async handleValidateAddress(event) {
        try{
            const inputAddress = this.contact.street+','+this.contact.city+','+this.contact.province+','+this.contact.country+','+this.contact.postalCode;
            const res = await validateAddress({address: inputAddress});
            console.log('result: '+res);
            this.result = res;
            
        } catch(e){
            console.log('error: '+e.body.message);
            
        }
    }
}