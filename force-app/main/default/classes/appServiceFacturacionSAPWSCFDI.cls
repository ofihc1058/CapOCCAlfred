public with sharing class appServiceFacturacionSAPWSCFDI {
	private static String IVAP0 ='IVAP0';
	private static String IVAP16 = 'IVAP16';
	private static String XEX ='XEX';
	private  static String SPACE = ' ';
	public static String CFDYPAGO='CFDYPAGO';

@isTest (seeAllData=true)
static void myUnitTest() {
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
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
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
		account.Website='NA';
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
		opp.CloseDate = Date.today() + 20;
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='benjamin.zavala@live.com.mx';
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
		opp.NunOfertafisica_o__c='FACT00000000';
		opp.EstatusFactura__c='';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='ref-000001';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Abierta';
//		opp.StageName='Cierre';
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
		opp.EstatusFactura__c='Aprobada';
		update opp;
		//appServiceFacturacionSAPWSCFDI.Alive(null);
        appServiceFacturacionSAPWSCFDI.Alive(opp.Id);
        opp.Factura_Aprobada__c=true;
        update opp;
        fetchStatus(opp.Id);
        StatusFactura__c estatus=new StatusFactura__c();
        estatus.OpportunityId__c=opp.Id;
        estatus.Name=opp.Name;
        estatus.ExtendedStatus__c = '';
		estatus.C_digo__c = '';
		estatus.IDFactura__c = '-1';
		estatus.IDPago__c = '-1';
		estatus.IDPedido__c = '-1';
		insert estatus;	
		appServiceFacturacionSAPWSCFDI.Alive(opp.Id);
		StatusFactura__c fetch= fetchStatus(opp.Id);
		updateStatusFactura(opp.Id);
		calculateDefinicionImpuesto('AB');
		calculateDefinicionImpuesto('BEMN150101ADB');
		calculateDefinicionImpuesto('XEX01');
    }

	private static String calculateDefinicionImpuesto(String rfc){
		String toReturn ='';
		String first3Chars = '';
		if(rfc!=null){
			if(rfc.length()>3){
				first3Chars= rfc.toUpperCase().substring(0, 3);
				
				if(XEX.equals(first3Chars)){
					toReturn = IVAP0;
				}else{
					toReturn = IVAP16;
				}
			}
		}
		return toReturn;
	}

	@future (callout=true)
	public static void Alive(String id){
		wwwParnetComMxCFDI.ServiceSoap service = new wwwParnetComMxCFDI.ServiceSoap();
		String result = service.AliveWS();
		StatusFactura__c estatus = fetchStatus(id);
		Boolean doInsert = false;
		if(estatus==null){
			estatus= new StatusFactura__c();
			doInsert=true;
		}
		estatus.Estatus__c = result;
		if(doInsert==true){
			estatus.Name = id;
			estatus.OpportunityId__c = id;
			insert estatus;
		}else {
			update estatus; 
		}
	}
	
	public static void validateSAPID(String id){
		List<Account> accountList = [Select Clave_SAP__c,Id	 From Account  where  Id in (Select AccountId from Opportunity where Id =: id)];
		Account account = accountList[0];
	}
	public static String getAliasVentas(String id){
		List<User> ejecutivoList = [Select Alias from User where Id in (Select EjecutivoAsig_o__c From Opportunity  where  Id =: id)];
		String ejecutivoName='-1';
			
		if(ejecutivoList.size()!=0){
			User ejecutivo = ejecutivoList[0];
			ejecutivoName =ejecutivo.Alias; 
		}	
		try{
			Integer.valueOf(ejecutivoName);
		}catch(System.TypeException e){
			return '-1';
		}
		return ejecutivoName;
		
		
	}
	public static StatusFactura__c fetchStatus(String Id){
		List<StatusFactura__c> statusList = [Select OpportunityId__c, Name, Id, IDPedido__c, IDPago__c, 
		IDFactura__c, Estatus__c,C_digo__c,ExtendedStatus__c From StatusFactura__c s where OpportunityId__c  =: Id];
		StatusFactura__c toReturn = null;
		if(statusList.size()==0){
			toReturn = null;
		}else {
			toReturn = statusList[0];
		}	
		return toReturn;
	}
	
	public static void updateStatusFactura(String id){
		List<Opportunity> opportunityList = [Select NunOfertafisica_o__c,Id_pedido__c,Id,IdPago__c,codigo_error_SAP__c,
		Mensaje_error_de_SAP__c,Factura_Aprobada__c From Opportunity  where  Id =: id LIMIT 1];
		Opportunity factura = opportunityList[0];
		StatusFactura__c estatus = fetchStatus(id);
		system.debug('Actualiza oportunidad');
		if(estatus.C_digo__c=='0'){
			system.debug('Status de la oportunidad' + estatus.IDFactura__c);
			factura.NunOfertafisica_o__c = estatus.IDFactura__c;
			factura.Id_pedido__c = estatus.IDPedido__c;
			factura.IdPago__c  = estatus.IDPago__c;
			factura.codigo_error_SAP__c = estatus.C_digo__c;
			factura.errorFactura__c = false;
			factura.Mensaje_SAP__c=estatus.ExtendedStatus__c;
			
		}else{
			system.debug('Status de la oportunidad vacio');
			factura.NunOfertafisica_o__c = '';
			factura.Id_pedido__c = '';
			factura.IdPago__c  = '';
			factura.codigo_error_SAP__c = estatus.C_digo__c;
			factura.errorFactura__c = true;
			factura.Mensaje_SAP__c=estatus.ExtendedStatus__c;
			factura.Factura_Aprobada__c = false;
			
		}
		system.debug('Mando actualizacion');
		update factura;
		system.debug('Actualice oportunidad');
	}
	
	@future (callout=true)
	public static void generateSAPCFDIWS(String id,String statusCFD){
		system.debug('Entre a generar factura');
		StatusFactura__c estatus = fetchStatus(id);
		String idVentaPago = '';
		Boolean doInsert = false;
		if(estatus==null){
			estatus= new StatusFactura__c();
			doInsert=true;
		}
		String CreateWS=ConvertSFToSapJson( id, statusCFD );
		system.debug('ConvertSFToSapJson:' + CreateWS);
		if (!String.isBlank(CreateWS)){
			system.debug('Voy a mandar llamar VentaCFDI');
			ResponseWS response =   appServiceFacturacionSAPWSCFDI.VentaCFDI(CreateWS);
			system.debug('response VentaCFDI:'+ JSON.serialize(response));
			if(response.getStatus()=='0'){
					estatus.ExtendedStatus__c = response.getMessage();
					estatus.C_digo__c = response.getStatus();
					estatus.IDFactura__c = response.getFactura();
					estatus.IDPago__c = response.getPago();
					estatus.IDPedido__c = idVentaPago;
				}else{
					estatus.ExtendedStatus__c = response.getMessage();
					estatus.C_digo__c = response.getStatus();
					estatus.IDFactura__c ='-1';
					estatus.IDPago__c = '-1';
					estatus.IDPedido__c = '-1';
				}	
		}
		validateSAPID(id);
		system.debug('doInsert' + String.valueOf(doInsert));
		if(doInsert==true){
			estatus.Name = id;
			estatus.OpportunityId__c = id;
			insert estatus;
		}else {
			update estatus; 
		}
	}
	public static ResponseWS VentaCFDI(String  jsonEnvio){
		String codeError='';
		ResponseWS response = new ResponseWS();
		wwwParnetComMxCFDI.ServiceSoap service = new wwwParnetComMxCFDI.ServiceSoap();
		String resultWS = null;
		codeError = service.ReceiverJSON(jsonEnvio);
		system.debug('Resultado de codeError:'+codeError);
		response =Utils.parseResponse(codeError);
		return	response; 
	}	
	
	public static String ConvertSFToSapJson(String id, String statusCFD ){
		String resultJS='';
        boolean IsSustitution=false;
		OCCMClases.Sales sale=new OCCMClases.Sales();
		List<Opportunity> opportunityList = [Select Id,AccountId ,OwnerId, Name,E_mail_para_env_o_de_Factura_Elect_nica__c,
											 		FormaDePago_o__c,CurrencyIsoCode, FechaFactura_o__c, Comentarios__c,MembresaPagadaCon_o__c, 
											 		Referencia_Numerica_del__c,InicioVigencia_o__c,FinVigencia_o__c, Tipo_de_Facturacion__c,
													EstatusFactura__c,CreatedDate,TipoCambio_o__c, Importe_Descuento__c, 
													NumFact__c, Referencia_Bancaria__c,Orden_de_Compra__c,N_mero_de_Proveedor__c, Observaciones_SAP__c, Clasificaci_n_de_Factura__c,
													Banco__c, Importe__c, Referencia_Banc__c,NunOfertafisica_o__c,Estatus_de_pago__c,Fecha_de_Pago_Bancario__c,Concepto_de_Cobro__c, 
													FechaPago__c, Cambio_Datos_de_Facturaci_n__c, Clave_metodo_pago__c, N_mero_de_Cuenta_Pago__c, Folio_Oportunidad_sustituida__c, N_Contable_en_SAP_Sustituida__c, Sustituir_Datos__c
											 	From Opportunity  where  Id =: id LIMIT 1];
		Opportunity factura = opportunityList[0];
		List<Account> accountList = [Select Clave_SAP__c,RazonSoc_o__c,Id, Personamf__c,Name, Phone,Telefono2_o__c,Fax,
											RFC_o__c,Website,Cliente_SAE__c,PaisFact_o__c, No_de_interior__c, 
											No_de_Exterior__c, EstadoFact_o__c, DelegMunicFact_o__c, Colonia_de_Facturaci_n__c, 
											CodigoPostalFact_o__c, CiudadFact_opcional_o__c, CalleFact_o__c, Cuenta_Virtual_Banamex__c
										 From Account  where  Id =: factura.AccountId LIMIT 1];
										 
		Account account = accountList[0];
		if(account != null ) //!String.isNotBlank(account.Clave_SAP__c) && && !String.isNotBlank(factura.EstatusFactura__c) 
		{
			List<User> usersList = [SELECT Id, Name from User where  Id =: factura.OwnerId LIMIT 1];  
			User user  = usersList[0];
			String ejecutivoName=getAliasVentas(id);
			String comentarioVigencia = 'Vigencia del ' +Utils.formatDate(factura.InicioVigencia_o__c) + ' al '+Utils.formatDate(factura.FinVigencia_o__c);
			List<Contact> contactList = [Select Title, Phone, Name,OtherPhone ,MobilePhone, 
												Fax, Email,Id From Contact c where Id in(Select ContactId 
											From OpportunityContactRole o where  OpportunityId =:id and IsPrimary=true )];
			Contact contacto = null;
			if(contactList.size()!=0){
				contacto = contactList[0];
			}else{
				contacto = new Contact();
			}
			String actualizaContacto='';
			system.debug('account.Cambio_Datos_de_Facturaci_on__c: ' + factura.Cambio_Datos_de_Facturaci_n__c);
			if (factura.Cambio_Datos_de_Facturaci_n__c==false){actualizaContacto='False';}else{actualizaContacto='True';}
			sale.BusinessPartners= new OCCMClases.BusinessPartnersSap(account.Clave_SAP__c, account.RazonSoc_o__c,account.Phone, account.Telefono2_o__c, account.Fax,
							contacto.Name, calculateDefinicionImpuesto(account.RFC_o__c),  account.RFC_o__c, ejecutivoName, '', '', account.Name, Utils.TERRITORIOS.get(account.EstadoFact_o__c), 
							account.Website, account.Cliente_SAE__c, account.Id, contacto.Id, account.CalleFact_o__c, account.Colonia_de_Facturaci_n__c, 
							account.CodigoPostalFact_o__c, account.DelegMunicFact_o__c, Utils.getCountryCode(account.PaisFact_o__c), Utils.ESTADOS.get(account.EstadoFact_o__c), 
							account.No_de_Exterior__c, account.No_de_interior__c, contacto.Title, '', contacto.Phone, contacto.OtherPhone, 
							contacto.MobilePhone, contacto.Fax, contacto.Email);		
			sale.BusinessPartners.actualizaSN=actualizaContacto;		
			/*
			system.debug(' CodigoSN: ' + account.Clave_SAP__c +' NombreSN: ' + account.RazonSoc_o__c +' Telefono1: ' + account.Phone +' Telefono2: ' + account.Telefono2_o__c +' Fax: ' + account.Fax +
						' PersonaContacto: ' + contacto.Name +' DefinicionImpuesto: ' + calculateDefinicionImpuesto(account.RFC_o__c) +' RFC: ' + account.RFC_o__c +' EmpleadoVentas: ' + ejecutivoName +
						' TelefonoCelular: ' + '' +' CURP: ' + '' +' NombreExtranjero: ' + account.Name +' Territorio: ' +  Utils.TERRITORIOS.get(account.EstadoFact_o__c) +' WebSite: ' + account.Website +' IDSAE: ' + account.Cliente_SAE__c +
						' IDSalesForce: ' + account.Id +' IDContactoSalesForce: ' + contacto.Id +' Calle: ' + account.CalleFact_o__c +' Colonia: ' + account.Colonia_de_Facturaci_n__c +' CodigoPostal: ' + account.CodigoPostalFact_o__c +
						' Municipio: ' + account.DelegMunicFact_o__c +' Pais: ' + Utils.getCountryCode(account.PaisFact_o__c) +' Estado: ' + Utils.ESTADOS.get(account.EstadoFact_o__c) +' NoExterior: ' + account.No_de_Exterior__c +' NoInterior: ' + account.No_de_interior__c +
						' ContactoPuesto: ' + contacto.Title +' ContactoDireccion: ' + '' +' ContactoTelefono1: ' + contacto.Phone +' ContactoTelefono2: ' + contacto.OtherPhone +' ContactoCelular: ' + contacto.MobilePhone +
						' ContactoFax: ' + contacto.Fax +' ContactoEmail: ' + contacto.Email);
			system.debug('resultJSON:' + resultJS);*/

			List<OpportunityLineItem> opps = [SELECT UnitPrice, TotalPrice,Quantity,PricebookEntryId,Discount from OpportunityLineItem where  OpportunityId =: factura.id];
			List<OCCMClases.DocumentLineSap> documentLines=new List<OCCMClases.DocumentLineSap>();
			OCCMClases.DocumentLineSap documentLine;
			if(opps.size() > 0){
				for(OpportunityLineItem oppTemp : opps)
				{
					PricebookEntry priceBook = [SELECT ProductCode 
													FROM PricebookEntry 
													WHERE  Id =: oppTemp.PricebookEntryId
													LIMIT 1];
					String discount = '';
					if(oppTemp.Discount!=null){
						discount = oppTemp.Discount.toPlainString();
					}
					documentLine= new OCCMClases.DocumentLineSap(priceBook.ProductCode, oppTemp.Quantity.toPlainString(),oppTemp.UnitPrice.toPlainString(), discount);
					documentLines.add(documentLine);
				}
			}
            string TipoRelacion='';
            string UUIDRelacion = '';
            
            if (factura.Sustituir_Datos__c == true){
                TipoRelacion='04';
            	UUIDRelacion = factura.N_Contable_en_SAP_Sustituida__c;
            }
			sale.Documents = new OCCMClases.DocumentsSAP(Utils.formatDate(factura.FechaFactura_o__c), account.Clave_SAP__c, Utils.formatDate(factura.InicioVigencia_o__c),
							Utils.formatDate(factura.FinVigencia_o__c),comentarioVigencia,Utils.obtainFacturaType(factura.Tipo_de_Facturacion__c),Utils.obtainFacturaStatus(factura.EstatusFactura__c),
							factura.E_mail_para_env_o_de_Factura_Elect_nica__c,'0', Utils.formatHour(factura.CreatedDate),user.Name, '1', ejecutivoName, '','', 
							Utils.getCurrency(factura.CurrencyIsoCode), Utils.fixExchange(factura.TipoCambio_o__c+''),  
							factura.NumFact__c, factura.Referencia_Bancaria__c,Utils.getInvoiceType(factura.Tipo_de_Facturacion__c),factura.Orden_de_Compra__c,
							factura.N_mero_de_Proveedor__c,Utils.getInvoiceClassification(factura.Clasificaci_n_de_Factura__c),Utils.getInvoiceStatus(factura.EstatusFactura__c),factura.Observaciones_SAP__c,account.Cuenta_Virtual_Banamex__c
							,documentLines, Utils.formatDate(factura.FechaPago__c), Utils.getMetodoPagoSAT(factura.Clave_metodo_pago__c), factura.N_mero_de_Cuenta_Pago__c, TipoRelacion, UUIDRelacion);
			resultJS = JSON.serialize(sale);
			system.debug('resultJSON:' + resultJS);
			String importeFactura='';
			String fechaPagoBanco='';
			if (factura.Importe__c!=null)
			{
				importeFactura=factura.Importe__c.toPlainString();
			}
			if (factura.Fecha_de_Pago_Bancario__c!=null)
			{
				fechaPagoBanco=Utils.formatDate(factura.Fecha_de_Pago_Bancario__c);
			}
			sale.Payments=new OCCMClases.PaymentsSap(account.Clave_SAP__c,factura.Banco__c,importeFactura, factura.Referencia_Banc__c, 
							factura.NumFact__c,factura.Estatus_de_pago__c,fechaPagoBanco,factura.Concepto_de_Cobro__c, TipoRelacion, UUIDRelacion);
		   resultJS = JSON.serialize(sale);
		   system.debug('ConvertSFToSapJson:' + resultJS);
		}
		/*system.debug('salgo de datos');*/
		return resultJS; 
	}
	
}