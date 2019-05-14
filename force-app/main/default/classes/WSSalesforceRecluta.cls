/// <summary> Web service expuesto en internet para la comunicaicon entre OCCM y Salesforce Los metodos que comienzan con WSXXXXXX son los que estan expuestos a internet /// </summary>
global class WSSalesforceRecluta {
	
	/// <summary> Metodo que solicita la informacion de paquetes contratados de una cuenta se le envia el accountId
    /// </summary>
    /// <param name="inputOpportunityId">Id de la cuenta que se va a enviar.</param>
    /// <returns>regresa el JSON indicando si se realizo la actualizacion o porque motivo no se realizo. 
    /// </returns>
	webservice static OCCMClases.ExecutionResult GetContractedPackages(String accountId){
		//system.debug('AccountId' + inputAccountId);
    	system.debug('Entre al metodo de GetCotractedPakcages de cuenta');
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        String AccountSummaryDataInfoJson='';
        system.debug('Obtengo informacion de la cuenta');
		executedStatusResult = GetAccountSummaryUsingAccountId(accountId , 'C', 'cuentavacia@nohacercaso.com');
	    if (executedStatusResult.success==true){
	       	OCCMClases.AccountSummary AccountSummaryDataInfo=(OCCMClases.AccountSummary)executedStatusResult.objectResult;
	       	//system.debug('AccountSummaryDataInfo:' + AccountSummaryDataInfo);
	       	system.debug('Mando llamar metodo de obtencion de informacion de cuenta');
	       	executedStatusResult=RecruiterDataServiceWrapper.SendGetContractedPackages(AccountSummaryDataInfo);
	       	system.debug('SendGetContractedPackages:' + executedStatusResult.message);
	    }
		result = JSON.serialize(executedStatusResult);
		system.debug('Resultado de cuenta:' + result);
        return executedStatusResult; 
	}
	webservice static String InsertCieValue(String oppId, String oportunityId)
	{
		String messageResult='';
		//system.debug('Entre a CreateCieValue. ');
		Opportunity opp;
		try
		{
			opp = [SELECT Id, Referencia_Bancaria__c FROM Opportunity WHERE Id =: oppId];
			if(opp != null)
			{
				opp.Referencia_Bancaria__c = Funciones.GenerateOpportunityCie(oportunityId);
				//system.debug('antes de actualizar referencia = ' + opp.Referencia_Bancaria__c);
				update opp;
				messageResult='Referencia actualizada exitosamente';
				//system.debug('despues de actualizar referencia = ' + opp.Referencia_Bancaria__c);
			}
		}
		catch(Exception e)
		{
			//system.debug('Error al obtener la opp. ' + e.getMessage());
			messageResult +='Exepcion InsertCieValue error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		return messageResult;
	}
	

	webservice static String MigrateAccount(String inputAccountId, String migrationOption, String emailMigration){
		return MigrateAccountMethod(inputAccountId, migrationOption, emailMigration);
	}
	/// <summary> Mtodo que solicita la informacion de una cuenta determinando si esta migrada o no, se le envia el accountId
    /// </summary>
    /// <param name="inputOpportunityId">Id de la cuenta que se va a enviar.</param>
    /// <param name="statusOportunity">Estatus a insertar de la oportunidad.</param>
    /// <param name="virtualAccount">Cuenta virtual de la cuenta a la que pertenece la oportunidad.</param>
    /// <returns>regresa el JSON indicando si se realizo la actualizacion o porque motivo no se realizo. 
    /// </returns>
    public static String MigrateAccountMethod(String inputAccountId, String migrationOption, String emailMigration){
    	//system.debug('AccountId' + inputAccountId);
    	system.debug('Entre al metodo de Migracion de cuenta');
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.AccountSummary AccountSummaryDataInfo= new OCCMClases.AccountSummary();
        String AccountSummaryDataInfoJson='';
        system.debug('Obtengo informacion de la cuenta');
		executedStatusResult = GetAccountSummaryUsingAccountId(inputAccountId, migrationOption, emailMigration);
	    if (executedStatusResult.success==true){
	    	system.debug('Obtuve informacion de cuenta positivo');
	       	AccountSummaryDataInfo=(OCCMClases.AccountSummary)executedStatusResult.objectResult;
	       	//system.debug('AccountSummaryDataInfo:' + AccountSummaryDataInfo);
	       	system.debug('Mando llamar metodo de migracion de cuenta');
	       	executedStatusResult=RecruiterDataServiceWrapper.SendMigrationAccount(AccountSummaryDataInfo, inputAccountId);
	    }
		result = JSON.serialize(executedStatusResult);
		system.debug('Resultado de cuenta:' + result);
        return result; 
    }
    
	/// <summary> Metodo para validar si esta migrado una cuenta.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String IsNewBusinessModelAccount(String inputAccountId){
    	return IsNewBusinessModelAccountMethod(inputAccountId);
    }
    public static String IsNewBusinessModelAccountMethod(String inputAccountId){
    	system.debug('AccountId' + inputAccountId);
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    executedStatusResult=RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(inputAccountId);
		result = JSON.serialize(executedStatusResult);
        return result; 
    }
    
    webservice static String CompleteListProductsInQuote(String quoteId){
    	return CompleteListProductsInQuoteMethod(quoteId);
    }

	/// <summary> Metodo que en base a un presupuesto actualiza de la lista de productos las cortesias y descuentos  
    /// </summary>
    /// <param name="quoteId">Id del presupuesto.</param>
    /// <returns>En caso de error regresa el error, si no existe el error regresa vacio. 
    /// </returns>
    public static String CompleteListProductsInQuoteMethod(String quoteId){
    	String result='';// 'Error en proceso: ' + 'quoteId:' + quoteId;
		Quote presupuesto;
		List <QuoteLineItem> productosPresupuesto;
		Opportunity oportunidad;
		List<QuoteLineItem> productosPorInsertar = new List<QuoteLineItem>();
		Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
 	
		//system.debug('quoteId:' + quoteId );
		try
		{
			presupuesto = [SELECT Id, Name, OpportunityId, Is_Future_Context__c FROM Quote WHERE Id =: quoteId];
		}
		catch(Exception e)
		{
			messageResult +='Exepcion CompleteListProductsInOpportunity presupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		if(presupuesto != null)
		{
			try
			{
				//system.debug('presupuesto.Id' + presupuesto.Id);
				productosPresupuesto = [SELECT Id, Vacante_de_Cortes_a__c, Descuento2__c, Pda_s_incluidos__c,  PricebookEntry.Product2.Id, PricebookEntry.Product2.Name, UnitPrice, Quantity FROM QuoteLineItem WHERE QuoteId =: presupuesto.Id];
			}
			catch(Exception e)
			{
				messageResult +='Exepcion CompleteListProductsInOpportunity productosPresupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
			}
			if (productosPresupuesto!=null){
				//system.debug('productosPresupuesto:' + productosPresupuesto);
				for (QuoteLineItem qli : productosPresupuesto){
					Producto_de_cortesia__c producto_cortesia;
					
					try
					{
						//system.debug('qli.PricebookEntry.Product2.Id:' + qli.PricebookEntry.Product2.Id);
						producto_cortesia = [SELECT Descuento_a_la_partida__c, Name, Identidades_cortesia__c, Id, Ofertas_cortesia__c, 
														Ofertas_premium__c, PDA_cortesia__c, Producto__c, Vacantes_destacadas__c
											 		FROM Producto_de_cortesia__c
											 		WHERE Producto__c =: qli.PricebookEntry.Product2.Id];
					}
					catch(Exception e)
					{
						//Si no  tiene producto no se inserta renglon en error, ni se despliega msg, ya que puede ser un producto que no esta en lista
						//System.debug('Error al recuperar la información del catálogo de productos de cortesia para el producto ' + qli.PricebookEntry.Product2.Name + '. Error: ' + e.getMessage());
						//successResult=false;
						//messageResult +='Exepcion CompleteListProductsInOpportunity producto_cortesia error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
					}
					if(producto_cortesia != null)
					{
						if(qli.Vacante_de_Cortes_a__c != null && qli.Vacante_de_Cortes_a__c > 0 && String.valueOf(producto_cortesia.Ofertas_cortesia__c)!=null)
						{
							try
							{
								QuoteLineItem cortesia = new QuoteLineItem
								(
					                QuoteId = presupuesto.Id,
				                	PricebookEntryId = [SELECT Id, Product2Id, Pricebook2.IsActive FROM PricebookEntry WHERE Product2Id =: producto_cortesia.Ofertas_cortesia__c AND Pricebook2.IsActive = true LIMIT 1].Id,
				                	Quantity = qli.Vacante_de_Cortes_a__c,
				                	UnitPrice = 0
				            	);
				            	//UnitPrice = qli.UnitPrice
				            	//System.debug('Agregando partida de producto de cortesía: ' + cortesia + ' correspondiente al producto ' + producto_cortesia.Producto__c);
					            productosPorInsertar.add(cortesia);
							}
							catch(Exception e)
							{
							
							}
				            					}
						if(qli.Descuento2__c != null && qli.Descuento2__c > 0 && String.valueOf(producto_cortesia.Descuento_a_la_partida__c)!=null)
						{
							try
							{
								QuoteLineItem descuentoPartida = new QuoteLineItem
								(
					                QuoteId = presupuesto.Id,
					                PricebookEntryId = [SELECT Id, Product2Id, Pricebook2.IsActive FROM PricebookEntry WHERE Product2Id =: producto_cortesia.Descuento_a_la_partida__c AND Pricebook2.IsActive = true LIMIT 1].Id,
					                Quantity = -1,
					                UnitPrice = (qli.Descuento2__c * (qli.Quantity * qli.UnitPrice))/100
					            );
				            
					            //System.debug('Agregando partida de producto de descuento a la partida: ' + descuentoPartida + ' correspondiente al producto ' + producto_cortesia.Descuento_a_la_partida__c);
					            productosPorInsertar.add(descuentoPartida);
							}
							catch(Exception e){
							
							}
						}
						if(qli.Pda_s_incluidos__c != null && qli.Pda_s_incluidos__c > 0 && String.valueOf(producto_cortesia.PDA_cortesia__c)!=null)
						{
							try
							{
								QuoteLineItem pdaPartida = new QuoteLineItem
								(
					                QuoteId = presupuesto.Id,
					                PricebookEntryId = [SELECT Id, Product2Id, Pricebook2.IsActive FROM PricebookEntry WHERE Product2Id =: producto_cortesia.Descuento_a_la_partida__c AND Pricebook2.IsActive = true LIMIT 1].Id,
					                Quantity = -1,
					                UnitPrice = qli.UnitPrice// (qli.Descuento2__c * (qli.Quantity * qli.UnitPrice))/100
					            );
				            
					            //System.debug('Agregando partida de producto de descuento a la partida: ' + descuentoPartida + ' correspondiente al producto ' + producto_cortesia.Descuento_a_la_partida__c);
					            productosPorInsertar.add(pdaPartida);
							}
							catch(Exception e)
							{
							
							}
						}
					}
				}
			}
			if (productosPorInsertar !=null && presupuesto!=null){
				//Database.SaveResult[] prodsToInsert = Database.insert(productosPorInsertar, false);				
				String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.insert(productosPorInsertar, false));
				if (!String.isBlank(mensaje)){
					messageResult += String.format('Los productos no se agregaron a la oportunidad: {0}.',new String[]{mensaje});
				}
				else
				{
					messageResult += 'Los productos adicionales se agregaron a la oportunidad correctamente.';
					successResult=true;
				}
			}
		}else{
			messageResult +='no se encontró información en el productos por insertar'; 
		}

		//system.debug('EnviarProspecto-result:' + result);
        return messageResult; 
    }
    /// <summary> Metodo de envio de cuenta a recluta, se envia el Id de la cuenta a enviar, internamente se busca el AccountId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String DeleteListProductsInOpportunity(String quoteId){
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
		executedStatusResult=RecruiterDataServiceWrapper.DeleteListProductsInOpportunity(quoteId);
		result=executedStatusResult.message;
		return result;
    }
	
	/// <summary> Metodo de envio de cuenta a recluta, se envia el Id de la cuenta a enviar, internamente se busca el AccountId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String DeleteListProductsInQuote(String quoteId){
    	String result='';
    	OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
		executedStatusResult=RecruiterDataServiceWrapper.DeleteListProductsInQuote(quoteId);
		result=executedStatusResult.message;
		//system.debug(result);
		return result;
    }
	/// <summary> Metodo que envia la informacion de la oportunidad a OCCM  
    /// </summary>
    /// <param name="inputOpportunityId">Id de la cuenta que se va a enviar.</param>
    /// <param name="statusOportunity">Estatus a insertar de la oportunidad.</param>
    /// <param name="virtualAccount">Cuenta virtual de la cuenta a la que pertenece la oportunidad.</param>
    /// <returns>regresa el JSON indicando si se realizo la actualizacion o porque motivo no se realizo. 
    /// </returns>
    //webservice static String UpdatePaymentOpportunityStatus(String transactionReferenceId, String statusOportunity, String virtualAccount){
    webservice static String UpdatePaymentOpportunityStatus(String inputStatement){
    	//system.debug('Entre a UpdatePaymentOpportunityStatus');
    	return UpdatePaymentOpportunityStatusMethod(inputStatement);
    }
    
    public static String UpdatePaymentOpportunityStatusMethod(String inputStatement){
    	String result='';
    	OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
    	Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        Opportunity opp=null;
        String mensaje='';
        OCCMClases.StatementString statementData = new OCCMClases.StatementString();
        //system.debug('wsExecutionResult.objectResult:' + String.valueOf(wsExecutionResult.objectResult));
    	try{
    		JSONParser parser = 
   				JSON.createParser(inputStatement);
   			for (integer i=0; i<7; i++){
    			parser.nextToken();
    		}
    		statementData = (OCCMClases.StatementString)parser.readValueAs(OCCMClases.StatementString.class);
    		//system.debug('Id:' + statementData.Id);
    		//system.debug('EntryDateToString:' + String.valueOf(statementData.EntryDateToString));
    		//system.debug('EntryDate:' + statementData.EntryDate);
    		//system.debug('Amount:' + String.valueOf(statementData.Amount));
    		//system.debug('ReferenceNumber:' + statementData.ReferenceNumber);
    		//system.debug('VirtualAccountIdCompany:' + statementData.ReferenceNumber);
    		//system.debug('ReferenceAlpha:' + statementData.ReferenceAlpha);
    		//system.debug('ReferenceBank:' + statementData.ReferenceBank);
    		//system.debug('ModifiedDate:' + statementData.ModifiedDate);
    		//system.debug('Status:' + statementData.Status);
    		//system.debug('StatusID:' + String.valueOf(statementData.StatusID));
    		//system.debug('AuthorizationNumber:' + String.valueOf(statementData.AuthorizationNumber));
    		//system.debug('BankId:' + String.valueOf(statementData.BankId));
    		//system.debug('Bank:' + statementData.Bank);
    	}
        catch(Exception e)
		{
	    	//system.debug('exepcion serializar');
	    	statementData = new OCCMClases.StatementString();
	    	messageResult +='Exepcion UpdatePaymentOpportunityStatusMethod statementData error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
	    }
        if (statementData!=null && !String.isNotBlank(statementData.ReferenceBank)){
        	successResult=false;
        	messageResult +='La referencia bancaria no contiene información.';
        }
        //system.debug('FechaCadena:' + String.valueOf(statementData.EntryDateToString));
		//falta validar que exista
		if (statementData != null && messageResult != null && !String.isNotBlank(messageResult)){
		    try 
		    {
				opp=[Select o.AccountId, o.NumFact__c, o.ImporteMXP__c, Tipo_de_Facturacion__c, InicioVigencia_o__c, FinVigencia_o__c, 
							o.EjecutivoAsig_o__c, o.Referencia_Bancaria__c, o.Clave_SAP__c, o.Amount, o.EstatusFactura__c, 
							o.Banco__c, o.Fecha_de_Pago_Bancario__c, o.Referencia_Numerica_del__c, o.Concepto_de_Cobro__c, 
							o.Referencia_Banc__c, o.Importe__c, Forma_de_Pago__c
						From Opportunity o
						WHERE o.Referencia_Bancaria__c =: statementData.ReferenceNumber
						LIMIT 1];
		    }
		    catch(Exception e)
			{
		    	successResult=false;
		    	messageResult +='Exepcion UpdatePaymentOpportunityStatusMethod opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		    	//system.debug('messageResult opp' + messageResult);
		    } 
		    if (opp != null){
		    	if (opp.EstatusFactura__c!='En transito'){
					successResult=false;
					messageResult +='El estatus de la factura no es En transito.';
				}else{
					opp.Banco__c = statementData.Bank;
					opp.Cuenta_Banco__c  = statementData.Bank;
					opp.Fecha_de_Pago_Bancario__c = statementData.EntryDateToString; 
					opp.Referencia_Numerica_del__c = statementData.ReferenceNumber;
					opp.Concepto_de_Cobro__c = statementData.ReferenceAlpha;
					opp.Referencia_Banc__c = statementData.ReferenceBank;
					opp.Importe__c = statementData.Amount;
					opp.Forma_de_Pago__c = statementData.PaymentForm;
					if (statementData.Status=='Procesado' || statementData.Status=='Totalizado')
					{
						opp.Estatus_de_pago__c=statementData.Status;
						opp.EstatusFactura__c = 'Cobrada';	
					}else
					{
						if (statementData.Status=='Anticipo totalizado')
						{
							opp.Estatus_de_pago__c=statementData.Status;
							opp.EstatusFactura__c = 'Anticipo cobrado';	
							opp.Banco__c = statementData.Bank;
						}
						else
							if (!String.isNotBlank(statementData.Status))
							{
								opp.Estatus_de_pago__c='Procesado';
								opp.EstatusFactura__c = 'Cobrada';	
							}
					}
					List<Opportunity> oppsToUpdate = new List<Opportunity>();
					oppsToUpdate.add(opp);
					//Database.SaveResult[] oppUpdateResult = Database.update(oppsToUpdate, false);
					mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(oppsToUpdate, false));
					if (!String.isBlank(mensaje)){
						messageResult += String.format('La oportunidad no se actualizo correctamente: {0}.',new String[]{mensaje});
					}
					else
					{
						messageResult += 'El estatus de la oportunidad se actualizo correctamente.';
						successResult=true;
					}
				}
		    }else{
	        	messageResult +='No se encontro información de la oportunidad.';
		    }
		}
	    ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, MessageResult, objectResult);
		result = JSON.serialize(ExecutedStatusResult);
        return result;
	    
    }
    webservice static String UpdatePaymentOpportunityStatusComplete(String inputStatement){
    	system.debug('Entre a UpdatePaymentOpportunityStatus');
    	return UpdatePaymentOpportunityStatusMethodComplete(inputStatement);
    	
    }
    public static String UpdatePaymentOpportunityStatusMethodComplete(String inputStatement){
    	String result='';
    	OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
    	Boolean successResult=true;
        String messageResult='';
        Object objectResult=null;
        Opportunity opp=null;
        Account acc=null;
        String mensaje='';
        OCCMClases.StatementString statementData= new OCCMClases.StatementString();
    	try{
    		system.debug('serializando');
			JSONParser parser = 
   				JSON.createParser(inputStatement);
   			for (integer i=0; i<7; i++){
    			parser.nextToken();
    			system.debug('parse:' + parser.getText() + 'i:' + i);
    		}
    		statementData = (OCCMClases.StatementString)parser.readValueAs(OCCMClases.StatementString.class);
    		//system.debug('Id:' + statementData.Id);
    		//system.debug('EntryDateToString:' + String.valueOf(statementData.EntryDateToString));
    		//system.debug('EntryDate:' + statementData.EntryDate);
    		//system.debug('Amount:' + String.valueOf(statementData.Amount));
    		//system.debug('ReferenceNumber:' + statementData.ReferenceNumber);
    		//system.debug('VirtualAccountIdCompany:' + statementData.ReferenceNumber);
    		//system.debug('ReferenceAlpha:' + statementData.ReferenceAlpha);
    		//system.debug('ReferenceBank:' + statementData.ReferenceBank);
    		//system.debug('ModifiedDate:' + statementData.ModifiedDate);
    		//system.debug('Status:' + statementData.Status);
    		//system.debug('StatusID:' + String.valueOf(statementData.StatusID));
    		//system.debug('AuthorizationNumber:' + String.valueOf(statementData.AuthorizationNumber));
    		//system.debug('BankId:' + String.valueOf(statementData.BankId));
    		//system.debug('Bank:' + statementData.Bank);
    		//system.debug('serializado');
    		//system.debug(JSON.serialize(statementData));
    	}
        catch(Exception e)
		{
	    	successResult=false;
	    	system.debug('exepcion serializar');
	    	messageResult +='Exepcion UpdatePaymentOpportunityStatusMethod statementData error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
	    }
	    if (statementData!=null && !(statementData.Status == 'Procesado' || statementData.Status == 'Totalizado' || statementData.Status == 'Anticipo totalizado')){
        	successResult=false;
        	messageResult +='El estatus de la oportunidad no es permitido dentro del sistema.';
        }
        if (statementData!=null && !String.isNotBlank(statementData.ReferenceBank)){
        	successResult=false;
        	messageResult +='La referencia bancaria no contiene información.';
        }
        if (statementData!=null && !String.isNotBlank(statementData.VirtualAccountIdCompany)){
        	successResult=false;
        	messageResult +='La cuenta virtual no contiene información.';
        }
        //system.debug('messageResult' + messageResult);
        //system.debug('Deserealizando Fecha');
        //String Cadena=statementData.EntryDate;
        //Cadena=Cadena.replace('/Date(','');
        //Cadena=Cadena.replace(')/','');
        //system.debug('Cadena:'+Cadena);
        //date EntryDate= new date();
        //system.debug('FechaCadena:' + String.valueOf(statementData.EntryDateToString));
        
	//falta validar que exista
		if (successResult==true){
			//system.debug('successResult' + successResult);
		    try 
		    {
				opp=[Select o.AccountId, o.NumFact__c, o.ImporteMXP__c, Tipo_de_Facturacion__c, InicioVigencia_o__c, FinVigencia_o__c, 
							o.EjecutivoAsig_o__c, o.Referencia_Bancaria__c, o.Clave_SAP__c, o.Amount, o.EstatusFactura__c, 
							o.Banco__c, o.Fecha_de_Pago_Bancario__c, o.Referencia_Numerica_del__c, o.Concepto_de_Cobro__c, 
							o.Referencia_Banc__c, o.Importe__c
						From Opportunity o
						WHERE o.Referencia_Bancaria__c =: statementData.ReferenceNumber
						LIMIT 1];
			
		    }
		    catch(Exception e)
			{
		    	successResult=false;
		    	messageResult +='Exepcion UpdatePaymentOpportunityStatusMethod opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		    	//system.debug('messageResult opp' + messageResult);
		    } 
		    if (opp != null){
		    	try 
		    	{
		    		if (opp !=null){
						acc=[Select Id, Cuenta_Virtual_Banamex__c //, Fecha_de_envio_de_paquetes_OCCM__c
							From Account o
							WHERE Id =: opp.AccountId 
							LIMIT 1];
					}
		    	}
		    	catch(Exception e)
				{
					successResult=false;
		        	messageResult +='Exepcion UpdatePaymentOpportunityStatusMethod acc error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		        	//system.debug('messageResult acc' + messageResult);
				}
		    	if (acc != null){
		    		//system.debug('acc no null');
		    		String virtualAccount=statementData.VirtualAccountIdCompany;
		    		virtualAccount=virtualAccount.trim();
		    		if (acc.Cuenta_Virtual_Banamex__c.trim() == virtualAccount){
		    			if (opp.EstatusFactura__c!='En transito'){
							successResult=false;
							messageResult +='El estatus de la factura no es En transito.';
						}else{
							opp.Banco__c = 'BANAMEX';
							opp.Fecha_de_Pago_Bancario__c = statementData.EntryDateToString; 
							opp.Referencia_Numerica_del__c = statementData.ReferenceNumber;
							opp.Concepto_de_Cobro__c = statementData.ReferenceAlpha;
							opp.Referencia_Banc__c = statementData.ReferenceBank;
							opp.Importe__c = statementData.Amount;
							if (statementData.Status=='Procesado' || statementData.Status=='Totalizado')
							{
								opp.Estatus_de_pago__c=statementData.Status;
								opp.EstatusFactura__c = 'Cobrada';	
								opp.Banco__c = statementData.Bank;
							}
							if (statementData.Status=='Anticipo totalizado')
							{
								opp.Estatus_de_pago__c=statementData.Status;
								opp.EstatusFactura__c = 'Anticipo cobrado';	
								opp.Banco__c = statementData.Bank;
							}
							List<Opportunity> oppsToUpdate = new List<Opportunity>();
							oppsToUpdate.add(opp);
							//Database.SaveResult[] oppUpdateResult = Database.update(oppsToUpdate, false);
							mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(oppsToUpdate, false));
							if (!String.isBlank(mensaje)){
								messageResult += String.format('La oportunidad no se actualizo correctamente: {0}.',new String[]{mensaje});
							}
							else
							{
								messageResult += 'El estatus de la oportunidad se actualizo correctamente.';
								successResult=true;
							}
						}
					}
		    		else
		    		{
		    			successResult=false;
	        			messageResult +='La cuenta virtual de la oportunidad no coincide con la cuenta virtual que se recibio.';
		    		}
		    	}else{
		    		successResult=false;
	        		messageResult +='No se encontro información de la cuenta para la oportunidad.';
		    	}
		    }else{
		    	successResult=false;
	        	messageResult +='No se encontro información de la oportunidad.';
		    }
		}
	    ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, MessageResult, objectResult);
		result = JSON.serialize(ExecutedStatusResult);
        return result;
        
    }
	/// <summary> Metodo que envia la informacion de la oportnidad a OCCM  
    /// </summary>
    /// <param name="inputOpportunityId">Id de la cuenta que se va a enviar.</param>
    /// <returns>regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String SendProductsToOccm(String inputOpportunityId){
    	return SendProductsToOccmMethod(inputOpportunityId);
    }
    public static String SendProductsToOccmMethod(String inputOpportunityId){
    	//Falta meter validacion de si esta migrada la cuenta o no
    	String result='';
    	Opportunity opp=null;
    	Quote quote=null; 
    	User user=null;
    	Account acc=null;
    	List<OpportunityLineItem> singleItems =  new List<OpportunityLineItem>();
    	OCCMClases.OCCMPurchase occmPurchase = new OCCMClases.OCCMPurchase();
    	List<OCCMClases.OCCMPackage> occmPackage =  new List<OCCMClases.OCCMPackage>();
    	String stringOccmPurchase='';
    	OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
    	Boolean successResult=true;
        String messageResult='';
        Object objectResult=null;
    	system.debug('opportunityId:' + inputOpportunityId);
	    try 
	    {
			opp=[Select o.AccountId, o.NumFact__c, o.ImporteMXP__c, Tipo_de_Facturacion__c, InicioVigencia_o__c, FinVigencia_o__c, 
						o.EjecutivoAsig_o__c, o.Referencia_Bancaria__c, o.Clave_SAP__c, o.Amount, EstatusFactura__c, Tipo_de_vigencia__c, 
						StageName, NunOfertafisica_o__c, Fecha_de_envio_de_paquetes_OCCM__c, Descuento__c
					From Opportunity o
					WHERE Id =: inputOpportunityId 
					LIMIT 1];
					//String oppString = JSON.serialize(opp);
					system.debug('oppString:' + JSON.serialize(opp));
	    }
	    catch(Exception e)
		{
			successResult=false;
	        messageResult +='Exepcion EnviarOportunidadOCCM opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		system.debug('opp.EstatusFactura:');
		
		if (opp !=null){
			opp.InicioVigencia_o__c=opp.InicioVigencia_o__c.addDays(1);
			if (opp.FinVigencia_o__c!=null){
				opp.FinVigencia_o__c=opp.FinVigencia_o__c.addDays(1);
			}
			//Todas las oprtunidades en salesforce requieren factura
			if (opp.EstatusFactura__c!='Aprobada'){
				successResult=false;
				messageResult +='Error en el estatus de la factura, debe ser aprobado. ';
			}
			if (opp.Tipo_de_vigencia__c!='Automática'){
				if (String.valueOf(opp.FinVigencia_o__c)==''){
					successResult=false;
					messageResult +='Error en vigencia: al seleccionar la vigencia manual debe establecer la fecha de fin de vigencia. ';
				}
			}
			if (opp.Referencia_Bancaria__c==null || opp.Referencia_Bancaria__c==''){
				successResult=false;
				messageResult += 'Error en referencia bancaria, no debe estar vacia.';
			}
			if (String.valueOf(opp.Amount)==null ){
				successResult=false;
				messageResult = 'Error en monto total. '  + messageResult;
			}
			if (opp.StageName != 'Cierre'){
				successResult = false;
				messageResult = 'Error en la oportunidad, la etapa debe ser cerrada. '  + messageResult;
			}
			if (opp.NunOfertafisica_o__c==null ){
				successResult=false;
				messageResult = 'Error en Núm Factura electrónica: debe contener el numero de factura. '  + messageResult;
			}
			if (!String.isBlank(String.valueOf(opp.Fecha_de_envio_de_paquetes_OCCM__c)) ){
				successResult=false;
				messageResult = 'Error la oportunidad fue enviada anteriormente en la fecha: ' + String.valueOf(opp.Fecha_de_envio_de_paquetes_OCCM__c) + '. '  + messageResult;
			}			
		}else{
			successResult=false;
			messageResult += 'Error al obtener opp valor nulo. ';			
		}

		system.debug('voy Cuenta Virtal Banamex');
		try 
	    {

	    	if (opp !=null){
	    		system.debug('Genero Cuenta Virtal Banamex');
				acc=[Select Id, Cuenta_Virtual_Banamex__c, OCCM_Cuenta_Administradora__c //, Fecha_de_envio_de_paquetes_OCCM__c
					From Account o
					WHERE Id =: opp.AccountId 
					LIMIT 1];
					//String oppString1 = JSON.serialize(acc);
					system.debug('acc:' + JSON.serialize(acc));
			}
			//system.debug('Se obtuvo acc');
	    }
	    catch(Exception e)
		{
			successResult=false;
	        messageResult +='Exepcion EnviarOportunidadOCCM acc.cuentavirtual error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		system.debug('Se obtuvo acc');
		if (opp !=null && acc!=null){
			if (String.isBlank(acc.Cuenta_Virtual_Banamex__c))// == '' || acc.Cuenta_Virtual_Banamex__c == null){
			{
				opp=null;
				successResult=false;
				messageResult +='La cuenta a la que pertenece la oportunidad no tiene asignada una cuenta virtual de banamex. ';
			}
			if (String.isBlank(acc.OCCM_Cuenta_Administradora__c))// == '' || acc.OCCM_Cuenta_Administradora__c == null){
			{
				opp=null;
				successResult=false;
				messageResult +='La cuenta a la que pertenece la oportunidad no tiene asignada una clave administradora dentro de la sección modelo de paquetes. ';
			}
		}
		if (opp !=null){
			try 
		    {
				user=[Select u.Id, u.LastName, u.FirstName 
							from User u 
							where Id =: opp.EjecutivoAsig_o__c
				 			LIMIT 1];
						String oppString = JSON.serialize(opp);
						//system.debug('opp.EjecutivoAsig_o__c: ' + opp.EjecutivoAsig_o__c);
						//system.debug('quoteString:'+ oppString);
						//system.debug('Se obtuvo user');
		    }
		    catch(Exception e)
			{
				successResult=false;
		        messageResult +='Exepcion EnviarOportunidadOCCM user error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
			}
		}
		if (opp!=null){
			try 
		    {
				singleItems=[SELECT Id, OpportunityId, PricebookEntryId, PricebookEntry.Name, PricebookEntry.ProductCode, Quantity, UnitPrice
								FROM OpportunityLineItem 
								WHERE OpportunityId =: opp.Id];
							String oppitemString = JSON.serialize(singleItems);
					//system.debug('opp.Id' + opp.Id);
					//system.debug('oppitemString:'+ singleItems);  	
		    }
		    catch(Exception e)
			{
				successResult=false;
		        messageResult +='Exepcion EnviarOportunidadOCCM quote error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
			}
		}
		if (opp!=null && singleItems!=null && user!=null){
			try{
				String codigoB='';
				//system.debug('Entrando a construir el paquete de purchase');
				for(OpportunityLineItem oppTemp : singleItems)
				{
					codigoB=oppTemp.PricebookEntry.ProductCode;
					if (!codigoB.endsWith('D') && !codigoB.endsWith('C') && !codigoB.startsWith('VAG')){
						OCCMClases.OCCMPackage occmPackageTmp = new OCCMClases.OCCMPackage();
		    	 		OCCMClases.OCCMService occmServiceTmp = new OCCMClases.OCCMService();
						List<OCCMClases.OCCMService> occmService = new List<OCCMClases.OCCMService>();
						occmServiceTmp.Elements = Integer.valueOf(oppTemp.Quantity);
						occmServiceTmp.TotalElements = Integer.valueOf(oppTemp.Quantity);
						occmServiceTmp.PriceU =  oppTemp.UnitPrice;
						occmServiceTmp.Description = oppTemp.PricebookEntry.Name;
						occmService.add(occmServiceTmp);
		    	 		occmPackageTmp.Name= oppTemp.PricebookEntry.Name;
		    	 		if (codigoB.endsWith('B'))
						{
							occmPackageTmp.Code = 'PACK-DESC-R11';
							occmPackageTmp.ClaveSAP = 'PACK-DESC-R11';	
							occmServiceTmp.Elements = 1;
							occmServiceTmp.TotalElements = 1;
						}
						else
						{
							occmPackageTmp.Code = oppTemp.PricebookEntry.ProductCode;
							occmPackageTmp.ClaveSAP = oppTemp.PricebookEntry.ProductCode;
						}
						
						occmPackageTmp.Services=occmService;
						occmPackageTmp.Price=oppTemp.UnitPrice;
						occmPackage.add(occmPackageTmp);
						//system.debug('Producto insertado:' + oppTemp.PricebookEntry.Name);
					}
					codigoB='';
				}
				occmPurchase.ClientId = acc.OCCM_Cuenta_Administradora__c;
				occmPurchase.DocumentSAP = opp.NumFact__c;
				//occmPurchase.Amount = opp.ImporteMXP__c;
				//occmPurchase.Amount = opp.Amount;
				//system.debug('Valido datos de descuento');
				//Decimal descuento = (opp.Descuento__c == null ? 0: opp.Descuento__c );
				//system.debug('Descuento' + descuento);
				occmPurchase.Amount = opp.Amount - ((opp.Descuento__c == null) ? 0 :((opp.Amount * opp.Descuento__c ) /1)) + ((opp.Amount) * 0.16);
				//system.debug('ImporteUSD: ' + String.valueOf(occmPurchase.Amount));
				if (opp.Tipo_de_Facturacion__c=='Credito' || opp.Tipo_de_Facturacion__c=='Credito Programa Preferente' || opp.Tipo_de_Facturacion__c=='Credito - TheNetwork'){
					occmPurchase.PaymentMode = 'Crédito';
				}else{
					if (opp.Tipo_de_Facturacion__c=='No Credito' || opp.Tipo_de_Facturacion__c=='Micro - Contado'){
						occmPurchase.PaymentMode = 'Contado';
					}else{
						if (opp.Tipo_de_Facturacion__c=='Micro - Carrito' || opp.Tipo_de_Facturacion__c=='Online'){
							occmPurchase.PaymentMode = 'TDC';
						}else{
							if (opp.Tipo_de_Facturacion__c == 'No Credito (factura previa)' ){
								occmPurchase.PaymentMode = 'Factura previa';
							}else{
								//si no tiene equivalente se envia de contado.
								occmPurchase.PaymentMode = 'Contado';
							}
						}
					}
				}
				//occmPurchase.PaymentMode = opp.Tipo_de_Facturacion__c;
				if (opp.Tipo_de_vigencia__c=='Automática')
				{
					occmPurchase.AutomaticValidity=true;
				}else{
					occmPurchase.AutomaticValidity=false;
				}
				//Todas las oportunidades requieren factura.
				occmPurchase.RequiresInvoice = true;
				occmPurchase.PurchasedDate = date.today().addDays(1); 
            	occmPurchase.ActivationDate = opp.InicioVigencia_o__c;
				occmPurchase.DateExpires = opp.FinVigencia_o__c;
				String UsuarioAutoriza=user.FirstName + ' ' + user.LastName;
				if (UsuarioAutoriza.length()>100)
				{
					UsuarioAutoriza= UsuarioAutoriza.substring(0,99);
				}
				occmPurchase.AuthorizedBy = UsuarioAutoriza;
				occmPurchase.ReferenceCode = 'Contratación por Salesforce.';
				occmPurchase.TransactionReference = opp.Referencia_Bancaria__c;
				occmPurchase.Packages = occmPackage;
				result = JSON.serialize(occmPurchase);
				//system.debug('JSON.serialize(occmPurchase):' + JSON.serialize(occmPurchase));
			}
			catch(Exception e)
			{
				successResult=false;
	        	messageResult='Exepcion EnviarAccountOCCM error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
			}
		}else{
			successResult=false;
			messageResult = 'Oportunidad sin productos para enviar. '  + messageResult;
		}
		if (successResult==true && opp != null && singleItems!=null && user!=null){
			//system.debug('Mando Llamar CreateOCCMPurchase');
        	ExecutedStatusResult = RecruiterDataServiceWrapper.CreateOccmPurchase(occmPurchase, inputOpportunityId);
        	if (ExecutedStatusResult.success==true){
        		result='';
        	}else{
        		result= ExecutedStatusResult.message;
        	}
		}else{
			result='La oportunidad no se pudo enviar debido a:' + messageResult;
		}
		//system.debug('MessageResult:' + result);
	    return result;     
    }
	
	
	
	// Falta actualizar el metodo para actualizar la oportunidad 
	/// <summary> Metodo de actualizacion de oportunidad, cmabia el estatus de aprobada a cobrada   
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String WSCreateOccmAccount(String inputAccountId){
    	return CreateOccmAccountMethod(inputAccountId);
    }
    public static String CreateOccmAccountMethod(String inputAccountId){
    	system.debug('AccountId' + inputAccountId);
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
        String personalDataJson='';
        try{
        	system.debug('GetAccountDataUsingAccountId');
			executedStatusResult = GetAccountDataUsingAccountId(inputAccountId);
	        if (executedStatusResult.success==true){
	        	system.debug('GetAccountDataUsingAccountId: Exito');
	        	personalDataInfo=(OCCMClases.PersonalData)ExecutedStatusResult.objectResult;
	        	system.debug('personalDataInfo.ManagerAccount:' + personalDataInfo.ManagerAccount);
	        	if (!String.isBlank(personalDataInfo.ManagerAccount)){
	        		system.debug('Serializa');
		        	personalDataJson = JSON.serialize(PersonalDataInfo);
		        	system.debug('personalDataJson: ' + personalDataJson);
	        		system.debug('CreateOccmLead');
	        		ExecutedStatusResult=RecruiterDataServiceWrapper.CreateOccmAccount(personalDataJson, inputAccountId);
	        		system.debug('CreateOccmLead: Salida');
	        		result=ExecutedStatusResult.message;
			    }else{
			    	result='La cuenta del modelo de paquetes esta asignada, realizar la validacion manual para validar si se encuentra en OCCM.';
			    }
	        }else{
	        	system.debug('GetLeadDataUsingLeadId: Fracaso');
				result=ExecutedStatusResult.message;
	        }
        }
        catch(Exception e)
		{
        	result='Exepcion EnviarAccountOCCM error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
		//system.debug('EnviarProspecto-result:' + result);
        return result; 
    }
	
	
	/// <summary> Metodo de envio de cuenta a recluta, se envia el Id de la cuenta a enviar, internamente se busca el AccountId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String SendAccountToOccm(String inputAccountId){
    	system.debug('AccountId' + inputAccountId);
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
        String personalDataJson='';
        try{
        	system.debug('GetAccountDataUsingAccountId');
			executedStatusResult = GetAccountDataUsingAccountId(inputAccountId);
	        if (executedStatusResult.success==true){
	        	system.debug('GetAccountDataUsingAccountId: Exito');
	        	personalDataInfo=(OCCMClases.PersonalData)ExecutedStatusResult.objectResult;
	        	system.debug('personalDataInfo.ManagerAccount:' + personalDataInfo.ManagerAccount);
	        	if (personalDataInfo.ManagerAccount==null){
	        		system.debug('Serializa');
		        	personalDataJson = JSON.serialize(PersonalDataInfo);
		        	system.debug('personalDataJson: ' + personalDataJson);
	        		system.debug('CreateOccmLead');
	        		ExecutedStatusResult=RecruiterDataServiceWrapper.CreateOccmAccount(personalDataJson, inputAccountId);
	        		system.debug('CreateOccmLead: Salida');
	        		result=ExecutedStatusResult.message;
			    }else{
			    	result='La cuenta del modelo de paquetes esta asignada, realizar la validacion manual para validar si se encuentra en OCCM.';
			    }
	        }else{
	        	system.debug('GetLeadDataUsingLeadId: Fracaso');
				result=ExecutedStatusResult.message;
	        }
        }
        catch(Exception e)
		{
        	result='Exepcion EnviarAccountOCCM error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
		//system.debug('EnviarProspecto-result:' + result);
        return result; 
    }
	
	/// <summary> Metodo de envio de prospecto a recluta, se envia el Id de la cuenta a enviar, internamente se busca el prospectoId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="leadId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String UpdateSalesforceIdLeadAccount(String inputLeadId, String inputAccountId){
    	//system.debug('inputLeadId' + inputLeadId + ' inputAccountId:' + inputAccountId);
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        try{
	   		executedStatusResult=RecruiterDataServiceWrapper.UpdateSalesforceIdLeadAccountOCCM(inputLeadId, inputAccountId);
	   		result=executedStatusResult.message;
        }
        catch(Exception e)
		{
        	result='Exepcion UpdateSalesforceIdLeadAccountOCCM error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
		return result;
    }
    
    
	@future (callout=true)
	public static void UpdateLeadInvoiceInformation(Set<String> accs)
	{
		//system.debug('Entre a UpdateLeadInformation');
		String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
        String personalDataJson='';
        String stringId='';
        try{
			for(String AccTmp : accs)
			{
				//system.debug('Comienza ciclo UpdateLeadInformation:' + AccTmp);
				executedStatusResult = GetLeadDataUsingLeadId(AccTmp);	
				if (executedStatusResult.success==true){
		        	//system.debug(': Exito en GetLeadDataUsingLeadId');
		        	personalDataInfo=(OCCMClases.PersonalData)ExecutedStatusResult.objectResult;
		        	personalDataJson = JSON.serialize(PersonalDataInfo);
		        	//system.debug('Voy a llamar web service');
		        	executedStatusResult=RecruiterDataServiceWrapper.UpdateInvoiceLeadInformation(personalDataJson, AccTmp);
		        	//system.debug('Llame web service');
		        }
			}
        }
        catch(Exception e)
		{
        	result='Exepcion UpdateLeadInvoiceInformation error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug('exepcion ws: ' + result);
		} 
	}
	@future (callout=true)
	public static void UpdateAccountInvoiceInformation(Set<String> accs)
	{
		String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
        String personalDataJson='';
        String stringId='';
        try{
        	//system.debug('Entre a updateAccount');
			for(String AccTmp : accs)
			{
				//system.debug('GetAccountDataUsingAccountId' + AccTmp);
				executedStatusResult = GetAccountDataUsingAccountId(AccTmp);	
				if (executedStatusResult.success==true){
		        	//system.debug('UpdateAccountInvoiceInformation: Exito');
		        	personalDataInfo=(OCCMClases.PersonalData)ExecutedStatusResult.objectResult;
		        	personalDataJson = JSON.serialize(PersonalDataInfo);
		        	//system.debug('personalDataJson: ' + personalDataJson);
		        	//system.debug('UpdateAccountInformation');
		        	ExecutedStatusResult=RecruiterDataServiceWrapper.UpdateAccountInformation(personalDataJson, AccTmp);
		        	//system.debug('CreateOccmLead: Salida');
		        }
			}
        }
        catch(Exception e)
		{
        	result='Exepcion UpdateAccountInvoiceInformation error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		} 
	}

	/// <summary> Metodo de envio de prospecto a recluta, se envia el Id de la cuenta a enviar, internamente se busca el prospectoId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="leadId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    webservice static String SendLeadToOccm(String inputLeadId){
    	//system.debug('LeadId' + inputLeadId);
    	String result='';
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
        String personalDataJson='';
        try{
        	//system.debug('GetLeadDataUsingLeadId');
			executedStatusResult = GetLeadDataUsingLeadId(inputLeadId);
	        if (executedStatusResult.success==true){
	        	//system.debug('GetLeadDataUsingLeadId: Exito');
	        	personalDataInfo=(OCCMClases.PersonalData)ExecutedStatusResult.objectResult;
	        	//system.debug('personalDataInfo.ManagerAccount:' + personalDataInfo.ManagerAccount);
	        	if (personalDataInfo.ManagerAccount==null){
	        		//system.debug('Serializa');
		        	personalDataJson = JSON.serialize(PersonalDataInfo);
	        		system.debug('SendLeadToOccm: ' + personalDataJson);
	        		ExecutedStatusResult=RecruiterDataServiceWrapper.CreateOccmLead(personalDataJson, inputLeadId);
	        		//system.debug('SendLeadToOccm: Salida');
	        		result=ExecutedStatusResult.message;
			    }else{
			    	result='La cuenta del modelo de paquetes esta asignado, realizar la validacion manual para validar si se encuentra en OCCM.';
			    }
	        }else{
	        	//system.debug('SendLeadToOccm: Fracaso');
				result=ExecutedStatusResult.message;
	        }
        }
        catch(Exception e)
		{
        	result='Exepcion SendLeadToOccm error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
		//system.debug('EnviarProspecto-result:' + result);
        return result; 
    }
    
    /// <summary>
    /// Utilizando un string que es LeadId regresa el objeto Lead que pertenece a ese LeadId, se regresa un execution result indicando si se encontro el lead
    /// falso si no se encontro y se regresa objectResult null y true si lo encontro y regresa el Lead en objectResult
    /// </summary>
    /// <param name="inputLeadId">Cadena que contiene el Id del posible lead, el cual se va a buscar.</param>
    /// <returns>Executionresult indicando si lo encontro o no y el la instancia de personal data del lead encontrado.</returns>
	public static OCCMClases.ExecutionResult GetLeadDataUsingLeadId(String inputLeadId)
    {
        Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData PersonalDataInfo= new OCCMClases.PersonalData();
        Lead lead=null;
        try{
        	//system.debug('Antes de consulta');
			lead = [Select l.Website, l.Title, l.Tipo_deVacante__c, l.RFC__c, l.Producto_de_inter_s__c, l.Phone, l.Pais_o__c, l.Owner.Name, l.Owner.Username,
							l.OwnerId, l.OCCM_Password_Cuenta_Administradora__c, l.OCCM_Cuenta_Administradora__c,  l.Migracion_a_modelo_de_paquetes__c,
							 l.No_Empleados__c, l.N_mero_de_Vacantes__c, l.MobilePhone, l.MembresiaInteres_o__c, l.LastName, l.Industry, l.Id, l.Giro_o__c, 
							l.FirstName,l.Fax, l.Estado__c, l.Email, l.DelegMunic_o__c, l.Company, l.Colonia__c, l.CodPostal_o__c, l.Ciudad_opcional_o__c, 
							l.Calle_o__c, l.No_de_Exterior_de_Facturacion__c, l.No_de_interior_de_Facturacion__c, l.C_mo_se_enter_de_OCCMundial_com__c 
						From Lead l	
						WHERE Id =: inputLeadId LIMIT 1];
        }
        catch(Exception e)
		{
        	messageResult='Exepcion GetLeadDataUsingLeadId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		try{
			if(lead != null)
			{
				
				PersonalDataInfo.EmailAddress = lead.Email;
				PersonalDataInfo.Password = '';
				PersonalDataInfo.Name = lead.FirstName;
			    PersonalDataInfo.LastName= lead.LastName;
				PersonalDataInfo.BillRFC = lead.RFC__c;
				PersonalDataInfo.CompanyName = lead.Company;
				PersonalDataInfo.PhoneNumber = lead.Phone;
				PersonalDataInfo.MovilNumber  = lead.MobilePhone;
				PersonalDataInfo.StreetAddress = lead.Calle_o__c;
			    PersonalDataInfo.ExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
			    PersonalDataInfo.InternalNumber= lead.No_de_interior_de_Facturacion__c;
				PersonalDataInfo.Colony = lead.Colonia__c;
				PersonalDataInfo.Country = lead.Pais_o__c;
				PersonalDataInfo.BillCountry = lead.Pais_o__c;
			    PersonalDataInfo.State = lead.Estado__c;
				PersonalDataInfo.BillState = lead.Estado__c;
				PersonalDataInfo.City = lead.DelegMunic_o__c;
				PersonalDataInfo.BillCity = lead.DelegMunic_o__c;
				PersonalDataInfo.StreetAddress = lead.Calle_o__c;
				PersonalDataInfo.BillStreet = lead.Calle_o__c;
				PersonalDataInfo.ExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
				PersonalDataInfo.BillExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
			    PersonalDataInfo.InternalNumber= lead.No_de_interior_de_Facturacion__c;
			    PersonalDataInfo.BillInternalNumber= lead.No_de_interior_de_Facturacion__c;
			    PersonalDataInfo.Colony = lead.Colonia__c;
			    PersonalDataInfo.BillColony = lead.Colonia__c;
			    PersonalDataInfo.PostalCode = lead.CodPostal_o__c;
				PersonalDataInfo.BillPostalCode = lead.CodPostal_o__c;
				PersonalDataInfo.SalesforceId = lead.Id;
			    PersonalDataInfo.LoginId = lead.OCCM_Cuenta_Administradora__c;
				PersonalDataInfo.ExecutiveSalesforceId = lead.OwnerId;
				PersonalDataInfo.ManagerAccount = lead.OCCM_Cuenta_Administradora__c;
				PersonalDataInfo.IsBill = true;
			    PersonalDataInfo.BillRFC = lead.RFC__c;
			    PersonalDataInfo.BillName = lead.Company;
			    PersonalDataInfo.LoginDisabled = 'false';

				/*
			    PersonalDataInfo.Name = lead.FirstName;
			    PersonalDataInfo.LastName= lead.LastName;
			    PersonalDataInfo.JobPosition = lead.title;
			    PersonalDataInfo.EmailAddress = lead.Email;
			    PersonalDataInfo.ConfirmEmail = lead.Email;
			    PersonalDataInfo.PhoneNumber = lead.Phone;
			    PersonalDataInfo.MovilNumber  = lead.MobilePhone;
			    PersonalDataInfo.FaxNumber = lead.Fax; 
			    PersonalDataInfo.DescripcionProductoInteres = lead.Producto_de_inter_s__c;
			    PersonalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;  
			    PersonalDataInfo.CompanyName = lead.Company;
			    PersonalDataInfo.DescripcionNumeroEmpleados = lead.No_Empleados__c; 
			    PersonalDataInfo.DescripcionSector = lead.Industry;
			    PersonalDataInfo.DescripcionGiro = lead.Giro_o__c;
			    PersonalDataInfo.Country = lead.Pais_o__c;
			    PersonalDataInfo.State = lead.Estado__c;
			    //Se cambia para que en la ciudad OCCM vaya el municipio de SF 
			    PersonalDataInfo.City = lead.DelegMunic_o__c;
			    PersonalDataInfo.StreetAddress = lead.Calle_o__c;
			    PersonalDataInfo.ExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
			    PersonalDataInfo.InternalNumber= lead.No_de_interior_de_Facturacion__c;
			    PersonalDataInfo.Colony = lead.Colonia__c;
			    PersonalDataInfo.PostalCode = lead.CodPostal_o__c;
			    PersonalDataInfo.WebPage = lead.Website;
			    PersonalDataInfo.DescripcionMedioEntero = lead.C_mo_se_enter_de_OCCMundial_com__c;   
			    PersonalDataInfo.IsBill = true;
			    PersonalDataInfo.BillRFC = lead.RFC__c;
			    PersonalDataInfo.BillName = lead.Company;
			    PersonalDataInfo.BillCountry = lead.Pais_o__c;
			    PersonalDataInfo.BillState = lead.Estado__c;
			    //Se cambia para que en la ciudad OCCM vaya el municipio de SF
			    //PersonalDataInfo.BillCity = lead.Ciudad_opcional_o__c;
			    //PersonalDataInfo.BillMunicipal = lead.DelegMunic_o__c;
			    PersonalDataInfo.BillCity = lead.DelegMunic_o__c;
			    PersonalDataInfo.BillStreet = lead.Calle_o__c;
			    PersonalDataInfo.BillExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
			    PersonalDataInfo.BillInternalNumber= lead.No_de_interior_de_Facturacion__c;
			    PersonalDataInfo.BillColony = lead.Colonia__c;
			    PersonalDataInfo.BillPostalCode = lead.CodPostal_o__c;
			    PersonalDataInfo.LoginDisabled = 'false';
			    PersonalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.ConfirmPassword = lead.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.DescripcionVacantesACubrir = lead.N_mero_de_Vacantes__c;
			    PersonalDataInfo.DescripcionTipoVacante = lead.Tipo_deVacante__c;
			    PersonalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;
			    PersonalDataInfo.SalesforceId = lead.Id;
			    PersonalDataInfo.LoginId = lead.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.ManagerAccount = lead.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.PasswordManagerAccount = lead.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.ExecutiveSalesforceId = lead.OwnerId;
			    //system.debug('Lead_Cuenta_Administradora:' + lead.OCCM_Cuenta_Administradora__c);
			    */
			    successResult=true;
        		messageResult='';
        		objectResult=PersonalDataInfo;
			}
		}
		catch(Exception e)
		{
        	messageResult='Exepcion GetLeadDataUsingLeadId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
        ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, MessageResult, objectResult);
        return ExecutedStatusResult;
    }
    
    /// <summary>
    /// Utilizando un string que es AccountId regresa el objeto Account que pertenece a ese AccountId, se regresa un execution result indicando si se 
    /// encontro el registro Account
    /// falso si no se encontro y se regresa objectResult null y true si lo encontro y regresa el Account en objectResult
    /// La cuenta (Account)  viene de Account donde sale la informacion de la empresa y de Contact donde sale la informacion del contacto.
    /// </summary>
    /// <param name="inputAccountId">Cadena que contiene el Id del posible Account, el cual se va a buscar.</param>
    /// <returns>Executionresult indicando si lo encontro o no y el la instancia de personal data del Account encontrado.</returns>
	public static OCCMClases.ExecutionResult GetAccountDataUsingAccountId(String inputAccountId)
    {
    	//system.debug('Dentro_GetAccountDataUsingAccountId' + inputAccountId);
        Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.PersonalData PersonalDataInfo= new OCCMClases.PersonalData();
        Account account=null;
        try{
        	system.debug('Antes de consulta');
			account = [Select a.Tipo_de_Vacante__c, a.RFC_o__c, a.PaisFact_o__c, a.Phone, a.Producto_de_inter_s__c,a.OCCM_Password_Cuenta_Administradora__c,
			 				a.OCCM_Cuenta_Administradora__c,a.Migracion_a_modelo_de_paquetes__c,a.No_Empleados__c,a.N_mero_de_Vacantes__c, 
			 				a.MembresiaInteres_o__c,a.Industry, a.Id, a.Giro_o__c,a.Fax, a.EstadoFact_o__c,a.DelegMunicFact_o__c,a.Name,
			 				a.Colonia_de_Facturaci_n__c, a.CodigoPostalFact_o__c,a.CiudadFact_opcional_o__c, a.CalleFact_o__c,a.No_de_interior__c, 
			 				a.No_de_Exterior__c, a.C_mo_se_enter_de_OCCMundial__c, Cuenta_Virtual_Banamex__c, a.OwnerId
			 			From Account a
						WHERE Id =: inputAccountId LIMIT 1];
        }
        catch(Exception e)
		{
        	messageResult='Exepcion GetAccountDataUsingAccountId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	system.debug(messageResult);
		}
		Contact contact=null;
		try{
			contact = [Select c.LastName, c.FirstName, c.Phone, c.MobilePhone, 
			 				c.Email, c.Title, c.Id, c.Fecha__c, c.AccountId
			 			From Contact c
						WHERE  c.AccountId =: inputAccountId 
						ORDER BY c.Fecha__c, c.LastName ASC
						LIMIT 1];
        }
        catch(Exception e)
		{
        	messageResult='Exepcion GetAccountDataUsingAccountId error, No se recuperaron contactos asociados a esta cuenta, \n causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	system.debug(messageResult);
		}
		
		try{
			if(account != null && contact != null)
			{
			    PersonalDataInfo.EmailAddress = contact.Email;
			    PersonalDataInfo.Password = '';
			    PersonalDataInfo.Name = contact.FirstName;
			    PersonalDataInfo.LastName=contact.LastName;
			    PersonalDataInfo.BillRFC = account.RFC_o__c;
			    PersonalDataInfo.CompanyName = account.Name;
			    PersonalDataInfo.PhoneNumber = account.Phone;
			    PersonalDataInfo.MovilNumber  = contact.MobilePhone;
			    PersonalDataInfo.StreetAddress = account.CalleFact_o__c;
			    PersonalDataInfo.BillStreet = account.CalleFact_o__c;
			    PersonalDataInfo.InternalNumber=account.No_de_interior__c;
			    PersonalDataInfo.BillInternalNumber= account.No_de_interior__c;
			    PersonalDataInfo.ExternalNumber= account.No_de_Exterior__c;
			    PersonalDataInfo.BillExternalNumber=account.No_de_Exterior__c;
			    PersonalDataInfo.Colony = account.Colonia_de_Facturaci_n__c;
			    PersonalDataInfo.BillColony = account.Colonia_de_Facturaci_n__c;
			    //Se valida en recluta la que se guarda es la ciudad y el municipio no es relecante ni requerido
			    //PersonalDataInfo.BillCity = account.CiudadFact_opcional_o__c;
			    //PersonalDataInfo.BillMunicipal = account.DelegMunicFact_o__c;
			    PersonalDataInfo.City = account.DelegMunicFact_o__c;
			    PersonalDataInfo.BillCity = account.DelegMunicFact_o__c;
			    PersonalDataInfo.Country = account.PaisFact_o__c;
			    PersonalDataInfo.BillCountry = account.PaisFact_o__c;
			    PersonalDataInfo.State = account.EstadoFact_o__c;
			    PersonalDataInfo.BillState = account.EstadoFact_o__c;
			    PersonalDataInfo.Municipal = account.CiudadFact_opcional_o__c;
			    PersonalDataInfo.BillMunicipal = account.CiudadFact_opcional_o__c;
			    PersonalDataInfo.PostalCode = account.CodigoPostalFact_o__c;
			    PersonalDataInfo.BillPostalCode = account.CodigoPostalFact_o__c;
			    PersonalDataInfo.SalesforceId = account.Id;
			    PersonalDataInfo.LoginId = account.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.ExecutiveSalesforceId = account.OwnerId;
			    if (!String.isBlank(account.Cuenta_Virtual_Banamex__c)){
			    	PersonalDataInfo.CuentaVirtual=account.Cuenta_Virtual_Banamex__c;
			    }
			    PersonalDataInfo.ManagerAccount = account.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.IsBill = true;
			    PersonalDataInfo.BillRFC = account.RFC_o__c;
			    PersonalDataInfo.BillName = account.Name;
			    /*
			    PersonalDataInfo.Name = contact.FirstName;
			    PersonalDataInfo.LastName=contact.LastName;
			    PersonalDataInfo.JobPosition = contact.Title;
			    PersonalDataInfo.EmailAddress = contact.Email;
			    PersonalDataInfo.ConfirmEmail =  contact.Email;
			    PersonalDataInfo.MovilNumber  = contact.MobilePhone;
			    PersonalDataInfo.PhoneNumber = account.Phone;
			    PersonalDataInfo.FaxNumber = account.Fax; 
			    PersonalDataInfo.DescripcionProductoInteres = account.Producto_de_inter_s__c;
			    PersonalDataInfo.DescripcionTipoProductoInteres = account.MembresiaInteres_o__c;  
			    PersonalDataInfo.CompanyName = account.Name;
			    PersonalDataInfo.DescripcionNumeroEmpleados = account.No_Empleados__c; 
			    PersonalDataInfo.DescripcionSector = account.Industry;
			    PersonalDataInfo.DescripcionGiro = account.Giro_o__c;
			    PersonalDataInfo.Country = account.PaisFact_o__c;
			    PersonalDataInfo.State = account.EstadoFact_o__c;
			    //Se valida en recluta la que se guarda es la ciudad y el municipio no es relecante ni requerido
			    //PersonalDataInfo.City = account.CiudadFact_opcional_o__c;
			    //PersonalDataInfo.Municipal = account.DelegMunicFact_o__c;
			    PersonalDataInfo.City = account.DelegMunicFact_o__c;
			    PersonalDataInfo.Municipal = account.CiudadFact_opcional_o__c;
			    //La calle viene con numero interior y exterior
			    PersonalDataInfo.StreetAddress = account.CalleFact_o__c;
			    PersonalDataInfo.ExternalNumber= account.No_de_Exterior__c;
			    PersonalDataInfo.InternalNumber=account.No_de_interior__c;
			    PersonalDataInfo.Colony = account.Colonia_de_Facturaci_n__c;
			    PersonalDataInfo.PostalCode = account.CodigoPostalFact_o__c;
			    PersonalDataInfo.WebPage = '';
			    PersonalDataInfo.DescripcionMedioEntero = account.C_mo_se_enter_de_OCCMundial__c;   
			    PersonalDataInfo.IsBill = true;
			    PersonalDataInfo.BillRFC = account.RFC_o__c;
			    PersonalDataInfo.BillName = account.Name;
			    PersonalDataInfo.BillCountry = account.PaisFact_o__c;
			    PersonalDataInfo.BillState = account.EstadoFact_o__c;
			    //Se valida en recluta la que se guarda es la ciudad y el municipio no es relecante ni requerido
			    //PersonalDataInfo.BillCity = account.CiudadFact_opcional_o__c;
			    //PersonalDataInfo.BillMunicipal = account.DelegMunicFact_o__c;
			    PersonalDataInfo.BillCity = account.DelegMunicFact_o__c;
			    PersonalDataInfo.BillMunicipal = account.CiudadFact_opcional_o__c;
			    PersonalDataInfo.BillStreet = account.CalleFact_o__c;
			    PersonalDataInfo.BillExternalNumber=account.No_de_Exterior__c;
			    PersonalDataInfo.BillInternalNumber= account.No_de_interior__c;
			    PersonalDataInfo.BillColony = account.Colonia_de_Facturaci_n__c;
			    PersonalDataInfo.BillPostalCode = account.CodigoPostalFact_o__c;
			    PersonalDataInfo.LoginDisabled = 'false';
			    PersonalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.ConfirmPassword = account.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.DescripcionVacantesACubrir = account.N_mero_de_Vacantes__c;
			    PersonalDataInfo.DescripcionTipoVacante = account.Tipo_de_Vacante__c;
			    PersonalDataInfo.DescripcionTipoProductoInteres = account.MembresiaInteres_o__c;
			    PersonalDataInfo.SalesforceId = account.Id;
			    PersonalDataInfo.LoginId = account.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.ManagerAccount = account.OCCM_Cuenta_Administradora__c;
			    PersonalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.PasswordManagerAccount =account.OCCM_Password_Cuenta_Administradora__c;
			    PersonalDataInfo.ExecutiveSalesforceId = account.OwnerId;
			    if (!String.isBlank(account.Cuenta_Virtual_Banamex__c)){
			    	PersonalDataInfo.CuentaVirtual=account.Cuenta_Virtual_Banamex__c;
			    }
			    */
			    //system.debug('Lead_Cuenta_Administradora:' + lead.OCCM_Cuenta_Administradora__c);
			    successResult=true;
        		messageResult='';
        		objectResult=PersonalDataInfo;
			}
		}
		catch(Exception e)
		{
        	messageResult='Exepcion GetLeadDataUsingLeadId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
        ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, MessageResult, objectResult);
        return ExecutedStatusResult;
    }
    
    /// <summary>
    /// Utilizando un string que es AccountId regresa el objeto AccountSummary que pertenece a ese AccountId, 
    //  se regresa un execution result indicando si se encontro el registro Account
    /// falso si no se encontro y se regresa objectResult null y true si lo encontro y regresa el AccountSummary en objectResult
    /// La cuenta (Account)  viene de Account donde sale la informacion de la empresa y de Contact donde sale la informacion del contacto.
    /// </summary>
    /// <param name="inputAccountId">Cadena que contiene el Id del posible Account, el cual se va a buscar.</param>
    /// <param name="migrationOption">Opciond e migracion, puese estar entre C:cuenta confidencial, P:Cuenta publica y G:Cuenta usuario nuevo.</param>
    /// <returns>Executionresult indicando si lo encontro o no y el la instancia de personal data del AccountSummary encontrado.</returns>
	public static OCCMClases.ExecutionResult GetAccountSummaryUsingAccountId(String inputAccountId, String migrationOption, String emailMigration)
    {
    	//system.debug('GetAccountSummaryUsingAccountId' + inputAccountId);
        Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.AccountSummary AccountSummaryDataInfo= new OCCMClases.AccountSummary();
        Account account=null;
        Contact contact=null;
        if (String.isBlank(migrationOption)){
        	messageResult +='Error en la opción de migración: no se selecciono ninguna opción';
        }else{
        	if (!(migrationOption=='C' || migrationOption=='P' || migrationOption=='G'))
        	{
        		messageResult +='Error en la opción de migración: La opción seleccionada no es valida';
        	}
        }
        try{
        	//system.debug('Antes de consulta account');
			account = [Select a.OCCM_Cuenta_Administradora__c, a.OCCM_Password_Cuenta_Administradora__c, a.Id, a.Name,a.Phone 
						From Account a
						WHERE Id =: inputAccountId LIMIT 1];
        }
        catch(Exception e)
		{
        	messageResult +='Exepcion GetAccountSummaryUsingAccountId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		
		system.debug('Voy a validar correo con expresion regular');
		if (String.isBlank(emailMigration) && !Funciones.IsValidEmail(emailMigration))
		{
			messageResult +='Es necesaria una cuenta de correo al solicitar la migracion';
			system.debug('Cuenta vacia');
		}
		try{
			if(account != null && String.isBlank(messageResult))
			{
				//Account
				AccountSummaryDataInfo.RecruiterId=account.OCCM_Cuenta_Administradora__c;
        		AccountSummaryDataInfo.Password ='';
        		AccountSummaryDataInfo.Active = true;
        		AccountSummaryDataInfo.TokenActivation  ='';
        		AccountSummaryDataInfo.AccountType  = migrationOption;
        		AccountSummaryDataInfo.ActiveJobs = 0;
        		AccountSummaryDataInfo.Agents  = 0;
        		AccountSummaryDataInfo.SalesForceId = account.Id;
        		AccountSummaryDataInfo.Administrator  = true;
        		AccountSummaryDataInfo.IsWebSolutionAccount  = false;
        		AccountSummaryDataInfo.ExecutiveId  = 0;
        		AccountSummaryDataInfo.Name = account.Name;
        		AccountSummaryDataInfo.PhoneNumber  = '';
    	    	//Contact
        		//AccountSummaryDataInfo.EmailAddress  =contact.Email;
        		AccountSummaryDataInfo.EmailAddress  = emailMigration;
        		AccountSummaryDataInfo.ValidEmailAddress  = true;
        		AccountSummaryDataInfo.CompanyId  =account.OCCM_Cuenta_Administradora__c;
        		//AccountSummaryDataInfo.MovilNumber  = contact.MobilePhone;
			    //system.debug('Lead_Cuenta_Administradora:' + lead.OCCM_Cuenta_Administradora__c);
			    successResult=true;
        		messageResult='';
        		objectResult=AccountSummaryDataInfo;
			}
		}
		catch(Exception e)
		{
        	messageResult='Exepcion GetAccountSummaryUsingAccountId error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		//Nos aseguramos de que si successresult es falso object result sea nulo
		if (successResult==true)
		{
				objectResult=objectResult;
		}
        else
        {
        	objectResult= null;
        }
        system.debug('MessageResult:' + MessageResult);
        system.debug('successResult:' + successResult);
        ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, MessageResult, objectResult);
        return ExecutedStatusResult;
    }
    
	/// Metodo de asignacion de tarea a ejecutivo.
	/// <summary> Metodo que genera tareas generales dentro de la ORG
    /// </summary>
    /// <param name="Asignar">Nombre de la persona a quien se le asignara la tarea.</param>
    /// <param name="Asunto">Leyenda que se desplegara en el asunto de la tarea.</param>
    /// <param name="Comentarios">Leyenda que se desplegara como parte de los comentarios de la tarea.</param>
    /// <returns>JSON que regresa el estatus de la ejecución, 
    ///  	true - Inserto satisfactoriamente, 
    ///		false - En caso de que no se inserte la tarea, 
    ///		Mensaje - De error en caso de existir indicando el error que se genero al generar la tarea.
    /// </returns>
    webservice static String WSGenerateGeneralTask(String Asignar, String Asunto, String Comentarios){
        String result='';
        Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        try{
        	Map<Boolean,String> GenerarTarea=Funciones.GeneraTareaGeneral(Asignar, Asunto, Comentarios);
	    	if (!GenerarTarea.isEmpty()){
	        	Set<Boolean> Keys=new Set<Boolean>();
	            Keys=GenerarTarea.keySet();
	            if (Keys.contains(true)){
	            	successResult=true;
        			messageResult='';
	            }else{
	            	successResult=false;
        			messageResult='Error en la asignación de tarea general: ' + GenerarTarea.get(false);
	            }
	    	}	
        }
        catch(Exception e)
		{
			successResult=false;
        	messageResult='Exepcion WSGenerateGeneralTask error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
    	ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
        result = JSON.serialize(ExecutedStatusResult);
        return result;
    }
    
	/// <summary> Metodo de validacion de existencia previa de registro dentro de la ORG, valida la informacion tanto en dentro de Lead y Account, 
	/// 	la informacion que valida es: razón social, RFC. 
    /// </summary>
    /// <param name="PersonalDataString">Recibe una cadena JSON con el contenido de la clase PersonalData serializada.</param>
    /// <returns>JSON que regresa el estatus de la ejecución, 
    ///		success es el resultado de la funcion depende de si realizo o no el proceso solicitado
    ///  		true - Si existe registro previo que contenga coincidencia en la menos un registro
    ///			false - En caso de que no se encotnrara coincidencia previa, 
    ///		Mensaje - Descripción de error detallada del proceso.
    ///		objectResult - Objeto resultante.
    /// </returns>
    webservice static String WSIsRegisteredCompany(String PersonalDataString)
    {
    	//system.debug(PersonalDataString);
    	String JSONString;
    	OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
    	try{
    		List<OCCMClases.PersonalData> PersonalDataFromDotNet= (List<OCCMClases.PersonalData>) System.JSON.deserialize(PersonalDataString, List<OCCMClases.PersonalData>.class);
        	OCCMClases.PersonalData acc= PersonalDataFromDotNet[0];
            ExecutedStatusResult=IsRegisteredCompanymethod(acc, false);
    	}
    	catch(Exception e)
		{
            ExecutedStatusResult= new OCCMClases.ExecutionResult(false, 'Exepcion IsRegisteredCompany error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString(), null);
		}    	
    	JSONString = JSON.serialize(ExecutedStatusResult);
        return JSONString;
    }
    
	/// <summary> Metodo que regisra prospecto dentro de la ORG
	/// Metodo de registro de prospecto, primero realiza la validacion de existencia previa de informacion, valida la informacion dentro de Lead y Account.
    /// En caso de existir coincidencia regresa el detalle, en caso de no existir inserta prospecto, en caso de generarse error, regresa el detalle del error.
    /// </summary>
    /// <param name="PersonalDataString">Recibe una cadena JSON con el contenido de la clase PersonalData serializada.</param>
    /// <returns>JSON que regresa el estatus de la ejecución, 
    ///		success es el resultado de la funcion depende de si realizo o no el proceso solicitado
    ///  		true - Si existe registro previo que contenga coincidencia en la menos un registro, razon social, RFC, 
    ///			false - En caso de que no se encotnrara coincidencia previa, 
    ///		Mensaje - Descripción de error detallada del proceso.
    ///		objectResult - Objeto resultante.
    /// </returns>
    webservice static String WSRegisterLead(String PersonalDataString)
    {
        String JSonString;
        //system.debug('Ingrese a WSRegisterLead');
        List<Lead> LeadsToInsert = new List<Lead>();
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        OCCMClases.ExecutionResult RegisterLead=new OCCMClases.ExecutionResult();
        String ExistOnOCCM='';
        String Msg;
        try{
        	//Valida si existe previamente
    		List<OCCMClases.PersonalData> PersonalDataFromDotNet= (List<OCCMClases.PersonalData>) System.JSON.deserialize(PersonalDataString, List<OCCMClases.PersonalData>.class);
        	OCCMClases.PersonalData acc= PersonalDataFromDotNet[0];
        	//system.debug('Deserealizo prospecto');
        	ExistOnOCCM=acc.MensajeExistenciaPrevia;
        	//system.debug('Valido existencia previa');
            ExecutedStatusResult=IsRegisteredCompanymethod(acc, false);
            if (ExecutedStatusResult.success==true){
            	ExecutedStatusResult.success=false;
            	//system.debug('Existencia Previa');
            	//Si no existe entonces la crea
            	Map<Boolean,String> GenerarTarea=GeneraTareasPreviousRegisteredCompany(ExecutedStatusResult.message, ExistOnOCCM, 'Atención a Clientes');
		    	if (!GenerarTarea.isEmpty()){
		        	Set<Boolean> Keys=new Set<Boolean>();
		            Keys=GenerarTarea.keySet();
		            if (Keys.contains(true)){
		            	RegisterLead.message=RegisterLead.message + ' Tarea generada satisfactoriamente.'; 
		            }else{
		            	RegisterLead.message=RegisterLead.message + ' Error en generacion de tarea.';
		            }
		    	}else{
		    		RegisterLead.message=RegisterLead.message + ' no se genero la tarea.';
		    	}
            }else{
            	RegisterLead= RegisterLeadMethod(acc);
            	//system.debug('Genera tarea registro de compania');
	            Map<Boolean,String> GenerarTarea=GeneraTareasRegisterCompany(RegisterLead, ExistOnOCCM, 'Atención a Clientes');
		    	if (!GenerarTarea.isEmpty()){
		        	Set<Boolean> Keys=new Set<Boolean>();
		            Keys=GenerarTarea.keySet();
		            //for(Boolean bor : Keys)
            		//{
            			//system.debug('Version:' + bor);
            		//}
		            if (Keys.contains(true)){
		            	RegisterLead.message=RegisterLead.message + ' Tarea generada satisfactoriamente.'; 
		            }else{
		            	RegisterLead.message=RegisterLead.message + ' Error en generacion de tarea.';
		            }
		    	}else{
		    		RegisterLead.message=RegisterLead.message + ' no se genero la tarea.';
		    	}
            	ExecutedStatusResult=RegisterLead;
            	//ExecutedStatusResult= new ExecutionResult(true, 'Prospecto Creado' , null);
            }
    	}
    	catch(Exception e)
		{
			//System.debug('Exepcion RegisterLead error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString());
            ExecutedStatusResult= new OCCMClases.ExecutionResult(false, 'Exepcion RegisterLead error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString(), null);
		}
    	JSONString = JSON.serialize(ExecutedStatusResult);
    	//system.debug('Termino');
        return JSONString;
    }
    
    //Regresa verdadero si la cuenta existe, falso si no existe ni como account o Lead
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static OCCMClases.ExecutionResult RegisterLeadMethod(OCCMClases.PersonalData PersonalDataInfo)
    {
    	OCCMClases.ExecutionResult result=new OCCMClases.ExecutionResult();
    	Object objectResult=null;
    	List<Lead> LeadsToInsert = new List<Lead>();
    	String mensaje;
    	Date fechaMigracion; 
    	try
		{
			PersonalDataInfo.ManagerAccount=PersonalDataInfo.LoginId;
			PersonalDataInfo.PasswordManagerAccount=PersonalDataInfo.Password;
			//PersonalDataInfo.FechaMigracionPaquetes=Date.today().format();
			Lead tmplead;
			tmplead = new Lead();
			tmplead.FirstName=PersonalDataInfo.Name;
			tmplead.LastName=PersonalDataInfo.LastName;
			tmplead.phone=PersonalDataInfo.PhoneNumber;
			tmplead.email=PersonalDataInfo.EmailAddress;
			tmplead.Company=PersonalDataInfo.CompanyName;
			tmplead.Calle_o__c= PersonalDataInfo.StreetAddress; //+ ' ' + PersonalDataInfo.ExternalNumber + ' ' + PersonalDataInfo.InternalNumber;
			tmplead.No_de_Exterior_de_Facturacion__c= PersonalDataInfo.ExternalNumber;
			tmplead.No_de_interior_de_Facturacion__c= PersonalDataInfo.InternalNumber;
			tmplead.Colonia__c= PersonalDataInfo.Colony;
			tmplead.Pais_o__c= PersonalDataInfo.Country;
			tmplead.Estado__c= PersonalDataInfo.State;
			//tmplead.DelegMunic_o__c= PersonalDataInfo.Municipal;
			tmplead.MobilePhone= PersonalDataInfo.MovilNumber;
			tmplead.RFC__c= PersonalDataInfo.BillRFC;
			tmplead.OCCM_Cuenta_Administradora__c=PersonalDataInfo.ManagerAccount;
			tmplead.CodPostal_o__c=PersonalDataInfo.BillPostalCode;
			if (!(PersonalDataInfo.City=='' && PersonalDataInfo.City==null)){
				tmplead.DelegMunic_o__c=PersonalDataInfo.City;	
			}
			if (!(PersonalDataInfo.MovilNumber=='' && PersonalDataInfo.MovilNumber==null)){
				tmplead.MobilePhone=PersonalDataInfo.MovilNumber;	
			}
			if (!(PersonalDataInfo.FechaMigracionPaquetes=='' && PersonalDataInfo.FechaMigracionPaquetes==null)){
				fechaMigracion=date.today();
				tmplead.Migracion_a_modelo_de_paquetes__c= FechaMigracion;
			}
			if (!String.isBlank(PersonalDataInfo.LeadSource))
			{
				tmplead.LeadSource=	PersonalDataInfo.LeadSource;
			}
			if (!String.isBlank(PersonalDataInfo.Detalle_origen))
			{
				tmplead.Detalle_origen__c=PersonalDataInfo.Detalle_origen;
			}
			
        
			/*
			tmplead.FirstName=PersonalDataInfo.Name;
			tmplead.LastName=PersonalDataInfo.LastName;
			tmplead.title=PersonalDataInfo.JobPosition;
			tmplead.phone=PersonalDataInfo.PhoneNumber;
			tmplead.email=PersonalDataInfo.EmailAddress;
			tmplead.Company=PersonalDataInfo.CompanyName;
			tmplead.Industry=PersonalDataInfo.DescripcionSector;
			tmplead.Giro_o__c= PersonalDataInfo.DescripcionGiro;
			tmplead.Calle_o__c= PersonalDataInfo.StreetAddress; //+ ' ' + PersonalDataInfo.ExternalNumber + ' ' + PersonalDataInfo.InternalNumber;
			tmplead.No_de_Exterior_de_Facturacion__c= PersonalDataInfo.ExternalNumber;
			tmplead.No_de_interior_de_Facturacion__c= PersonalDataInfo.InternalNumber;
			tmplead.Colonia__c= PersonalDataInfo.BillColony;
			tmplead.Pais_o__c= PersonalDataInfo.BillCountry;
			tmplead.Estado__c= PersonalDataInfo.BillState;
			//tmplead.DelegMunic_o__c= PersonalDataInfo.Municipal;
			tmplead.MobilePhone= PersonalDataInfo.MovilNumber;
			tmplead.Producto_de_inter_s__c= PersonalDataInfo.DescripcionProductoInteres;
			tmplead.MembresiaInteres_o__c= PersonalDataInfo.DescripcionTipoProductoInteres;
			tmplead.No_Empleados__c= PersonalDataInfo.DescripcionNumeroEmpleados;
			tmplead.RFC__c= PersonalDataInfo.BillRFC;
			tmplead.N_mero_de_Vacantes__c= PersonalDataInfo.DescripcionVacantesACubrir;
			tmplead.Tipo_deVacante__c= PersonalDataInfo.DescripcionTipoVacante;
			tmplead.C_mo_se_enter_de_OCCMundial_com__c= PersonalDataInfo.DescripcionMedioEntero;
			tmplead.OCCM_Cuenta_Administradora__c=PersonalDataInfo.ManagerAccount;
			tmplead.OCCM_Password_Cuenta_Administradora__c=PersonalDataInfo.PasswordManagerAccount;
			//system.debug('Convierto Fecha: ' + PersonalDataInfo.FechaMigracionPaquetes);
			if (!(PersonalDataInfo.FechaMigracionPaquetes=='' && PersonalDataInfo.FechaMigracionPaquetes==null)){
				//system.debug('Antes de convertir');
				fechaMigracion=date.valueOf(PersonalDataInfo.FechaMigracionPaquetes);
				//system.debug('Fecha: ' + fechaMigracion);
				tmplead.Migracion_a_modelo_de_paquetes__c= FechaMigracion;
			}
			tmplead.CodPostal_o__c=PersonalDataInfo.BillPostalCode;
			//tmplead.DelegMunic_o__c=PersonalDataInfo.BillMunicipal;
			if (!(PersonalDataInfo.WebPage=='' && PersonalDataInfo.WebPage==null)){
				tmplead.Website=PersonalDataInfo.WebPage;	
			}
			if (!(PersonalDataInfo.BillCity=='' && PersonalDataInfo.BillCity==null)){
				tmplead.DelegMunic_o__c=PersonalDataInfo.BillCity;	
			}
			if (!(PersonalDataInfo.MovilNumber=='' && PersonalDataInfo.MovilNumber==null)){
				tmplead.MobilePhone=PersonalDataInfo.MovilNumber;	
			}
			tmplead.LeadSource= 'Web';//);
			*/
			//agregamos a la lista de cuentas por crear
			LeadsToInsert.add(tmplead);
		    //Insertamos de manera masiva todos los registros nuevos
			Database.SaveResult[] LeadsInsertResult = Database.insert(LeadsToInsert, false);
			//Verificamos si hubo errores
			for(Integer i=0; i< LeadsInsertResult.size(); i++)
			{
				Database.SaveResult sr = LeadsInsertResult[i];
				mensaje='';
			    if (!sr.isSuccess())
			    {
			    	for(Database.Error err : sr.getErrors())
			    	{
			    		mensaje = mensaje + 'Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage();
			    		//system.debug('Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage());
		       		}
		       		mensaje = String.format('Los datos del formulario recibido usuario:{0}, razón social: {1}, email:{2}, telefono:{3}, tiene los siguientes errores:{4}. ',new String[]{PersonalDataInfo.LoginId, PersonalDataInfo.CompanyName, PersonalDataInfo.EmailAddress, PersonalDataInfo.PhoneNumber, mensaje});
                    result= new OCCMClases.ExecutionResult(false, mensaje, null);
                    //system.debug('Se creo el prospecto con errores' + mensaje);
			    }
			    else
			    {
			    	//system.debug('Se creo el prospecto satisfactoriamente');
                    mensaje='Prospecto ID ' + LeadsToInsert[i].Id + '; Nombre:' + LeadsToInsert[i].FirstName + ' ' + LeadsToInsert[i].LastName + '; ha sido generado satisfactoriamente.';
                    PersonalDataInfo.SalesforceId=LeadsToInsert[i].Id;
                    String JsonObjectResult = JSON.serialize(PersonalDataInfo);
                    result= new OCCMClases.ExecutionResult(true, mensaje, JsonObjectResult);
			    }
			}
        }
		catch(Exception e)
		{
			result= new OCCMClases.ExecutionResult(false, 'Exepcion RegisterLeadMethod error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString(), null);
        }
        return result;
    }
    
    //Regresa verdadero si la cuenta existe, falso si no existe ni como account o Lead
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static Map<Boolean,String> GeneraTareasRegisterCompany(OCCMClases.ExecutionResult StatusRegistered, String ExistOnOCCM, String GrupoAsignar)
    {
        Map<Boolean,String> result = new Map<Boolean, String>();
        Boolean BooResult=true;
        String MsgResult='';
        String Mensaje='';
        //system.debug('Error GeneraTareaRegisterCompany: ' + ExistOnOCCM.trim());
        if (ExistOnOCCM!=null){
        	if (ExistOnOCCM.trim()=='' || ExistOnOCCM.trim()=='""'){
        		Mensaje='Resultado registro OCCM: Sin error. Resultado SALESFORCE: ' + (String)statusRegistered.message;
        	}else{
        		Mensaje='Resultado registro OCCM con Error(s): ' + ExistOnOCCM + '. Resultado SALESFORCE: ' + (String)statusRegistered.message;
        	}
        }
        else{
        	Mensaje=(String)statusRegistered.message;
        }
        //system.debug('Voy a entrar a obtener a quien asignar');
        try{
        	Map<Id, String> ObtieneAQuienAsignarTarea=Funciones.ObtieneAQuienAsignarTarea(GrupoAsignar);
        	if (!ObtieneAQuienAsignarTarea.isEmpty()){
        		Map<Boolean,String> ProcessResult = new Map<Boolean, String>();
        		Set<Id> AquienKeys = new Set<Id>();
        		AquienKeys = ObtieneAQuienAsignarTarea.keySet();
        		for(Id Aquien : AquienKeys)
            	{
            		if (StatusRegistered.success==true){
            			String PersonDat=(String)StatusRegistered.ObjectResult;
            			OCCMClases.PersonalData pd= (OCCMClases.PersonalData) System.JSON.deserialize(PersonDat, OCCMClases.PersonalData.class);
            			//system.debug('Voy a entrar a obtener generar tarea prospecto');
            			ProcessResult = Funciones.GeneraTareaProspecto(ObtieneAQuienAsignarTarea.get(Aquien), 'Nuevo prospecto registrado', Mensaje, pd.SalesforceId);
            			Set<Boolean> Results = new Set<Boolean>();
        				Results = ProcessResult.keySet();
        				for(Boolean bor : Results)
            			{
            				MsgResult=MsgResult + ProcessResult.get(bor);
            				BooResult=BooResult & bor;
            			}
            		}else{
            			//system.debug('Voy a entrar a obtener generar tarea general');
            			ProcessResult = Funciones.GeneraTareaGeneral(ObtieneAQuienAsignarTarea.get(Aquien), 'Error en registro de prospecto', Mensaje);
            			Set<Boolean> Results = new Set<Boolean>();
        				Results = ProcessResult.keySet();
        				for(Boolean bor : Results)
            			{
            				MsgResult=MsgResult + ProcessResult.get(bor);
            				BooResult=BooResult & bor;
            				//system.debug('Resultado de generatareageneral:' + bor);
            			}
            		}
            	}
        	}else{
        		BooResult=false;
        		MsgResult= 'No se encontró personas a quien asignar las tareas.';
        	}
        }
        catch(Exception e)
		{
			BooResult=false;   
            MsgResult= 'Exepcion GeneraTareasRegisterCompany error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
		//system.debug('Resultado BooResult:' + BooResult + ' Error:' + MsgResult);
		result.put(Booresult, MsgResult);
        return result;
    }
    
    //Regresa verdadero si la cuenta existe, falso si no existe ni como account o Lead
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static Map<Boolean,String> GeneraTareasPreviousRegisteredCompany(String Mensaje, String ExistOnOCCM, String GrupoAsignar)
    {
    	//system.debug('GeneraTareasPreviousRegisteredCompany');
    	Boolean BooResult=false;
        String MsgResult='';
        Map<Boolean,String> result = new Map<Boolean, String>();
        if (ExistOnOCCM!=null){
        	if (ExistOnOCCM==''){
        		Mensaje='Registro en OCCM sin error. Resultado SALESFORCE: ' + Mensaje;
        	}else{
        		Mensaje='Error en registro OCCM:' + ExistOnOCCM + '. Resultado SALESFORCE: ' + Mensaje;
        	}
        	
        }
        //system.debug(Mensaje);
        try{
        	Map<Id, String> ObtieneAQuienAsignarTarea=Funciones.ObtieneAQuienAsignarTarea(GrupoAsignar);
        	if (!ObtieneAQuienAsignarTarea.isEmpty()){
        		Map<Boolean,String> ProcessResult = new Map<Boolean, String>();
        		Set<Id> AquienKeys = new Set<Id>();
        		AquienKeys = ObtieneAQuienAsignarTarea.keySet();
        		for(Id Aquien : AquienKeys)
            	{
            		//Que pasa cuando sean varios y en uno de ellos no se inserte
            		//system.debug('Voy a entrar a obtener generar tarea general con prospecto registrado');
            		ProcessResult = Funciones.GeneraTareaGeneral(ObtieneAQuienAsignarTarea.get(Aquien), 'Error en registro de prospecto', Mensaje);
            		Set<Boolean> Results = new Set<Boolean>();
        			Results = ProcessResult.keySet();
        			for(Boolean bor : Results)
            		{
            			MsgResult=MsgResult + ProcessResult.get(bor);
						Booresult=Booresult && bor;
						//system.debug('Tarea:' + bor);        					
            		}
            		
            	}
            	
        	}else{
        		MsgResult=MsgResult + 'No se encontró a quien asignar en la lista de propietarios';
				Booresult=false;  
        	}
        }
        catch(Exception e)
		{   
			MsgResult=MsgResult + 'Exepcion GeneraTareasPreviousRegisteredCompany error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
			Booresult=false;
		}    
		result.Put(Booresult,MsgResult );
        return result;
    }
    
    //Se deja de parametro GeneraTareaEjecutivo por si mas adelante se quiere que se le envie a cada ejecutivo invlucrado una tarea.
    //Regresa un objeto executionresult para validar si existe registrado previamente o no
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static OCCMClases.ExecutionResult IsRegisteredCompanyMethod(OCCMClases.PersonalData DataLeadInfo, Boolean GeneraTareaEjecutivos)
    {
        String MessageResult='';
        String JSONString = '';
        OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
        Map<String, String> StatusRegistered;
        String TmpCadena;
        String tempmesg='';
        Boolean Existe=true;
        try{
            StatusRegistered = IsRegisteredCompanySearch(DataLeadInfo);
            if (!StatusRegistered.isEmpty()){
               	Set<String> Keys=new Set<String>();
               	Keys=StatusRegistered.keySet();
               	for(String key: Keys){
               		if (key.contains('Exepcion')){
	                     //ExecutedStatusResult.Add(new ExecutionResult(true, StatusRegistered.get(key), null));
    	                 //MessageResult.add(StatusRegistered.get(key));
    	                tempmesg=tempmesg + StatusRegistered.get(key) + '. ';
        	        }else{
						TmpCadena=StatusRegistered.get(key);
               	    	tempmesg=tempmesg + String.format('Se encontró coincidencia de {0}, Id : {1}, propietario de registro:{2}. ',new String[]{key, Funciones.ObtieneIdRegistro(TmpCadena), Funciones.ObtienePropietario(TmpCadena)});
               	    	if (GeneraTareaEjecutivos==true){
               	    		String MensajeTarea=String.format('Se encontró coincidencia de {0}, registro:{1} ',new String[]{key, Funciones.ObtieneIdRegistro(TmpCadena)});
               	    		String PasoMsg= String.format('Los datos del formulario recibido usuario:{0}, razón social: {1}, email:{2}, telefono:{3}, tiene los siguientes errores:{4} ',new String[]{DataLeadInfo.LoginId, DataLeadInfo.CompanyName, DataLeadInfo.EmailAddress, DataLeadInfo.PhoneNumber, MensajeTarea});
               	    		Map<Boolean, String> GenerarTarea=Funciones.GeneraTareaGeneral(Funciones.ObtienePropietario(TmpCadena), 'Intento de registro duplicado', PasoMsg);
               	    	}
                   	}
               	}
				MessageResult= MessageResult + String.format('Los datos del formulario recibido usuario:{0}, razón social: {1}, email:{2}, telefono:{3}, tiene los siguientes errores:{4} ',new String[]{DataLeadInfo.LoginId, DataLeadInfo.CompanyName, DataLeadInfo.EmailAddress, DataLeadInfo.PhoneNumber, tempmesg});
				Existe=true;                	
            }else{
            	Existe=false;
            	MessageResult='No existe registro previo';
            }
        }
        catch(Exception e)
		{
			Existe=true;
            MessageResult= MessageResult + 'Exepcion IsRegisteredCompanyMethod error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
		}
        ExecutedStatusResult= new OCCMClases.ExecutionResult(Existe, MessageResult, null);
        return ExecutedStatusResult;
    }
    
    @isTest (seeAllData=true)
    public static OCCMClases.ExecutionResult TetClass(){
    	OCCMClases.ExecutionResult ExecutedStatusResult= new OCCMClases.ExecutionResult();
    	ExecutedStatusResult.success=true;
    	ExecutedStatusResult.message='';
    	ExecutedStatusResult.objectResult=null;
    	return ExecutedStatusResult;
    } 
	//Regresa una lista de conincidencias dentro del objeto o vacio si no encuentra coincidencia
	/// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static Map<String, String> IsRegisteredCompanySearch(OCCMClases.PersonalData PersonalDataInfo)
    {
        //Se elimino que regrese exepciones, ya que cuando la consulta regresa nulo tambien lo considera como exepcion
    	sObject ObjetoResultado=null;
    	Map<String, String> result= new Map<String, String>();
        String JSONString ;
        Account tmpAcc;
        Lead tmpLead;
        try
		{
            //Primero se valida que no exista como cuenta //primero comparando RFC y luego comparando en razón social
            try
            {
                    tmpAcc = [Select a.RFC_o__c, a.Owner.Name, a.OwnerId, a.Name, a.Id From Account a WHERE a.RFC_o__c =: PersonalDataInfo.BillRFC LIMIT 1];
            }
            catch(Exception e)
            {
                //result.put('ExepcionCienteRfc', 'Error al obtener el RFC de clientes');
            }
			if(tmpAcc != null){
                result.put('RFC en cuentas', tmpAcc.Owner.Name + ':' + tmpAcc.Id);
                //system.debug('En Cuenta por RFC ,' + tmpAcc.Owner.Name + ':' + tmpAcc.Id);
			}
            try
            {
            	tmpAcc = [Select a.RFC_o__c, a.Owner.Name, a.OwnerId, a.Name, a.Id From Account a WHERE a.RazonSoc_o__c =: PersonalDataInfo.CompanyName LIMIT 1];
            }
            catch(Exception e)
            {
              	//result.put('ExepcionCienteRazonSocial', 'Error al obtener la razón social de clientes');
            }
			if(tmpAcc != null){
                result.put('Razón Social en Cuentas', tmpAcc.Owner.Name + ':' + tmpAcc.Id);
                //system.debug('En Cuenta por Razon Social,' + tmpAcc.Owner.Name + ':' + tmpAcc.Id);
			}
			//Se realiza la comparacion de prospecto
			//Primero se valida que no exista como cuenta
			//primero comparando RFC y luego comparando en razon social
            try
            {
              	tmpLead = [Select l.RFC__c, l.Owner.Name, l.OwnerId, l.Id, l.Company From Lead l WHERE l.RFC__c =: PersonalDataInfo.BillRFC LIMIT 1];
            }
            catch(Exception e)
            {
            	//result.put('ExepcionProspectoRFC', 'Error al obtener el RFC de prospectos');
            }
			if(tmpLead != null){
				result.put('RFC en prospectos', tmpLead.Owner.Name + ':' + tmpLead.Id);
				//system.debug('En Prospecto por RFC,' + tmpLead.Owner.Name + ':' + tmpLead.Id);
			}
			try
            {
               	tmpLead = [Select l.RFC__c, l.Owner.Name, l.OwnerId, l.Id, l.Company From Lead l WHERE l.Company =: PersonalDataInfo.CompanyName LIMIT 1];
            }
            catch(Exception e)
            {
            	//result.put('ExepcionProspectoRazonSocial', 'Error al obtener la razón social de prospectos');
            }
			if(tmpLead != null){
				result.put('Razón Social en prospectos', tmpLead.Owner.Name + ':' + tmpLead.Id);
				//system.debug('En Prospecto por Razón Social,' + tmpLead.Owner.Name + ':' + tmpLead.Id);
			}
        }
		catch(Exception e)
		{
			result.put('Exepcion IsRegisteredCompanySearch error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString(), tmpLead.Owner.Name + ':' + tmpLead.Id);
		}
        return result;
    }
    //Regresa una lista de conincidencias dentro del objeto o vacio si no encuentra coincidencia
	/// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
	public static OCCMClases.PersonalData GetRegisteredAccount(OCCMClases.PersonalData PersonalDataInfo)
    {
        //Se elimino que regrese exepciones, ya que cuando la consulta regresa nulo tambien lo considera como exepcion
    	OCCMClases.PersonalData objetoResultado=null;
    	String IDAccount='';
        Account tmpAcc;
        OCCMClases.ExecutionResult executingStatusResult=new OCCMClases.ExecutionResult();
        try
		{
			//
            //Primero se valida que no exista como cuenta //primero comparando RFC y luego comparando en razon social
            try
            {
                    tmpAcc = [Select a.OwnerId, a.Id From Account a WHERE a.OCCM_Cuenta_Administradora__c =: PersonalDataInfo.ManagerAccount LIMIT 1];
            }
            catch(Exception e)
            {
                
            }
			if(tmpAcc != null){
                IDAccount=tmpAcc.Id;
			}
            try
            {
            	if (!String.isNotBlank(IDAccount)){
            		tmpAcc = [Select a.OwnerId, a.Name, a.Id From Account a WHERE a.RazonSoc_o__c =: PersonalDataInfo.CompanyName LIMIT 1];
            	}
            }
            catch(Exception e)
            {
              	//result.put('ExepcionCienteRazonSocial', 'Error al obtener la razón social de clientes');
            }
			if((tmpAcc != null) && (!String.isNotBlank(IDAccount))){
                IDAccount=tmpAcc.Id;
                //system.debug('En Cuenta por Razón Social,' + tmpAcc.Owner.Name + ':' + tmpAcc.Id);
			}
			if (!String.isNotBlank(IDAccount)){
				executingStatusResult= GetAccountDataUsingAccountId(IDAccount);
				if (executingStatusResult.success==true){
					objetoResultado= (OCCMClases.PersonalData) executingStatusResult.objectResult;
				}
			}
        }
		catch(Exception e)
		{
			objetoResultado=null;
		}
        return objetoResultado;
    }
    /*
    webservice static void generateSAPCFDIWS(String id,String statusCFD){
    	appServiceFacturacionSAPWSCFDI.generateSAPCFDIWS(id,statusCFD);
    }
    */
    /*********************************************************************************************************************************/
    /*                                        Metodos de prueba                                                                      */
    /*********************************************************************************************************************************/
    
    static testMethod void TestClass(){    
        Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
      	Account accountTest= new Account();
		accountTest.PaisFact_o__c = 'Mexico';
		accountTest.EstadoFact_o__c = 'Queretaro';
		accountTest.CiudadFact_opcional_o__c = 'Queretaro';
		accountTest.DelegMunicFact_o__c = 'Queretaro';
		accountTest.CalleFact_o__c = 'Calle';
		accountTest.No_de_Exterior__c = 'Ext';
		accountTest.No_de_interior__c = '01';
		accountTest.Colonia_de_Facturaci_n__c = 'Colonia';
		accountTest.CodigoPostalFact_o__c = '00000';   
		accountTest.RFC_o__c = 'RFCA000000BBB';
		accountTest.Phone='0000000000';
		accountTest.Website='http://www.pruebas.com';
		accountTest.Name = 'OMicroNew';
		accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		accountTest.Cuenta_Virtual_Banamex__c='BAN000011';
		accountTest.Type='Individual';
		accountTest.Industry='Industria';
		accountTest.Giro_o__c='Madera';
		accountTest.No_Empleados__c = '501 - 600 empleados';
		accountTest.Tipo_de_Vacante__c = 'Ejecutivo';
		accountTest.N_mero_de_Vacantes__c = '4 a 10';
		accountTest.MembresiaInteres_o__c = '5';
		accountTest.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		accountTest.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		accountTest.OCCM_Password_Cuenta_Administradora__c='Hola';
        accountTest.Clave_SAP__c='TST000000';
        accountTest.RazonSoc_o__c='razon social';
        accountTest.Personamf__c='a';
        accountTest.Telefono2_o__c = '1234567890';
        accountTest.Fax = '1234567890';
        accountTest.Cliente_SAE__c= '';    
		insert accountTest;
        system.debug('accountId: ' + accountTest.Id);
        
        
        
        Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=accountTest.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
        
        String resultadoExec = WSSalesforceRecluta.WSCreateOccmAccount(accountTest.Id);
        
        OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
			personalDataInfo.Name = contact.FirstName;
			personalDataInfo.LastName= contact.LastName;
			personalDataInfo.JobPosition = contact.Title;
			personalDataInfo.EmailAddress = contact.Email;
			personalDataInfo.ConfirmEmail = contact.Email;
			personalDataInfo.PhoneNumber = contact.Phone;
			personalDataInfo.MovilNumber = contact.Phone;
			personalDataInfo.FaxNumber = contact.Phone;
			personalDataInfo.DescripcionProductoInteres = accountTest.Producto_de_inter_s__c;
			personalDataInfo.DescripcionTipoProductoInteres = '';
			personalDataInfo.CompanyName =  accountTest.Name;
			personalDataInfo.DescripcionNumeroEmpleados = accountTest.No_Empleados__c;  
			personalDataInfo.DescripcionSector =  accountTest.Industry;
			personalDataInfo.DescripcionGiro = accountTest.Giro_o__c;
			personalDataInfo.Country =  accountTest.PaisFact_o__c;
			personalDataInfo.State = accountTest.EstadoFact_o__c;
			personalDataInfo.City = accountTest.CiudadFact_opcional_o__c;
			personalDataInfo.Municipal = accountTest.DelegMunicFact_o__c;
			personalDataInfo.StreetAddress = accountTest.CalleFact_o__c;
			personalDataInfo.ExternalNumber = accountTest.No_de_Exterior__c;
			personalDataInfo.InternalNumber = accountTest.No_de_interior__c;
			personalDataInfo.Colony = accountTest.Colonia_de_Facturaci_n__c;
			personalDataInfo.PostalCode = accountTest.CodigoPostalFact_o__c;
			personalDataInfo.WebPage = accountTest.Website;
			personalDataInfo.DescripcionMedioEntero = accountTest.C_mo_se_enter_de_OCCMundial__c;
			personalDataInfo.IsBill = true;
			personalDataInfo.BillRFC = accountTest.RFC_o__c;
			personalDataInfo.BillName = accountTest.Name;
			personalDataInfo.BillCountry = accountTest.PaisFact_o__c;
			personalDataInfo.BillState = accountTest.EstadoFact_o__c;
			personalDataInfo.BillCity = accountTest.CiudadFact_opcional_o__c;
			personalDataInfo.BillMunicipal = accountTest.DelegMunicFact_o__c;
			personalDataInfo.BillStreet = accountTest.CalleFact_o__c;
			personalDataInfo.BillExternalNumber = accountTest.No_de_Exterior__c;
			personalDataInfo.BillInternalNumber =  accountTest.No_de_interior__c;
			personalDataInfo.BillColony = accountTest.Colonia_de_Facturaci_n__c;
			personalDataInfo.BillPostalCode = accountTest.CodigoPostalFact_o__c;
			personalDataInfo.LoginDisabled = 'false';
			personalDataInfo.Password = accountTest.OCCM_Password_Cuenta_Administradora__c;
			personalDataInfo.ConfirmPassword = accountTest.OCCM_Password_Cuenta_Administradora__c;
			personalDataInfo.DescripcionVacantesACubrir = accountTest.N_mero_de_Vacantes__c;
			personalDataInfo.DescripcionTipoVacante = accountTest.Tipo_de_Vacante__c;
			personalDataInfo.DescripcionTipoProductoInteres = accountTest.Type;
			personalDataInfo.SalesforceId = accountTest.Id;
			personalDataInfo.LoginId = accountTest.OCCM_Cuenta_Administradora__c;
			personalDataInfo.ManagerAccount = accountTest.OCCM_Cuenta_Administradora__c;
			personalDataInfo.Password = accountTest.OCCM_Password_Cuenta_Administradora__c;
			personalDataInfo.PasswordManagerAccount = accountTest.OCCM_Password_Cuenta_Administradora__c;
			
		
		OCCMClases.PersonalData getRegisteredAccount = WSSalesforceRecluta.GetRegisteredAccount(null);
			String personalDataInfoJSON = JSON.serialize(personalDataInfo);
			OCCMClases.PersonalData getRegisteredAccount1 = WSSalesforceRecluta.GetRegisteredAccount(personalDataInfo);
        
        
        Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	accountTest.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='100000';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EjecutivoAsig_o__c=UserInfo.Id;
        opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Cierre';
		opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		opp.Cuenta_Banco__c='BANORTE 3598';
		opp.Importe__c=0.0;
		opp.Referencia_Banc__c='_systestSale';
        opp.FormaDePago_o__c='Tarjeta de crédito';
        opp.Comentarios__c='OK';
        opp.Referencia_Numerica_del__c='0';
        opp.TipoCambio_o__c=0;
        opp.Orden_de_Compra__c='1234';
        opp.N_mero_de_Proveedor__c='cd12';
        opp.Observaciones_SAP__c='';
        opp.Clasificaci_n_de_Factura__c='Facturación';
		opp.Estatus_de_pago__c='Anticipo Totalizado';
		opp.Fecha_de_Pago_Bancario__c=date.today();
        opp.Concepto_de_Cobro__c='';
        opp.N_mero_de_Cuenta_Pago__c='1234';
        opp.Factura_cobrada__c=false;
        opp.Forma_de_Pago__c = 'Efectivo';
        // ----------------------------------------------------------------------------------------------- Create Opp
        insert opp;
        system.debug('OpportunityID: ' + opp.Id);
        // ----------------------------------------------------------------------------------------------- Test CIE
        String insertarCIE = InsertCieValue(opp.Id, '000064550');
        insertarCIE = InsertCieValue('000064550', '000064550');
        insertarCIE = InsertCieValue('', '');
        insertarCIE = InsertCieValue(null, null);
	
		IsNewBusinessModelAccount(accountTest.Id);
		MigrateAccount(accountTest.Id, 'Newmodel', 'cuenta@cuenta.com');
		SendAccountToOccm(accountTest.Id);
		
		Lead lead = new Lead();
		lead.FirstName='Nombre';
		lead.LastName='Apellido';
		lead.title='Posicion';
		lead.phone='0000000000';
		lead.email='email@email.com';
		lead.Company='TestMethod';
		lead.Industry='Explotacion de Recursos Forestales';
		lead.Giro_o__c= 'Aprovechamiento forestal';
		lead.Calle_o__c= 'Calle'; 
		lead.No_de_Exterior_de_Facturacion__c= 'Ext';
		lead.No_de_interior_de_Facturacion__c= 'Int';
		lead.Colonia__c= 'Colonia';
		lead.Pais_o__c= 'Mexico';
		lead.Estado__c= 'Michoacan';
		lead.MobilePhone= '0000000000';
		lead.Producto_de_inter_s__c= 'Membresía OCC Premium';
		lead.MembresiaInteres_o__c= '1 Mes';
		lead.No_Empleados__c= '21 - 40 empleados';
		lead.RFC__c= 'NEFA000000STO';
		lead.N_mero_de_Vacantes__c= '11 a 20';
		lead.Tipo_deVacante__c= 'Ejecutivo';
		lead.C_mo_se_enter_de_OCCMundial_com__c= 'Radio';
		lead.OCCM_Cuenta_Administradora__c= '';
		lead.OCCM_Password_Cuenta_Administradora__c= '';
		lead.CodPostal_o__c='000000';
		lead.Website='http://www.pruebas.com';	
		lead.DelegMunic_o__c = 'Querétaro';	
		lead.DelegMunic_o__c = 'Querétaro';
		lead.Ciudad_opcional_o__c = 'Querétaro';	
		lead.MobilePhone = '0000000000';	
		lead.LeadSource= 'Web';
		
		insert lead;
		
		Set<String> accs= new Set<String>();
		accs.Add(lead.Id);		
		UpdateLeadInvoiceInformation(accs);
		
		
		String pideWs= WSSalesforceRecluta.WSGenerateGeneralTask(userInfo.Id, 'Pruebas ', 'Probando todo');
		
    }
    
    
    
    
    @isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnlyNew() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		Product2 productB = new Product2();
			productB.ProductCode = 'TEST000001B';
            productB.Family = 'Negocio Base';
			productB.Name = 'Plan 1 Vacante Semanal';
            productB.Tipo_de_Producto__c = 'Venta';
			productB.NumLicencias_o__c = 1;
			productB.Vigencia_de_Paquete_d_as__c = '30';
            productB.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            productB.Identidades_Incluidas__c = 10;
            productB.PDA_s_Inclu_dos__c = 1;
            productB.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            productB.IsActive = true;
            productB.No2__c = 'PRO-0001B';
            productB.CurrencyIsoCode='MXN';
		insert productB;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = productB.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		
		
		priceBookEntry.add(pbe);
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = productB.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		
		priceBookEntry.add(pbe);	
		
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
		
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=account.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
									
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Cierre';
		opp.NunOfertafisica_o__c='FACT00000000';
		//opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		insert opp;
			
		String insertarCIE = InsertCieValue(opp.Id, '000064550');
		//opp.SyncedQuoteId = quote.Id;
		//update opp;
				
		OpportunityLineItem oli= new OpportunityLineItem();
		for (PricebookEntry pe: priceBookEntry){
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
		}
		
		//Oportunidad bien
		account.Cuenta_Virtual_Banamex__c=opp.Referencia_Bancaria__c;
		update account;
		//Actualiza el estatus de la oportunidad
		OCCMClases.StatementString statementString= new OCCMClases.StatementString();
		statementString.Id=1;
		statementString.EntryDate= String.valueOf(date.today());
		statementString.Amount = opp.Amount;
		statementString.ReferenceNumber = opp.Referencia_Bancaria__c;
		//statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementString.VirtualAccountIdCompany = 'VANoExiste';
    	statementString.ReferenceAlpha=opp.Referencia_Bancaria__c;
    	statementString.ReferenceBank = opp.Referencia_Bancaria__c;
    	statementString.ModifiedDate = String.valueOf(date.today());
    	statementString.Status = 'Procesado';

		String statementStringS= JSON.serialize(statementString);
		
		statementStringS = 
			'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
			+ statementStringS +
			'}';

			
		String UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
		
		String UpdatePaymentOpportunityStatusComplete= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementStringS= JSON.serialize(statementString);
		UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
		
		//UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		UpdatePaymentOpportunityStatusComplete= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
		String SenttoOccm= SendProductsToOccm(opp.Id);
		String SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		//SendProductsToOccmMethod
		
		//SendProductsToOccmMethod
		
		opp.Tipo_de_vigencia__c='Manual';
		opp.EstatusFactura__c='En transito';
		opp.Tipo_de_Facturacion__c='Credito';
		update opp;
		
		String UpdatePaymentOpportunityStatuseerr= UpdatePaymentOpportunityStatus(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeerr= UpdatePaymentOpportunityStatusMethod(statementStringS);
		
		String UpdatePaymentOpportunityStatuseCompleteerr= UpdatePaymentOpportunityStatusComplete(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeCompleteerr= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		opp.FinVigencia_o__c=null;
		update opp;
		account.Cuenta_Virtual_Banamex__c=null;
		account.OCCM_Cuenta_Administradora__c = null;
		update account;
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		update account;
		opp.FinVigencia_o__c=date.today();
		update opp;
    }
	@isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnly() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);	
		
		
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
		
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=account.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
									
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Cierre';
		opp.NunOfertafisica_o__c='FACT00000000';
		//opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		insert opp;
			
		String insertarCIE = InsertCieValue(opp.Id, '000064550');
		//opp.SyncedQuoteId = quote.Id;
		//update opp;
				
		OpportunityLineItem oli= new OpportunityLineItem();
		for (PricebookEntry pe: priceBookEntry){
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
		}
		
		//Oportunidad bien
		//account.Cuenta_Virtual_Banamex__c=opp.Referencia_Bancaria__c;
		update account;
		//Actualiza el estatus de la oportunidad
		OCCMClases.StatementString statementString= new OCCMClases.StatementString();
		statementString.Id=1;
		statementString.EntryDate= String.valueOf(date.today());
		statementString.Amount = opp.Amount;
		statementString.ReferenceNumber = opp.Referencia_Bancaria__c;
		//statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementString.VirtualAccountIdCompany = 'VANoExiste';
    	statementString.ReferenceAlpha=opp.Referencia_Bancaria__c;
    	statementString.ReferenceBank = opp.Referencia_Bancaria__c;
    	statementString.ModifiedDate = String.valueOf(date.today());
    	statementString.Status = 'Procesado';

		String statementStringS= JSON.serialize(statementString);
		
		statementStringS = 
			'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
			+ statementStringS +
			'}';

			
		//String UpdatePaymentOpportunityStatusErr= UpdatePaymentOpportunityStatus('SinValor');
		String UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
		
		//String UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		String UpdatePaymentOpportunityStatusComplete= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementStringS= JSON.serialize(statementString);
		//UpdatePaymentOpportunityStatusErr= UpdatePaymentOpportunityStatus('SinValor');
		UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
		
		//UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		UpdatePaymentOpportunityStatusComplete= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
		String SenttoOccm= SendProductsToOccm(opp.Id);
		String SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		//SendProductsToOccmMethod
		
		//SendProductsToOccmMethod
		
		opp.Tipo_de_vigencia__c='Manual';
		opp.EstatusFactura__c='En transito';
		opp.Tipo_de_Facturacion__c='Credito';
		update opp;
		
		String UpdatePaymentOpportunityStatuseerr= UpdatePaymentOpportunityStatus(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeerr= UpdatePaymentOpportunityStatusMethod(statementStringS);
		
		String UpdatePaymentOpportunityStatuseCompleteerr= UpdatePaymentOpportunityStatusComplete(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeCompleteerr= UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		opp.FinVigencia_o__c=null;
		update opp;
		account.Cuenta_Virtual_Banamex__c=null;
		account.OCCM_Cuenta_Administradora__c = null;
		update account;
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		update account;
		opp.FinVigencia_o__c=date.today();
		
		
		opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c='Automática';
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount=10000;
		opp.StageName = 'Cierre';
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		update opp;
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
    }
	@isTest (seeAllData=true)
	static void TestPaymentOpportunitynsertCIE() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
								
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);	
		
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/											
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
		
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=account.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
									
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Cierre';
		opp.NunOfertafisica_o__c='FACT00000000';
		opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		insert opp;
		//Folio-000064550
		String insertarCIE = InsertCieValue(opp.Id, '000064550');
		
	}
	
	@isTest (seeAllData=true)
	static void TestAutorizationOpportunity() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/
		
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);	
		
														
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
									
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Solicitada';
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Solicitada';
		opp.NunOfertafisica_o__c='FACT00000000';
		//opp.EstatusFactura__c='Solicitada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Solicitada';
		opp.CloseDate = Date.today();
		//opp.NumFact__c='Folio-000064514';
		insert opp;
		
		OpportunityLineItem oli= new OpportunityLineItem();
		for (PricebookEntry pe: priceBookEntry){
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
		}	
		Autorizaciones__c aut = new Autorizaciones__c();
		aut.Oportunidad__c= opp.Id;
		aut.Autorizado__c= false;
		aut.Tipo_de_Autorizaci_n__c = 'Cortesía';
		aut.Cantidad_de_Cortes_a__c = 100;
		aut.Importe_por_Nota_de_Cr_dito_NBE__c=100;
		aut.Importe_de_descuento__c=100;
		insert aut;

		//aut.Autorizado__c= true;
		//update aut;
		//Actualizamos cada uno s le los productos
		aut.Producto__c = 'Cortesías de Vacantes';
		update aut;
		
		aut.Producto__c = 'Cortesías de Vacantes Premium';
		update aut;
		
		aut.Producto__c = 'Cortesías de Vacantes destacadas';
		update aut;
		
		aut.Producto__c = 'Cortesías de datos de contacto';
		update aut;
		
		aut.Producto__c = 'Cortesías PDA';
		update aut;
		
		aut.Producto__c = 'Nota de Credito'; 
		update aut;
		
		aut.Producto__c = 'Descuento en Factura';
		update aut;
		
		opp.StageName='Cierre';
		opp.EstatusFactura__c='Cobrada';
		update opp;
		//String insertarCIE = InsertCieValue(opp.Id, opp.NumFact__c.substring(6, opp.NumFact__c.length()));
	}
	
	
	static testMethod void TestSendsIsNewBusinessModelAccountRequest() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
					
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
		
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=account.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
		
		String Id15=account.Id;
		Id15=Id15.substring(1,15);
		OCCMClases.ExecutionResult sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(Id15);
		Id15=account.Id;
		Id15=Id15.substring(1,16);
		sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(Id15);
		
		sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(account.Id);
		String createOccmAccountMethod=CreateOccmAccountMethod(account.Id);
		
		OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
		personalDataInfo.Name = contact.FirstName;
		personalDataInfo.LastName= contact.LastName;
		personalDataInfo.JobPosition = contact.Title;
		personalDataInfo.EmailAddress = contact.Email;
		personalDataInfo.ConfirmEmail = contact.Email;
		personalDataInfo.PhoneNumber = contact.Phone;
		personalDataInfo.MovilNumber = contact.Phone;
		personalDataInfo.FaxNumber = contact.Phone;
		personalDataInfo.DescripcionProductoInteres = account.Producto_de_inter_s__c;
		personalDataInfo.DescripcionTipoProductoInteres = '';
		personalDataInfo.CompanyName =  account.Name;
		personalDataInfo.DescripcionNumeroEmpleados = account.No_Empleados__c;  
		personalDataInfo.DescripcionSector =  account.Industry;
		personalDataInfo.DescripcionGiro = account.Giro_o__c;
		personalDataInfo.Country =  account.PaisFact_o__c;
		personalDataInfo.State = account.EstadoFact_o__c;
		personalDataInfo.City = account.CiudadFact_opcional_o__c;
		personalDataInfo.Municipal = account.DelegMunicFact_o__c;
		personalDataInfo.StreetAddress = account.CalleFact_o__c;
		personalDataInfo.ExternalNumber = account.No_de_Exterior__c;
		personalDataInfo.InternalNumber = account.No_de_interior__c;
		personalDataInfo.Colony = account.Colonia_de_Facturaci_n__c;
		personalDataInfo.PostalCode = account.CodigoPostalFact_o__c;
		personalDataInfo.WebPage = account.Website;
		personalDataInfo.DescripcionMedioEntero = account.C_mo_se_enter_de_OCCMundial__c;
		personalDataInfo.IsBill = true;
		personalDataInfo.BillRFC = account.RFC_o__c;
		personalDataInfo.BillName = account.Name;
		personalDataInfo.BillCountry = account.PaisFact_o__c;
		personalDataInfo.BillState = account.EstadoFact_o__c;
		personalDataInfo.BillCity = account.CiudadFact_opcional_o__c;
		personalDataInfo.BillMunicipal = account.DelegMunicFact_o__c;
		personalDataInfo.BillStreet = account.CalleFact_o__c;
		personalDataInfo.BillExternalNumber = account.No_de_Exterior__c;
		personalDataInfo.BillInternalNumber =  account.No_de_interior__c;
		personalDataInfo.BillColony = account.Colonia_de_Facturaci_n__c;
		personalDataInfo.BillPostalCode = account.CodigoPostalFact_o__c;
		personalDataInfo.LoginDisabled = 'false';
		personalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.ConfirmPassword = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.DescripcionVacantesACubrir = account.N_mero_de_Vacantes__c;
		personalDataInfo.DescripcionTipoVacante = account.Tipo_de_Vacante__c;
		personalDataInfo.DescripcionTipoProductoInteres = account.Type;
		personalDataInfo.SalesforceId = account.Id;
		personalDataInfo.LoginId = account.OCCM_Cuenta_Administradora__c;
		personalDataInfo.ManagerAccount = account.OCCM_Cuenta_Administradora__c;
		personalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.PasswordManagerAccount = account.OCCM_Password_Cuenta_Administradora__c;
			
		String personalDataInfoJSON = JSON.serialize(personalDataInfo);
		OCCMClases.PersonalData getRegisteredAccount1 = GetRegisteredAccount(personalDataInfo);
			
			
		//SendsIsNewBusinessModelAccountRequest(String inputAccountId)
	}
	
    
    @isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnlyMissingAccount() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);	
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/												
      	Account account= new Account();
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='http://www.pruebas.com';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
									
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		opp.StageName='Cierre';
		opp.NunOfertafisica_o__c='FACT00000000';
		//opp.EstatusFactura__c='Aprobada';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		insert opp;
			
			
		//opp.SyncedQuoteId = quote.Id;
		//update opp;
				
		OpportunityLineItem oli= new OpportunityLineItem();
		for (PricebookEntry pe: priceBookEntry){
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
		}	
		//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
		String SenttoOccm= SendProductsToOccm(opp.Id);
		String SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		
		//Se manda error en la oportunidad sin cuenta asignada
		opp.AccountId =	null;
		update opp;
		SenttoOccm= SendProductsToOccm(opp.Id);
		SenttoOccmM= SendProductsToOccmMethod(opp.Id);
		opp.AccountId =	account.Id;
		update opp;
		
	}
	static testMethod void TestLeadQuote() {
		Lead lead = new Lead();
		lead.FirstName='Nombre';
		lead.LastName='Apellido';
		lead.title='Posicion';
		lead.phone='0000000000';
		lead.email='email@email.com';
		lead.Company='TestMethod';
		lead.Industry='Explotacion de Recursos Forestales';
		lead.Giro_o__c= 'Aprovechamiento forestal';
		lead.Calle_o__c= 'Calle'; 
		lead.No_de_Exterior_de_Facturacion__c= 'Ext';
		lead.No_de_interior_de_Facturacion__c= 'Int';
		lead.Colonia__c= 'Colonia';
		lead.Pais_o__c= 'Mexico';
		lead.Estado__c= 'Michoacan';
		lead.MobilePhone= '0000000000';
		lead.Producto_de_inter_s__c= 'Membresía OCC Premium';
		lead.MembresiaInteres_o__c= '1 Mes';
		lead.No_Empleados__c= '21 - 40 empleados';
		lead.RFC__c= 'NEFA000000STO';
		lead.N_mero_de_Vacantes__c= '11 a 20';
		lead.Tipo_deVacante__c= 'Ejecutivo';
		lead.C_mo_se_enter_de_OCCMundial_com__c= 'Radio';
		lead.OCCM_Cuenta_Administradora__c= '';
		lead.OCCM_Password_Cuenta_Administradora__c= '';
		lead.CodPostal_o__c='000000';
		lead.Website='http://www.pruebas.com';	
		lead.DelegMunic_o__c = 'Querétaro';	
		lead.DelegMunic_o__c = 'Querétaro';
		lead.Ciudad_opcional_o__c = 'Querétaro';	
		lead.MobilePhone = '0000000000';	
		lead.LeadSource= 'Web';
		insert lead;
		
		OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
		personalDataInfo.Name = lead.FirstName;
		personalDataInfo.LastName= lead.LastName;
		personalDataInfo.JobPosition = lead.title;
		personalDataInfo.EmailAddress = lead.Email;
		personalDataInfo.ConfirmEmail = lead.Email;
		personalDataInfo.PhoneNumber = lead.Phone;
		personalDataInfo.MovilNumber  = lead.MobilePhone;
		personalDataInfo.FaxNumber = lead.Fax; 
		personalDataInfo.DescripcionProductoInteres = lead.Producto_de_inter_s__c;
		personalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;  
		personalDataInfo.CompanyName = lead.Company;
		personalDataInfo.DescripcionNumeroEmpleados = lead.No_Empleados__c; 
		personalDataInfo.DescripcionSector = lead.Industry;
		personalDataInfo.DescripcionGiro = lead.Giro_o__c;
		personalDataInfo.Country = lead.Pais_o__c;
		personalDataInfo.State = lead.Estado__c;
		personalDataInfo.City = lead.Ciudad_opcional_o__c;
		personalDataInfo.Municipal = lead.DelegMunic_o__c;
		personalDataInfo.StreetAddress = lead.Calle_o__c;
		personalDataInfo.ExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
		personalDataInfo.InternalNumber= lead.No_de_interior_de_Facturacion__c;
		personalDataInfo.Colony = lead.Colonia__c;
		personalDataInfo.PostalCode = lead.CodPostal_o__c;
		personalDataInfo.WebPage = lead.Website;
		personalDataInfo.DescripcionMedioEntero = lead.C_mo_se_enter_de_OCCMundial_com__c;   
		personalDataInfo.IsBill = true;
		personalDataInfo.BillRFC = lead.RFC__c;
		personalDataInfo.BillName = lead.Company;
		personalDataInfo.BillCountry = lead.Pais_o__c;
		personalDataInfo.BillState = lead.Estado__c;
		personalDataInfo.BillCity = lead.Ciudad_opcional_o__c;
		personalDataInfo.BillMunicipal = lead.DelegMunic_o__c;
		personalDataInfo.BillStreet = lead.Calle_o__c;
		personalDataInfo.BillExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
		personalDataInfo.BillInternalNumber= lead.No_de_interior_de_Facturacion__c;
		personalDataInfo.BillColony = lead.Colonia__c;
		personalDataInfo.BillPostalCode = lead.CodPostal_o__c;
		personalDataInfo.LoginDisabled = 'false';
		personalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.ConfirmPassword = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.DescripcionVacantesACubrir = lead.N_mero_de_Vacantes__c;
		personalDataInfo.DescripcionTipoVacante = lead.Tipo_deVacante__c;
		personalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;
		personalDataInfo.SalesforceId = lead.Id;
		personalDataInfo.LoginId = lead.OCCM_Cuenta_Administradora__c;
		personalDataInfo.ManagerAccount = lead.OCCM_Cuenta_Administradora__c;
		personalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.PasswordManagerAccount = lead.OCCM_Password_Cuenta_Administradora__c;
		
		OCCMClases.ExecutionResult getLeadDataUsingLeadId = GetLeadDataUsingLeadId(null);
		String sendLeadToOccm = SendLeadToOccm(null);
		String wsIsregisteresCompany = WSIsRegisteredCompany(null);
		String wsRegisterLead = WSRegisterLead(null);

		String personalDataInfoJSON = JSON.serialize(personalDataInfo);
		String personalDataInfoJSONList = '[' + personalDataInfoJSON + ']';
		String sendLeadToOccm1 = SendLeadToOccm(lead.Id);
		OCCMClases.ExecutionResult getLeadDataUsingLeadId1 = GetLeadDataUsingLeadId(lead.Id);
		OCCMClases.ExecutionResult getLeadDataUsingLeadId2 = GetLeadDataUsingLeadId(null);
		String wsIsregisteresCompany1 = WSIsRegisteredCompany(lead.Id);
		OCCMClases.ExecutionResult isRegisteredCompanymethod = IsRegisteredCompanymethod(personalDataInfo,false);
		OCCMClases.ExecutionResult isRegisteredCompanymethod1 = IsRegisteredCompanymethod(personalDataInfo,true);
		OCCMClases.ExecutionResult isRegisteredCompanymethod2 = IsRegisteredCompanymethod(null,false);
		
		String wsIsRegisteredCompany= WSIsRegisteredCompany(personalDataInfoJSON);
		String wsRegisterLead1 = WSRegisterLead(lead.Id);
		wsIsRegisteredCompany= WSIsRegisteredCompany(personalDataInfoJSONList);
		
		Account account= new Account();
			account.PaisFact_o__c = 'Mexico';
			account.EstadoFact_o__c = 'Queretaro';
			account.CiudadFact_opcional_o__c = 'Queretaro';
			account.DelegMunicFact_o__c = 'Queretaro';
			account.CalleFact_o__c = 'Calle';
			account.No_de_Exterior__c = 'Ext';
			account.No_de_interior__c = '01';
			account.Colonia_de_Facturaci_n__c = 'Colonia';
			account.CiudadFact_opcional_o__c = 'Ciudad';
			account.CodigoPostalFact_o__c = '00000';   
			account.RFC_o__c = 'RFCA000000AAA';
			account.Phone='0000000000';
			account.Website='http://www.pruebas.com';
			account.Name = 'OMicro';
			//accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
			//accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
			//accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
			account.Type='Individual';
			account.Industry='Industria';
			account.Giro_o__c='Madera';
			account.No_Empleados__c = '501 - 600 empleados';
			account.Tipo_de_Vacante__c = 'Ejecutivo';
			account.N_mero_de_Vacantes__c = '4 a 10';
			account.MembresiaInteres_o__c = '5';
			account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
			account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
			account.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
			account.OCCM_Password_Cuenta_Administradora__c='Hola';
			insert account;
			Contact contact= new Contact();
			contact.LastName = 'Uno';
			contact.FirstName='Contact';
			contact.AccountId=account.Id;
			contact.Phone='0000000000';
			contact.Email='ContactUno@ContactUno.com';
			contact.LeadSource='Web';
			contact.Title= 'TituloPuesto';
			contact.Fecha__c= Date.today();
			insert contact;
			String updateSalesforceLeadAccount = UpdateSalesforceIdLeadAccount(lead.Id,account.Id);
			String  wsRegisterLeada = WSRegisterLead(personalDataInfoJSONList); 
			String  wsRegisterLeada1 = WSRegisterLead(personalDataInfoJSON);
			String  wsRegisterLeada2 = WSRegisterLead(null);
			
			OCCMClases.ExecutionResult  registerLeadMethoda2 = RegisterLeadMethod(personalDataInfo);
			OCCMClases.ExecutionResult  registerLeadMethoda3 = RegisterLeadMethod(null);			
			//String  generaTareasRegisterCompany = GeneraTareasRegisterCompany();
			Map<Boolean,String> GenerarTarea=GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', 'No existe', 'Atención a Clientes');
			Map<Boolean,String> GenerarTarea1=GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', '', 'Atención a Clientes');
			//Map<Boolean,String> GenerarTarea2=GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', null, 'Atención a Clientes');
			
			OCCMClases.ExecutionResult result= new OCCMClases.ExecutionResult(true, 'Resultado satisfactorio', personalDataInfo);
			Map<Boolean,String> GenerarTarea3=GeneraTareasRegisterCompany(result, 'Sin existencia previa', 'Atención a Clientes');
			Map<Boolean,String> GenerarTarea4=GeneraTareasRegisterCompany(result, '', 'Atención a Clientes');
			//Map<Boolean,String> GenerarTarea5=GeneraTareasRegisterCompany(result, null, 'Atención a Clientes');
			
			personalDataInfo.FechaMigracionPaquetes='2013-01-01';
			PersonalDataInfo.WebPage='www.aplica.com';
			OCCMClases.ExecutionResult  registerLeadMethodaErroresRegistros = RegisterLeadMethod(personalDataInfo);
	}
	@isTest (seeAllData=true)
	static void TestOpportunityQuote() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		/*
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		ID liPriceId='01s50000000MVrDAAW'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox	
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);	
		
		//Test.startTest();		
		//System.runAs(UserInfo) { 
      		Account account= new Account();
			account.PaisFact_o__c = 'Mexico';
			account.EstadoFact_o__c = 'Queretaro';
			account.CiudadFact_opcional_o__c = 'Queretaro';
			account.DelegMunicFact_o__c = 'Queretaro';
			account.CalleFact_o__c = 'Calle';
			account.No_de_Exterior__c = 'Ext';
			account.No_de_interior__c = '01';
			account.Colonia_de_Facturaci_n__c = 'Colonia';
			account.CiudadFact_opcional_o__c = 'Ciudad';
			account.CodigoPostalFact_o__c = '00000';   
			account.RFC_o__c = 'RFCA000000BBB';
			account.Phone='0000000000';
			account.Website='http://www.pruebas.com';
			account.Name = 'OMicroNew';
			account.OCCM_Password_Cuenta_Administradora__c = 'password';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			//account.Cuenta_Virtual_Banamex__c='BAN000011';
			
			account.Type='Individual';
			account.Industry='Industria';
			account.Giro_o__c='Madera';
			account.No_Empleados__c = '501 - 600 empleados';
			account.Tipo_de_Vacante__c = 'Ejecutivo';
			account.N_mero_de_Vacantes__c = '4 a 10';
			account.MembresiaInteres_o__c = '5';
			account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
			account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
			//account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			//account.OCCM_Password_Cuenta_Administradora__c='Hola';
			insert account;

			Contact contact= new Contact();
			contact.LastName = 'Uno';
			contact.FirstName='Contact';
			contact.AccountId=account.Id;
			contact.Phone='0000000000';
			contact.Email='ContactUno@ContactUno.com';
			contact.LeadSource='Web';
			contact.Title= 'TituloPuesto';
			contact.Fecha__c= Date.today();
			insert contact;
									
			Opportunity opp=new Opportunity();
			opp.Name='BZFAPEXTEST';
			opp.AccountId =	account.Id;
			opp.Description = 'Cuenta general';
			opp.OwnerId=userInfo.Id;
			opp.NunOfertafisica_o__c ='TestFact';
			opp.Tipo_de_vigencia__c='Automática';
			opp.StageName='Cierre';
			opp.CloseDate = Date.today();
			opp.E_mail_para_env_o_de_Factura_Elect_nica__c='estecorreo@mailinator.com';
			opp.Factura_Aprobada__c = false;
			opp.Factura_cobrada__c = false;
			opp.Paquete_de_venta__c = 3;
			//Campos requeridos factura
			//opp.EstatusFactura__c='';
			opp.EjecutivoAsig_o__c=UserInfo.Id;
			opp.Tipo_de_Facturacion__c='No Credito';
			opp.FechaFactura_o__c=Date.today();
			opp.InicioVigencia_o__c = Date.today();
			opp.FinVigencia_o__c = Date.today();
			opp.FechaPago__c=Date.today();
			opp.CurrencyIsoCode='MXN';
			opp.Clave_metodo_pago__c='Efectivo';
			insert opp;
			
			/* */
			//Antes de insertar se manda llamar el CompleteListProductsInQuote sin haber creado el quote para generar error
			//Se crea un presupuesto ficticio que no existe
			String clpsinqlierr= CompleteListProductsInQuote('A00000000000');
			String clpsinqliMerr= CompleteListProductsInQuoteMethod('A00000000000');
			//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
			String SenttoOccmErr1= SendProductsToOccm(null);
			String SenttoOccmErr= SendProductsToOccm(opp.Id);
			
			Quote quote= new Quote();
			quote.Name='Presupuesto001';
			quote.Opportunity=opp;
			quote.ExpirationDate=Date.today();
			quote.Is_Future_Context__c=false;
			quote.OpportunityId= opp.Id;
			quote.Pricebook2Id=liPriceId;
			//quote.CurrencyIsoCode='MXN';
			insert quote;
			
			//Agregar la partida del presupuesto
			QuoteLineItem qli= new QuoteLineItem();
			for (PricebookEntry pe: priceBookEntry){
				qli= new QuoteLineItem();
				qli.QuoteId=quote.id;
				qli.Quantity=1;
				qli.UnitPrice=100;
				qli.PricebookEntryId=pe.Id;
				//qli.CurrencyIsoCode='MXN';
				insert qli;
			}
			
			/* */
			//Se manda llamar metodos de completar lista despues de insertar la partida en el presupuesto pero sin descuentos, ni cortesias, ni pdas incluidos
			//Para generar error.
			String clpsinqlierr1= CompleteListProductsInQuote(quote.Id);
			String clpsinqliMerr1= CompleteListProductsInQuoteMethod(quote.Id);
			
			
			//Se manda llamar las partidas para actualizarles los produtos de cortesia
			QuoteLineItem[] qliList = [SELECT Id, QuoteId, Quantity, UnitPrice, PricebookEntryId,Vacante_de_Cortes_a__c,Descuento2__c,Pda_s_incluidos__c   
											FROM QuoteLineItem
											WHERE QuoteId =: quote.id];
			for(QuoteLineItem qlitmp: qliList){
				qlitmp.Vacante_de_Cortes_a__c= 10;
				qlitmp.Descuento2__c=5;
				qlitmp.Pda_s_incluidos__c =1;
				update qlitmp;
			}
			/* */
			//Se manda llamar metodos de completar lista con los valores correctos en la creacion d ela partida y los valores de descuerto
			//Para generar error.
			String clpsinqli= CompleteListProductsInQuote(quote.Id);
			String clpsinqliM= CompleteListProductsInQuoteMethod(quote.Id);

			//system.debug('Probando envio debug');
			
			opp.NunOfertafisica_o__c=null;
			//opp.EstatusFactura__c='Solicitada';
			opp.Tipo_de_vigencia__c ='Automática';
			opp.FinVigencia_o__c=null;
			opp.Referencia_Bancaria__c=null;
			opp.Amount = null;
			opp.Fecha_de_envio_de_paquetes_OCCM__c=date.today();
			opp.StageName='Abierto';
			update opp; 
			String SenttoOccmErr2= SendProductsToOccm(opp.Id);
			
			opp.SyncedQuoteId = quote.Id;
			
			update opp;
			
			String SenttoOccmErr3= SendProductsToOccm(opp.Id);
			
			account.Cuenta_Virtual_Banamex__c='BAN000011';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			account.OCCM_Password_Cuenta_Administradora__c='Hola';
			update account;
			
			String SenttoOccmErr4= SendProductsToOccm(opp.Id);
			
			OpportunityLineItem oli= new OpportunityLineItem();
			for (PricebookEntry pe: priceBookEntry){
				oli= new OpportunityLineItem();
				oli.OpportunityId=opp.id;
				oli.Quantity=1;
				oli.UnitPrice=100;
				oli.PricebookEntryId=pe.Id;
				insert oli;
			}
			
			opp.StageName='Cierre';
			opp.NunOfertafisica_o__c='FACT00000000';
			//opp.EstatusFactura__c='Aprobada';
			//opp.EstatusFactura__c='En Transito';
			opp.Tipo_de_vigencia__c ='Automática';
			opp.FinVigencia_o__c=date.today();
			opp.Referencia_Bancaria__c='BANAMEX000';
			opp.Amount =100;
			opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
			opp.StageName='Cierre';
			update opp; 
			String SenttoOccm= SendProductsToOccm(opp.Id);
			
			//Oportunidad bien
			account.Cuenta_Virtual_Banamex__c=opp.Referencia_Bancaria__c;
			update account;
			
			opp.FinVigencia_o__c = null;
			opp.Tipo_de_vigencia__c=null;
			update opp;
			//Actualiza el estatus de la oportunidad
			OCCMClases.StatementString statement= new OCCMClases.StatementString();
			statement.Id=1;
			statement.EntryDate=String.valueOf(datetime.now());
			statement.Amount = opp.Amount;
			statement.ReferenceNumber = opp.Referencia_Bancaria__c;
			statement.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
    		statement.ReferenceAlpha='00000000';
    		statement.ReferenceBank = opp.Referencia_Bancaria__c;
    		statement.ModifiedDate = String.valueOf(datetime.now());
    		statement.Status = 'Cobrada';
			OCCMClases.StatementString statementString= new OCCMClases.StatementString();
			String statementStringS= JSON.serialize(statementString);
			statementStringS = 
				'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
				+ statementStringS +
				'}';
			String UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			String UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.FinVigencia_o__c = null;
			opp.Tipo_de_vigencia__c='Manual';
			update opp;
			
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.FinVigencia_o__c = Date.today();
			opp.Tipo_de_vigencia__c='Automática';
			update opp;
			
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.Tipo_de_Facturacion__c='Credito';
			update opp;
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			String SenttoOccmM= SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='Online';
			
			update opp;
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='No Credito (factura previa)';
			update opp;
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='No Credito';
			update opp;
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='MacroCreditoCor';
			update opp;
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= SendProductsToOccmMethod(opp.Id);
			
			account.OCCM_Password_Cuenta_Administradora__c = 'password';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			update account;
			
			UpdatePaymentOpportunityStatus= UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			account.OCCM_Password_Cuenta_Administradora__c = 'password';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			update account;
			
			//Actualiza el estatus de la oportunidad
			OCCMClases.StatementString statementStringb= new OCCMClases.StatementString();
			statementStringb.Id=1;
			statementStringb.EntryDate = String.valueOf(datetime.now());
			statementStringb.Amount = opp.Amount;
			statementStringb.ReferenceNumber = opp.Referencia_Bancaria__c;
			statementStringb.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
    		statementStringb.ReferenceAlpha='00000000';
    		statementStringb.ReferenceBank = opp.Referencia_Bancaria__c;
    		statementStringb.ModifiedDate = String.valueOf(datetime.now());
    		statementStringb.Status = 'Cobrada';
    		String statementStringSerb= JSON.serialize(statementString);
    		statementStringSerb = 
				'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
				+ statementStringSerb +
				'}';
			String UpdatePaymentOpportunityStatusOK= UpdatePaymentOpportunityStatus(statementStringSerb);
			String UpdatePaymentOpportunityStatusFacturaAproOK= UpdatePaymentOpportunityStatusMethod(statementStringSerb);
			
    		statementString.Id=1;
    		statementString.EntryDate=String.valueOf(datetime.now());
    		statementString.Amount = opp.Amount;
    		statementString.ReferenceNumber = 'BANAMEX000'; //opp.Referencia_Bancaria__c;
    		statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
    		statementString.ReferenceAlpha='00000000';
    		statementString.ReferenceBank = 'BANAMEX';
    		statementString.ModifiedDate = String.valueOf(datetime.now());
    		statementString.Status = 'Totalizado';
			String statementStringSer= JSON.serialize(statementString);
			statementStringSer = 
				'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
				+ statementStringSer +
				'}';
			//Se cambia el estatus de la oportunidad para generar error
			//Statement que va bien con informacion correcta
			String UpdatePaymentOpportunityStatuseerr= UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusFacturaAproeerr= UpdatePaymentOpportunityStatusMethod(statementStringSer);
			opp.EstatusFactura__c='En transito';
			update opp;
			//String UpdatePaymentOpportunityStatusFacturaAproOKOK= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringSer);
			//String UpdatePaymentOpportunityStatusMFacturaAproOKOK= UpdatePaymentOpportunityStatusMethod(statementStringSer);
			//Statment para que genere errores
			
			//String UpdatePaymentOpportunityStatusError1= UpdatePaymentOpportunityStatus(null);
			//String UpdatePaymentOpportunityStatusError2= UpdatePaymentOpportunityStatus('');
			//String UpdatePaymentOpportunityStatusError3= UpdatePaymentOpportunityStatusMethod(null);
			//String UpdatePaymentOpportunityStatusError4= UpdatePaymentOpportunityStatusMethod('');
			statementString.Status = 'En Transito';
			statementString.ReferenceAlpha='';
			//statementString.ReferenceBank='';
			statementString.VirtualAccountIdCompany = '';
			statementStringSer= JSON.serialize(statementString);
			statementStringSer = 
				'{"success":true,"message":"Cambiando estatus de oportunidad por pago procesado.","objectResult":'
				+ statementStringSer +
				'}';
			String UpdatePaymentOpportunityStatusFacturaErrr1= UpdatePaymentOpportunityStatusMethod(statementStringSer);
			
			String UpdatePaymentOpportunityStatus1= UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusError5= UpdatePaymentOpportunityStatusMethod(statementStringSer);
			statementString.ReferenceBank='REFQUENOEXISTE';
			statementStringSer= JSON.serialize(statementString);
			String UpdatePaymentOpportunityStatus2= UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusError6= UpdatePaymentOpportunityStatusMethod(statementStringSer);
			
			opp.EstatusFactura__c=null;
			update opp;
			//Se agrega nuevament elos metodos para que pueda eliminar un producto desde el metodo GetMessageErrorFromDeleteDML
			String mensajeBorrar='';
			oli= new OpportunityLineItem();
			for (PricebookEntry pe: priceBookEntry){
				oli= new OpportunityLineItem();
				oli.OpportunityId=opp.id;
				oli.Quantity=1;
				oli.UnitPrice=100;
				oli.PricebookEntryId=pe.Id;
				insert oli;
			}
			OpportunityLineItem[] productosOportunidad;
			productosOportunidad = [SELECT Id, OpportunityId, PricebookEntryId, PricebookEntry.Name, PricebookEntry.ProductCode, Quantity, UnitPrice
								FROM OpportunityLineItem 
								WHERE OpportunityId =: opp.id];
			//opp.EstatusFactura__c='';
			update opp;	
			mensajeBorrar= Funciones.GetMessageErrorFromDeleteDML(null);
			mensajeBorrar= Funciones.GetMessageErrorFromDeleteDML(Database.delete(productosOportunidad));
			opp.EstatusFactura__c='En transito';
			oli= new OpportunityLineItem();
			for (PricebookEntry pe: priceBookEntry){
				oli= new OpportunityLineItem();
				oli.OpportunityId=opp.id;
				oli.Quantity=1;
				oli.UnitPrice=100;
				oli.PricebookEntryId=pe.Id;
				insert oli;
			}
			
			//Se manda actualizar la oportunidad para que mande llamar el metodo GetMessageErrorFromSaveDML
			String mensajeSave='';
			opp.EstatusFactura__c ='Cobrada';
			opp.Fecha_de_envio_de_paquetes_OCCM__c=Date.today();
			List<Opportunity> oppsToUpdate = new List<Opportunity>();
			oppsToUpdate.add(opp);
			mensajeSave= Funciones.GetMessageErrorFromSaveDML(null);
			mensajeSave= Funciones.GetMessageErrorFromSaveDML(Database.update(oppsToUpdate, false));
			
			opp.EstatusFactura__c='';
		update opp;	
			//Se borran prod in oportunidy
			String BorrarProductosOpportunidad = DeleteListProductsInOpportunity(quote.Id);
			BorrarProductosOpportunidad =DeleteListProductsInOpportunity('A00000000000');
			String clpdeleerr1= DeleteListProductsInQuote(quote.Id);
			String clpdeleerr= DeleteListProductsInQuote('A00000000000');
			
			String clpdele= DeleteListProductsInQuote(quote.Id);
			String clpsinqliMComplete= CompleteListProductsInQuoteMethod(quote.Id);
      	//Test.stopTest();
    }
	
    static testMethod void TestGetContractedPackages() {
		Account accountTest= new Account();
		accountTest.PaisFact_o__c = 'Mexico';
		accountTest.EstadoFact_o__c = 'Queretaro';
		accountTest.CiudadFact_opcional_o__c = 'Queretaro';
		accountTest.DelegMunicFact_o__c = 'Queretaro';
		accountTest.CalleFact_o__c = 'Calle';
		accountTest.No_de_Exterior__c = 'Ext';
		accountTest.No_de_interior__c = '01';
		accountTest.Colonia_de_Facturaci_n__c = 'Colonia';
		accountTest.CiudadFact_opcional_o__c = 'Ciudad';
		accountTest.CodigoPostalFact_o__c = '00000';   
		accountTest.RFC_o__c = 'RFCA000000AAA';
		accountTest.Phone='0000000000';
		accountTest.Website='http://www.pruebas.com';
		accountTest.Name = 'OMicro';
		//accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
		//accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		//accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		accountTest.Type='Individual';
		accountTest.Industry='Industria';
		accountTest.Giro_o__c='Madera';
		accountTest.No_Empleados__c = '501 - 600 empleados';
		accountTest.Tipo_de_Vacante__c = 'Ejecutivo';
		accountTest.N_mero_de_Vacantes__c = '4 a 10';
		accountTest.MembresiaInteres_o__c = '5';
		accountTest.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		accountTest.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		accountTest.OCCM_Password_Cuenta_Administradora__c='Hola';
		accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		String accountTestJSON = JSON.serialize(accountTest);
		//String resultadoExec = '';
		OCCMClases.ExecutionResult getContractedPackages =WSSalesforceRecluta.GetContractedPackages(accountTest.Id);
		insert accountTest;
		getContractedPackages=WSSalesforceRecluta.GetContractedPackages(accountTest.Id);
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=accountTest.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
		getContractedPackages=WSSalesforceRecluta.GetContractedPackages(accountTest.Id);
        
        OCCMClases.ExecutionResult execRes= GetAccountSummaryUsingAccountId('', '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'C', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'test@occ.com.mx');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'correofake');
        execRes= GetAccountSummaryUsingAccountId(null, 'C', 'correofake');
	}
	static testMethod void TestMigrateAccount() {
		Account accountTest= new Account();
		accountTest.PaisFact_o__c = 'Mexico';
		accountTest.EstadoFact_o__c = 'Queretaro';
		accountTest.CiudadFact_opcional_o__c = 'Queretaro';
		accountTest.DelegMunicFact_o__c = 'Queretaro';
		accountTest.CalleFact_o__c = 'Calle';
		accountTest.No_de_Exterior__c = 'Ext';
		accountTest.No_de_interior__c = '01';
		accountTest.Colonia_de_Facturaci_n__c = 'Colonia';
		accountTest.CiudadFact_opcional_o__c = 'Ciudad';
		accountTest.CodigoPostalFact_o__c = '00000';   
		accountTest.RFC_o__c = 'RFCA000000AAA';
		accountTest.Phone='0000000000';
		accountTest.Website='http://www.pruebas.com';
		accountTest.Name = 'OMicro';
		//accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
		//accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		//accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		accountTest.Type='Individual';
		accountTest.Industry='Industria';
		accountTest.Giro_o__c='Madera';
		accountTest.No_Empleados__c = '501 - 600 empleados';
		accountTest.Tipo_de_Vacante__c = 'Ejecutivo';
		accountTest.N_mero_de_Vacantes__c = '4 a 10';
		accountTest.MembresiaInteres_o__c = '5';
		accountTest.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		accountTest.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		accountTest.OCCM_Password_Cuenta_Administradora__c='Hola';
		accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		String accountTestJSON = JSON.serialize(accountTest);
		//String resultadoExec = '';
		String migrateaccount =WSSalesforceRecluta.MigrateAccount(accountTest.Id, 'C', 'test@occ.com.mx');
		insert accountTest;
		migrateaccount=WSSalesforceRecluta.MigrateAccount(accountTest.Id, 'C', 'test@occ.com.mx');
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=accountTest.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
		migrateaccount=WSSalesforceRecluta.MigrateAccountMethod(accountTest.Id, 'C', 'test@occ.com.mx');
        migrateaccount=WSSalesforceRecluta.MigrateAccountMethod(null,null, null);
        OCCMClases.ExecutionResult execRes= GetAccountSummaryUsingAccountId('', '', '');
        execRes= GetAccountSummaryUsingAccountId(accountTest.Id, '', '');
        execRes= GetAccountSummaryUsingAccountId(accountTest.Id, 'M', '');
        execRes= GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'M', '');
        execRes= GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'C', '');
        execRes= GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'test@occ.com.mx');
        execRes= GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'correofake');
        execRes= GetAccountSummaryUsingAccountId(null, 'C', 'correofake');
	}
	
/*
public static String UpdatePaymentOpportunityStatusMethod2(String inputStatement){
    	String result='';
    	OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
    	Boolean successResult=true;
        String messageResult='';
        Object objectResult=null;
        Opportunity opp=null;
        String mensaje='';
        JSONParser parser = 
   		JSON.createParser(inputStatement);
   		for (integer i=0; i<7; i++){
    	parser.nextToken();
    	}
    	
    	OCCMClases.StatementString statementData = (OCCMClases.StatementString)parser.readValueAs(OCCMClases.StatementString.class);
    system.debug('Id:' + statementData.Id);
    		system.debug('EntryDateToString:' + String.valueOf(statementData.EntryDateToString));
    		system.debug('EntryDate:' + statementData.EntryDate);
    		system.debug('Amount:' + String.valueOf(statementData.Amount));
    		system.debug('ReferenceNumber:' + statementData.ReferenceNumber);
    		system.debug('VirtualAccountIdCompany:' + statementData.ReferenceNumber);
    		system.debug('ReferenceAlpha:' + statementData.ReferenceAlpha);
    		system.debug('ReferenceBank:' + statementData.ReferenceBank);
    		system.debug('ModifiedDate:' + statementData.ModifiedDate);
    		system.debug('Status:' + statementData.Status);
    		system.debug('StatusID:' + String.valueOf(statementData.StatusID));
    		system.debug('AuthorizationNumber:' + String.valueOf(statementData.AuthorizationNumber));
    		system.debug('BankId:' + String.valueOf(statementData.BankId));
    		system.debug('Bank:' + statementData.Bank);
    	
    	
	
   	Integer i=0;
	while (parser.nextToken() != null) {
		i++;
    	system.debug('i: ' + i + 'Current token: ' + parser.getCurrentToken());
	}
    return '';
    }
    */
    
    
    
    
    
}