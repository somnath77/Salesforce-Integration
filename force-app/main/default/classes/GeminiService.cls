public with sharing class GeminiService {
    public GeminiService() {

    }
    Static String API_KEY='<API_KEY_HERE>';
    @AuraEnabled
    public static String callGeminiApi(String question) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Gemini?key='+API_KEY);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        String body = createBody(question);
        req.setBody(body);

        Http http = new Http();
        HttpResponse res = http.send(req);
        System.debug('res---'+res);
        System.debug('res---'+res.getBody());
        return res.getBody();
    }
    public static String createBody(String question){
        Map<String, Object> textEntry = new Map<String, Object>{'text'=>question};
        List<Object> partsList = new List<Object>{textEntry};
    
        Map<String, Object> partsWrapper = new Map<String, Object>{'parts'=> partsList};
    
        List<Map<String, Object>> contentsList = new List<Map<String, Object>>{partsWrapper};
    
        Map<String, Object> root = new Map<String, Object>{'contents'=>contentsList};
    
        return JSON.serialize(root);
    }
}