
import { LightningElement , wire } from 'lwc';
import getTradeList from '@salesforce/apex/TradeHelper.getTradeList';

export default class Trade_DataTable extends LightningElement {

    sortedBy;
    sortedDirection;
    error;
    tradeList ;

    columns = [{
        label: 'Sell CCY',
        fieldName: 'Sell_Currency__c',
        type: 'text',
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true
    },
    {
        label: 'Sell Amount',
        fieldName: 'Sell_Amount__c',
        type: 'number',
        typeAttributes: {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        },
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true
    },
    {
        label: 'Buy CCY',
        fieldName: 'Buy_Currency__c',
        type: 'text',
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true
    },
    {
        label: 'Buy Amount',
        fieldName: 'Buy_Amount__c',
        type: 'number',
        typeAttributes: {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        },
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true
    },
    {
        label: 'Rate',
        fieldName: 'Rate__c',
        type: 'number',
        typeAttributes: {
            minimumFractionDigits: 1,
            maximumFractionDigits: 5
        },
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true
    },
    {
        label: 'Date Booked',
        fieldName: 'Date_Booked__c',
        type: 'date', 
        typeAttributes: {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        },
        cellAttributes: { alignment: 'left' },
        hideDefaultActions: true,
        sortable: true
    }
    ];
    
    @wire(getTradeList)
    wiredTrades({
        error,
        data
    }) {
        if (data) {
            this.tradeList = data;
        } else if (error) {
            this.error = error;
        }
    }

    updateColumnSorting(event) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
   }

   sortData(fieldname, sortDirection) {
        // serialize the data before calling sort function
        let parseData = JSON.parse(JSON.stringify(this.tradeList));

        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };

        // cheking reverse direction 
        let isReverse = sortDirection === 'asc' ? 1: -1;

        // sorting data 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';

            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });

        // set the sorted data to data table data
        this.tradeList = parseData;

    }
    
}
