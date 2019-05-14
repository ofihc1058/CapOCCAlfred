trigger Presupuesto on Quote (before update, after update) {
	Set<String> quoteToInsert = new Set<String>();
	Set<String> quoteToDelete = new Set<String>();
	if(trigger.isBefore)
	{
		if(trigger.isUpdate)
		{
			//Cuando actualiza la oprtunidad si se cambia alguno de los datos de facturacion reenvia esta informacion a OOCM para su actualizacion
			System.debug('Entro a buscar cambios');
			for(Quote qte : trigger.new)
			{
				system.debug('qte.Is_Future_Context__c' + qte.Is_Future_Context__c);
				if(qte.Is_Future_Context__c)
				{
					qte.Is_Future_Context__c = false;
				}
				else
				{
					if (qte.IsSyncing!=true){
						WSSalesforceRecluta.DeleteListProductsInOpportunity(qte.Id);
					}
					else
					{
						//WSSalesforceRecluta.CompleteListProductsInQuote(qte.Id);
						//quoteToInsert.add(qte.Id);
					}
				}
				//if(qte.Is_Future_Context__c){
				//	qte.Is_Future_Context__c=false;
				//}
				
			}
			
			//if(!quoteToInsert.isEmpty() && triggerhelper.b)
			//{
			//	system.debug('Voy a insertar productos en quote');
			//	WSSalesforceRecluta.CompleteListProductsInQuote(quoteToInsert);
			//}
		}
	}
}