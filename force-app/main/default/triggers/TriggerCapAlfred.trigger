trigger TriggerCapAlfred on AccountAlfred__c (before insert, after insert, after update) {

	List<AccountjrAlfred__c> listContacts = new List<AccountjrAlfred__c>();

if(trigger.isBefore && trigger.isInsert){
listContacts.add(new AccountjrAlfred__c(Name = 'Hugo')); 
listContacts.add(new AccountjrAlfred__c(Name = '1Hugo'));
listContacts.add(new AccountjrAlfred__c(Name = '2Hugo')); 
ClassCapatacion.informationContact(listContacts);
}

if(trigger.isAfter && trigger.isInsert){
    listContacts = ClassCapatacion.informationContactToAfter();
  	for(AccountjrAlfred__c cc: listContacts)
		cc.Accoun_padre__c = trigger.new[0].Id;

		System.debug(listContacts);
}

    
    if(trigger.isAfter){
        ClassCapatacion.httpInformationTrigger();
    }
/**

if(trigger.isAfter && trigger.isUpdate){
System.debug(' Me estoy ejecutando al actualizar'); 

String toDebug = ClassCapacitacion.EmailReturnedAccount(trigger.new[0].id);
System.debug('my fax: ' + toDebug); 
}
*/
}