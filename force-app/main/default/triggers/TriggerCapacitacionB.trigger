trigger TriggerCapacitacionB on Account (before insert, after insert, after update) {
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