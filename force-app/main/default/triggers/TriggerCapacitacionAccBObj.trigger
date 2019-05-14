trigger TriggerCapacitacionAccBObj on AccountBenjamin__c (before insert, after insert, after update) {
    
    List<AccountHijoBenjamin__c> listContacts = new List<AccountHijoBenjamin__c>();
    
    if(trigger.isBefore && trigger.isInsert){
        listContacts.add(new AccountHijoBenjamin__c(Name = 'Hugo1', LastName__c = 'Hernández', Email__c = 'hugo@occ.mx'));        
        listContacts.add(new AccountHijoBenjamin__c(Name = '1Hugo1', LastName__c = '1Hernández', Email__c = '1hugo@occ.mx'));
        listContacts.add(new AccountHijoBenjamin__c(Name = '2Hugo1', LastName__c = '2Hernández', Email__c = '2hugo@occ.mx')); 
        ClassCapacitacionB.informationContact(listContacts);
        System.debug(listContacts);
    }
    
    if(trigger.isAfter && trigger.isInsert){
        listContacts = ClassCapacitacionB.informationContactToAfter();
        for(AccountHijoBenjamin__c cc: listContacts)
            cc.Account_Benjamin__c = trigger.new[0].Id;
        
        System.debug(listContacts);
    }
    if (trigger.isAfter){
    	ClassCapacitacionB.HttpInformationTrigger();    
    }
}
    /**

    if(trigger.isAfter && trigger.isUpdate){
        System.debug(' Me estoy ejecutando al actualizar');   
         
     String toDebug = ClassCapacitacion.EmailReturnedAccount(trigger.new[0].id);
        System.debug('my fax: ' + toDebug);  
    }

}
*/
/*
trigger TriggerCapacitacionAccBObj on AccountBenjamin__c (before insert, after insert, after update) {
    
    List<AccountHijoBenjamin__c> listContacts = new List<AccountHijoBenjamin__c>();
    
    if(trigger.isBefore && trigger.isInsert){
        listContacts.add(new AccountHijoBenjamin__c(Name = 'Hugo', LastName__c = 'Hernández', Email__c = 'hugo@occ.mx'));        
        listContacts.add(new AccountHijoBenjamin__c(Name = '1Hugo', LastName__c = '1Hernández', Email__c = '1hugo@occ.mx'));
        listContacts.add(new AccountHijoBenjamin__c(Name = '2Hugo', LastName__c = '2Hernández', Email__c = '2hugo@occ.mx'));        
        System.debug(listContacts);
    }
    
    if(trigger.isAfter && trigger.isInsert){
        ClassCapacitacionB clsCap= new ClassCapacitacionB();
        for(AccountHijoBenjamin__c cc: listContacts)
            cc.Account_Benjamin__c = trigger.new[0].Id;
        
        System.debug(listContacts);
    }
*/   
    /**

    if(trigger.isAfter && trigger.isUpdate){
        System.debug(' Me estoy ejecutando al actualizar');   
         
     String toDebug = ClassCapacitacion.EmailReturnedAccount(trigger.new[0].id);
        System.debug('my fax: ' + toDebug);  
    }

}
*/


/*
 trigger TriggerCapacitacionAccBObj on AccountBenjamin__c (before insert, after insert, after update) {
    if(trigger.isBefore ){
    	System.debug(' Me estoy ejecutando antes de insertar'); 
    }
    
    if(trigger.isAfter && trigger.isInsert ){
    	//System.debug(' Me estoy ejecutando depues de insertar'); 
    	ClassCapacitacionB clsCap= new ClassCapacitacionB();
    }
    
    if(trigger.isInsert){
    	System.debug('Me estoy ejecutando al insertar'); 
    }
    
    if(trigger.isAfter  && trigger.isUpdate){
    	System.debug('Me estoy ejecutando al actualizar'); 
        string toDebug = ClassCapacitacionB.EmailReturnedAccount(trigger.new[0].Id);
        system.debug('My Phone: ' + toDebug);
    }
}
*/

/** Clase de pruebas
 * 
 //ClassCapacitacion clsCap = new ClassCapacitacion();

AccountBenjamin__c acc = new AccountBenjamin__c();
acc.NamePersonal__c = 'Occ With Trigger and differents events 3';

insert acc;
System.debug('Inserted account: ' + acc.Id);

acc.Phone__c = '1029384756';
acc.Fax__c = '0000384756';
update acc;

System.debug('Account: ' + acc);
 * 
 * **/