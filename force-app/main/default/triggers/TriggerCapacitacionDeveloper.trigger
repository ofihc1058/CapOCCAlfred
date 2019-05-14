trigger TriggerCapacitacionDeveloper on Account (before insert, after insert) {
   if(trigger.isBefore){
       System.debug(' Me estoy ejecutando antes de insertar');
   }

   if(trigger.isAfter && trigger.isInsert){
       ClassCapacitacionDeveloper clsCap = new ClassCapacitacionDeveloper();
   }

   if(trigger.isInsert){
       System.debug(' Me estoy ejecutando al insertar');
   }

   if(trigger.isUpdate){
       System.debug(' Me estoy ejecutando al actualizar');
   }
}