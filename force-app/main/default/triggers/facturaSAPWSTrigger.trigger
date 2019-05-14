trigger facturaSAPWSTrigger on Opportunity (before update) {
    Integer i=0;
    Opportunity o ; 
    for(i=0; i<Trigger.size;i++) {
      o =  Trigger.new[i];
      if((Trigger.new[i].Factura_Aprobada__c==true&&Trigger.old[i].Factura_Aprobada__c==false ) &&
      (Trigger.new[i].Factura_cobrada__c==true&&Trigger.old[i].Factura_cobrada__c==false) ){
        //appServiceFacturacionSAPWS.generateSAPCFD(o.Id, appServiceFacturacionSAPWS.CFDYPAGO);
        appServiceFacturacionSAPWSCFDI.generateSAPCFDIWS(o.Id, appServiceFacturacionSAPWS.CFDYPAGO); //Validar si se queda asi o se sigue dejando esta linea
        appServicePaymentSAPWS.paymentSAPWS(o.Id);
        
      }
      else{
        if(Trigger.new[i].Factura_Aprobada__c==true&&Trigger.old[i].Factura_Aprobada__c==false){
          //appServiceFacturacionSAPWS.generateSAPCFD(o.id,'');
          //system.debug('Mando llamar factura:');  
          appServiceFacturacionSAPWSCFDI.generateSAPCFDIWS(o.id,'');
        }      
        if(Trigger.new[i].Factura_cobrada__c==true&&Trigger.old[i].Factura_cobrada__c==false){
          system.debug('Cobrada' + Trigger.new[i].Factura_cobrada__c);
          //appServiceFacturacionSAPWS.generateSAPPago(o.id);
          appServicePaymentSAPWS.paymentSAPWS(o.Id);
        }
      }
    }
}