import { LightningElement } from 'lwc';

// importing apex class to make callout
import getCurrencyData from '@salesforce/apex/CurrencyConversionController.retriveCurrencyConversionRates';

export default class NewTradeComponent extends LightningElement {

    buyCurrencyValue;
    sellCurrencyValue;
    sellAmountValue;
    buyAmountValue;
    rate;

    handleSuccess(event) {
        console.log('onsuccess event recordEditForm',event.detail.id);
        var url = window.location.href;
        var redirectURL = url.substr(0,url.lastIndexOf('/cmp/') + 1) + 'n/Booked_Trades';
        window.location = redirectURL;
    }

    handleError(event) {
        console.log('onerror event recordEditForm',event.detail);
        console.log('onerror event detail',event.detail.detail);
    }

    handleSubmit(event) {
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        fields.Rate__c = this.rate;
        fields.Buy_Amount__c = this.buyAmountValue;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        console.log('onsubmit event recordEditForm'+ event.detail.fields);
    }

    handleCancel(event){
        var url = window.location.href;
        var redirectURL = url.substr(0,url.lastIndexOf('/cmp/') + 1) + 'n/Booked_Trades';
        window.location = redirectURL;
    }

    // Calculate Buy Amount
    handleSellAmountChange(event) {
        this.sellAmountValue = event.detail.value;
        if(this.rate && this.sellAmountValue){
            this.buyAmountValue = (this.sellAmountValue * this.rate).toFixed(2);
        } else {
            this.buyAmountValue = null;
        }
    }

    // Getting sell currency value
    handleSellCurrencyChange(event) {
        this.sellCurrencyValue = event.detail.value;
        if(this.buyCurrencyValue && this.sellCurrencyValue){
            this.handleCurrencyConversion();
        } else {
            this.rate = null;
            this.buyAmountValue = null;
        }
    }

    // getting buy currency value
    handleBuyCurrencyChange(event) {
        this.buyCurrencyValue = event.detail.value;
        if(this.sellCurrencyValue && this.buyCurrencyValue){
            this.handleCurrencyConversion();
        } else {
            this.rate = null;
            this.buyAmountValue = null;
        }
    }


    // Making Callout using Fetch
    handleCurrencyConversion() {
        let endpointURL = 'http://data.fixer.io/api/latest?access_key=b831ee4392d4f2acf242d71c8e9c0755&base=' 
        + this.sellCurrencyValue + '&symbols=' + this.buyCurrencyValue;
        
        // calling apex class method to make callout
        getCurrencyData({strEndPointURL : endpointURL})
        .then(data => {

            window.console.log('jsonResponse ===> '+JSON.stringify(data));

            // retriving the response data
            let exchangeData = data['rates'];
            
            this.rate = exchangeData[this.buyCurrencyValue];

            if(this.rate && this.sellAmountValue){
                this.buyAmountValue = (this.sellAmountValue * this.rate).toFixed(2);
            } else {
                this.buyAmountValue = null;
            }

        })
        .catch(error => {
            window.console.log('callout error ===> '+JSON.stringify(error));
        })
    } 

}