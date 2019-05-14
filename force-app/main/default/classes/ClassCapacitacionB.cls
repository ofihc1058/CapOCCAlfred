public class ClassCapacitacionB {
    //Public Account CuentaOcc { get; set;}
    public static List<AccountHijoBenjamin__c> persistedContacts;
    
    public ClassCapacitacionB(){
        system.debug('Ejecutando constructor');
    }
    
    public static void informationContact(List<AccountHijoBenjamin__c> cc){
        persistedContacts = cc;
    }
    
    public static List<AccountHijoBenjamin__c> informationContactToAfter(){
        return persistedContacts;
    }
    
    public static String EmailReturnedAccount(Id idacc){
        AccountBenjamin__c acc = new AccountBenjamin__c();
		acc = [Select Phone__c From AccountBenjamin__c Where Id =: idAcc Limit 1];
        return acc.Phone__c;
    }
    
    @future(callout=true)  //tipos de metodos se definene con notaciones 
    public static void httpInformationTrigger(){
        HttpRequest solicitud = new HttpRequest();
        solicitud.setEndpoint('https://doitapplicationcloud.herokuapp.com/projects');
        solicitud.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(solicitud);
        //List<String> test = new List<String>();
  		//test = (List<String>)System.JSON.deserialize(res.getBody(), List<String>.class);
  		system.debug(res.getBody());
  		//system.debug(test);
  		//system.debug((List<String>)System.JSON.deserialize(res.getBody(), List<String>.class));
    }
}

    
    
/*
public class ClassCapacitacionB {
    //Public Account CuentaOcc { get; set;}
    
    public ClassCapacitacionB(){
        system.debug('Ejecutando constructor');
    }
    
    public static String EmailReturnedAccount(Id idacc){
        AccountBenjamin__c acc = new AccountBenjamin__c();
		acc = [Select Phone__c From AccountBenjamin__c Where Id =: idAcc Limit 1];
            
        
        return acc.Phone__c;
    }
    
}
*/