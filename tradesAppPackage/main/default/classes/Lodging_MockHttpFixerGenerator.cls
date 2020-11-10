@isTest
global class Lodging_MockHttpFixerGenerator implements HttpCalloutMock{
    
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://data.fixer.io/api/latest?access_key=b831ee4392d4f2acf242d71c8e9c0755&base=EUR&symbols=USD', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setStatusCode(200);
		res.setBody('{"success": true,"timestamp": 1605015845,"base": "EUR","date": "2020-11-10","rates": {"GBP": 0.891562}}');
        return res;
    }

}