public class ClassCapacitacionDeveloper {
	
    public static List<YisusHijo__c> listHijos;
        
    public ClassCapacitacionDeveloper() {
        System.debug('Ejecutando desde nuestro constructor');
    }
    
    public static void InformationContact(List<YisusHijo__c> hijos) {
        listHijos = hijos;
    }
    
    public static List<YisusHijo__c> InformationContactToAfter() {
        return listHijos;
    }
    
    @future(callout=true)
    public static void HttpInformationTrigger() {
        HttpRequest solicitud = new HttpRequest();
        solicitud.setEndpoint('https://doitapplicationcloud.herokuapp.com/projects');
        solicitud.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(solicitud);
        System.debug((List<Object>) System.JSON.deserialize(res.getBody(), List<Object>.class));
        //System.debug(res.getBody());
    }
    
    public static String EmailReturnedAccount(Id idAcc) {
        
        Yisus__c acc = new Yisus__c();
    	acc = [ SELECT Fax__c FROM Yisus__c WHERE Id =: idAcc LIMIT 1];
        System.debug(acc);
        return acc.Fax__c;
    }
}