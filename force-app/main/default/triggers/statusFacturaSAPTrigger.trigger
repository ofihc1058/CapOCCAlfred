trigger statusFacturaSAPTrigger on StatusFactura__c (after insert, after update) {
		Integer i=0;
		StatusFactura__c statusFactura;
		for(i=0; i<Trigger.size;i++) {
			statusFactura =  Trigger.new[i];
			system.debug('Mando llamar status factura:' + JSON.serialize(statusFactura));
			//appServiceFacturacionSAPWS.updateStatusFactura(statusFactura.OpportunityId__c);
			appServiceFacturacionSAPWSCFDI.updateStatusFactura(statusFactura.OpportunityId__c);	
		}
}