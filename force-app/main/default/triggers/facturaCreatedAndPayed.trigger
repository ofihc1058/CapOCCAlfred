trigger facturaCreatedAndPayed on Opportunity (after insert) {
		Integer i=0;
		Opportunity o ; 
		for(i=0; i<Trigger.size;i++) {
			o =  Trigger.new[i];
				if(Trigger.new[i].EstatusFactura__c=='Cobrada'){
					appServiceFacturacionSAPWS.generateSAPCFD(o.Id, appServiceFacturacionSAPWS.CFDYPAGO);
				}
		}	
}