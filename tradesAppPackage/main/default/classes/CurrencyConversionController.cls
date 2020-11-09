public inherited sharing class CurrencyConversionController {

    @AuraEnabled
    public static map<String, Object> retriveCurrencyConversionRates(String strEndPointURL){
        map<String, Object> mapJsonData = new map<String, Object>();
        String strResponse = null;
        if(String.isNotBlank(strEndPointURL)) {
            HttpRequest httpRequest = new HttpRequest();  
            httpRequest.setEndpoint(strEndPointURL);

            httpRequest.setMethod('GET');   
            
            try {  
                Http http = new Http();   
                HttpResponse httpResponse = http.send(httpRequest);  

                if (httpResponse.getStatusCode() == 200 ) {  
                    strResponse = httpResponse.getBody();  
                } 
                else {  
                    throw new CalloutException(httpResponse.getBody());  
                }   
            } 
            catch(Exception ex) {  
                throw ex;  
            }  
        } 

        if(!String.isBlank(strResponse)) {
            mapJsonData = (map<String, Object>)JSON.deserializeUntyped(strResponse);
            System.debug('mapJsonData ===> '+mapJsonData);
        }

        if(!mapJsonData.isEmpty()) {
            return mapJsonData;
        }
        else {
            return null;
        }
    }
}