import { LightningElement, api, wire } from 'lwc';
import getNumberofContact from '@salesforce/apex/UpdateNumberOfContacts.getNumberofContact';
import getAccounts from '@salesforce/apex/UpdateNumberOfContacts.getAccounts';
import callHttp from '@salesforce/apex/UpdateNumberOfContacts.callHttp';


export default class NumberOfContacts extends LightningElement {
//   @api recordId ='0015g00000V1rAeAAJ'; // Account record Id
  @api recordId; // Account record Id

    numberOfContacts;
    accounts;
    index = 0;
    connectedCallback() {
        // Question 1 
        getNumberofContact ({record_Id:this.recordId})
            .then((result) => {
                console.log('result for number of contact -->  ', result);
                this.numberOfContacts = result;
            })
            .catch((error) => {
                console.log('error for number of contact -->  ', error);
            });


            // Question 2 
        getAccounts({})
            .then((result) => {
                console.log('result for getAccounts -->  ', result);
                // this.accounts = result;
                this.accounts = result.map((account, index) => {
                    return {
                        ...account,
                        index: index + 1
                    }
                });
                console.log('accounts :', this.accounts)
            })
            .catch((error) => {
                console.log('error for getAccounts -->  ', error);
            })

        callHttp({})
            .then((result) => {
                console.log('result for callHttp -->  ', result);
            })
            .catch((error) => {
                console.log('error for callHttp -->  ', error);
            })
    }
}