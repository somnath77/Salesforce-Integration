public with sharing class addressValidation {
    public addressValidation() {

    }
    @AuraEnabled
    public static String validateAddress(String address){
        String resp;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('callout:Geoapify?text='+EncodingUtil.urlEncode(address, 'UTF-8')+'&apiKey='+API_KEY_HERE);

        HttpResponse res = http.send(req);
        System.debug('RES:' + res.getBody());
        System.debug('RES:' + res.getStatusCode());
        if(res.getStatusCode() != 200){
            resp = 'issue in api call';
        }
        geoapifyResultParser resParsed = (geoapifyResultParser)JSON.deserialize(res.getBody(), geoapifyResultParser.class);
        System.debug('resParsed:' + resParsed);
        if (res.getStatusCode()==200 && !resParsed.features.isEmpty()) {
            Decimal confidence = resParsed.features[0].properties.rank.confidence;
            System.debug('Confidence = ' + confidence);
            resp='Confidence = ' + confidence;
        } else {
            resp=resp!=null ? resp : 'No result found';
        }
        return resp;
    }
}