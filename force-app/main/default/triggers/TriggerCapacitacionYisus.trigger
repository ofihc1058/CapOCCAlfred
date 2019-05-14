trigger TriggerCapacitacionYisus on Yisus__c (before insert, after insert, after update) {

   List<YisusHijo__c> listHijos = new List<YisusHijo__c>();
    if(trigger.isBefore && trigger.isInsert){
       System.debug(' Me estoy ejecutando antes de insertar');
       listHijos.add(new YisusHijo__c(Name= 'Hijo1'));
       listHijos.add(new YisusHijo__c(Name= 'Hijo2'));
       listHijos.add(new YisusHijo__c(Name= 'Hijo3'));
       ClassCapacitacionDeveloper.InformationContact(listHijos);
       System.debug(listHijos);
   }

   if(trigger.isAfter && trigger.isInsert){
        listHijos = ClassCapacitacionDeveloper.InformationContactToAfter();
        for(YisusHijo__c cc: listHijos)
        	cc.Yisus__c = trigger.new[0].Id;
        
        System.debug('Listado: ' + listHijos);
   }

   if(trigger.isAfter){
       System.debug(' Me estoy ejecutando al insertar');
       ClassCapacitacionDeveloper.HttpInformationTrigger();
   }

   if(trigger.isAfter && trigger.isUpdate){
       System.debug(' Me estoy ejecutando al actualizar');
       String toDebug = ClassCapacitacionDeveloper.EmailReturnedAccount(trigger.new[0].id);
       System.debug('My fax: ' + toDebug);
   }
}