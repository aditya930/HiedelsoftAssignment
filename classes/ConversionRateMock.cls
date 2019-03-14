@isTest
global class ConversionRateMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"rates":{"MXN":21.821,"AUD":1.6005,"HKD":8.8728,"RON":4.7737,"HRK":7.4175,"CHF":1.1373,"IDR":16091.85,"CAD":1.5087,"USD":1.1303,"ZAR":16.1987,"JPY":125.89,"BRL":4.326,"HUF":314.6,"CZK":25.668,"NOK":9.7245,"INR":78.662,"PLN":4.2993,"ISK":133.2,"PHP":59.572,"SEK":10.554,"ILS":4.0861,"GBP":0.8588,"SGD":1.5325,"CNY":7.5818,"TRY":6.1771,"MYR":4.6224,"RUB":74.0008,"NZD":1.6538,"KRW":1279.12,"THB":35.729,"BGN":1.9558,"DKK":7.4601},"base":"EUR","date":"2019-03-13"}');
        res.setStatusCode(200);
        return res; 
    }
}