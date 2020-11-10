@isTest
public class CurrencyConversionControllerTest
{
    @isTest
    static void retriveCurrencyConversionRates()
    {
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new Lodging_MockHttpFixerGenerator());
        
       CurrencyConversionController.retriveCurrencyConversionRates('http://data.fixer.io/api/latest?access_key=b831ee4392d4f2acf242d71c8e9c0755&base=EUR&symbols=USD');
        
        Test.stopTest();
    }
    
}