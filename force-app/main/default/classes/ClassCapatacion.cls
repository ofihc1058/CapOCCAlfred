public class ClassCapatacion {

public static List<AccountjrAlfred__c> persistedContacts;

public ClassCapatacion(){
System.debug('Ejecutando desde nuestro contructor');
}

public static void informationContact(List<AccountjrAlfred__c> cc){
persistedContacts = cc;
}

public static List<AccountjrAlfred__c> informationContactToAfter(){
return persistedContacts;
}
    
    @future(callout=true)
    public static Void httpinformationTrigger(){
        HttpRequest solicitud = new httpRequest();
        solicitud.setEndpoint('https://doitapplicationcloud.herokuapp.com/projects');
        solicitud.setMethod('GET');
        
        
        Http http = new Http();
       	HTTPResponse res = http.send(solicitud);
        List<string> test = new List<String>();
        test = (list<String>) System.JSON.deserialize(res.getBOdy(), List<String>.class);
        System.debug(res.getBody());
                              
                              
    }

public static String EmailReturnedAccountAlfred(Id idAcc){
    AccountAlfred__c acc = new AccountAlfred__c();
    acc = [SELECT Fax__c From AccountAlfred__c WHERE id=: idAcc LIMIT 1];
        
        return acc.Fax__c; 
	 
}


}