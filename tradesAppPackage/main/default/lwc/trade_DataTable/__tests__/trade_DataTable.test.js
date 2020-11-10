import { createElement } from 'lwc';
import Trade_DataTable from 'c/trade_DataTable';

describe('c-trade_-data-table', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('TODO: test case generated by CLI command, please fill in test logic', () => {
        const element = createElement('c-trade_-data-table', {
            is: Trade_DataTable
        });
        document.body.appendChild(element);
        expect(1).toBe(1);
    });
});