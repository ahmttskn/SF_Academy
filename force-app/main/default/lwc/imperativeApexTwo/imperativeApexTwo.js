/**
 * @description       : 
 * @author            : Huseyin
 * @group             : 
 * @last modified on  : 08-16-2022
 * @last modified by  : Huseyin
**/
import { getObjectInfo, getPicklistValues } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import getAccountsByIndustry from '@salesforce/apex/AccountCtrl.getAccountsByIndustry';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

const COLUMNS = [
    {label: "Account Name", fieldName: "Name", type: "text"},
    {label: "Account Type", fieldName: "Type", type: "text"},
    {label: "Industry", fieldName: "Industry", type: "text"},
    {label: "Annual Revenue", fieldName: "AnnualRevenue", type: "currency"}
];

export default class ImperativeApexTwo extends LightningElement {
    accountRtId;
    industryOptions = [];
    columns = COLUMNS;
    selectedIndustry;
    accounts;
    error;

    @wire(getObjectInfo, {objectApiName: ACCOUNT_OBJECT})
    objectInfoHandler({data, error}) {
        if(data) {
            this.accountRtId = data.defaultRecordTypeId;
        }
    }

    @wire(getPicklistValues, {fieldApiName: INDUSTRY_FIELD, recordTypeId: '$accountRtId'})
    picklistHandler({data, error}) {
        if(data) {
            this.industryOptions = data.values;
        }
    }

    changeHandler(event) {
        this.selectedIndustry = event.target.value;
        getAccountsByIndustry({industry: this.selectedIndustry})
            .then(result => {
                this.accounts = result;
                this.error = undefined;
                if(this.accounts.length == 0) {
                    this.accounts = undefined;
                    this.error = "No matching accounts found for the selected industry!";
                }
            })
            .catch(error => {
                this.error = error;
                this.accounts = undefined;
            })
    }
}