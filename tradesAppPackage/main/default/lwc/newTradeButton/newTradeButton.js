import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NewTradeButton extends NavigationMixin(LightningElement) {
    handleNavigate() {
        this[NavigationMixin.Navigate]({
            type: "standard__component",
            attributes: {
                componentName: "c__navigateToLWC"
            }
        });
    }
}