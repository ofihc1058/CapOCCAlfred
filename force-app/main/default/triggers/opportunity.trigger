trigger opportunity on Opportunity (after insert, before update)
{
  //Validacion por evento antes de ejecucion
  //system.debug('Entre');
    if(trigger.isInsert){
        //system.debug('isinsert');
        if(trigger.isAfter)
        {
            //system.debug('isAfter');
            //Despues de insertar la oportunidad actaliza el CIE que es de lectura
            for(Opportunity o : trigger.new)
            {
                //system.debug('Actualizo:' + o.Id);
                Funciones.CreateCieValue(o.Id, o.NumFact__c.substring(6, o.NumFact__c.length()));
            }
            //Fin FacturaCreatedAdPayed
        }
    }   
    /*if(trigger.isUpdate){
        if(trigger.isBefore)
        {
            for(Opportunity opp : trigger.new)
              {
                opp.Tipo_de_Facturacion__c = trigger.oldMap.get(opp.Id).Tipo_de_Facturacion__c;
              }     
        }
    }*/
}