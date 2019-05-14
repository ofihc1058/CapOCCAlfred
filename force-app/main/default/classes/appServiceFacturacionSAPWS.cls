public  class appServiceFacturacionSAPWS {


	private static String IVAP0 ='IVAP0';
	private static String IVAP16 = 'IVAP16';
	private static String XEX ='XEX';
	private  static String SPACE = ' ';
	public static String CFDYPAGO='CFDYPAGO';


 static testMethod void myUnitTest() {
    	String id='0065000000An8Q5AAJ';
    	String idVentaPago='';
        Opportunity opp = new Opportunity(Id=id);   
        appServiceFacturacionSAPWS.Venta(id, idVentaPago);		
        appServiceFacturacionSAPWS.VentaPago(id,CFDYPAGO); 
        appServiceFacturacionSAPWS.Alive(id);
        appServiceFacturacionSAPWS.generateSAPCFD(id,CFDYPAGO);         
    }

	public  static ResponseWS  CreaSocioNegocio(String id ){
		String codeError='';
		ResponseWS response = new ResponseWS();
		String resultWS = null;
		Contact contact = null;
		
		List<Opportunity> opportunityList = [Select Id,AccountId ,OwnerId, Name,E_mail_para_env_o_de_Factura_Elect_nica__c,
											 FormaDePago_o__c,CurrencyIsoCode From Opportunity  where  Id =: id LIMIT 1];
		
		Opportunity factura = opportunityList[0];
		wwwParnetComMx.ServiceSoap service = new wwwParnetComMx.ServiceSoap();
		
		List<Account> accountList = [Select Clave_SAP__c,RazonSoc_o__c,Id, Personamf__c,Name, Phone,Telefono2_o__c,Fax,
										RFC_o__c,Website,Cliente_SAE__c,PaisFact_o__c, No_de_interior__c, 
										No_de_Exterior__c, EstadoFact_o__c, DelegMunicFact_o__c, Colonia_de_Facturaci_n__c, 
										CodigoPostalFact_o__c, CiudadFact_opcional_o__c, CalleFact_o__c 
										 From Account  where  Id =: factura.AccountId LIMIT 1];
		Account account = accountList[0];

		if(account != null){
			
			List<User> usersList = [SELECT Id, Name from User where  Id =: factura.OwnerId LIMIT 1];  
			User user  = usersList[0];
			
			String ejecutivoName=getAliasVentas(id);
			
			
			List<Contact> contactList = [Select Title, Phone, Name,OtherPhone ,MobilePhone, 
										Fax, Email,Id From Contact c where Id in(Select ContactId 
										From OpportunityContactRole o where  OpportunityId =:id and IsPrimary=true )];
			Contact contacto = null;
			if(contactList.size()!=0){
				contacto = contactList[0];
			}else{
				contacto = new Contact();
			}
			
			//if(account.Clave_SAP__c==null||account.Clave_SAP__c==''){
					//account.Clave_SAP__c = appServiceFacturacionSAPWS.getNextSAPId();		
			//}
			
			
			codeError = service.CreaSocioNegocioWS(account.Clave_SAP__c, account.RazonSoc_o__c,account.Phone, account.Telefono2_o__c, account.Fax,
			contacto.Name, calculateDefinicionImpuesto(account.RFC_o__c),  account.RFC_o__c, ejecutivoName, '', '', account.Name, '1', 
			account.Website, account.Cliente_SAE__c, account.Id, contacto.Id, account.CalleFact_o__c, account.Colonia_de_Facturaci_n__c, 
			account.CodigoPostalFact_o__c, account.DelegMunicFact_o__c, account.PaisFact_o__c, account.EstadoFact_o__c, 
			account.No_de_Exterior__c, account.No_de_interior__c, contacto.Title, '', contacto.Phone, contacto.OtherPhone, 
			contacto.MobilePhone, contacto.Fax, contacto.Email);
			
			
			
		}
					response =Utils.parseResponse(codeError);

		return	response; 
	}

	public static ResponseWS VentaPago(String id,String statusCFD ){
		String codeError='';
		ResponseWS response = new ResponseWS();
		List<Opportunity> opportunityList = [Select AccountId,FechaFactura_o__c, Comentarios__c,
											MembresaPagadaCon_o__c, Referencia_Numerica_del__c,InicioVigencia_o__c,
											FinVigencia_o__c, Tipo_de_Facturacion__c,E_mail_para_env_o_de_Factura_Elect_nica__c,
											EstatusFactura__c,CreatedDate,CurrencyIsoCode,TipoCambio_o__c	
		 									From Opportunity  where  Id =: id LIMIT 1];
		
		Opportunity factura = opportunityList[0];
		wwwParnetComMx.ServiceSoap service = new wwwParnetComMx.ServiceSoap();

		List<Account> accountList = [Select Name,RFC_o__c,Id,Clave_SAP__c From Account  where  Id =: factura.AccountId LIMIT 1];
		Account account = accountList[0];

			//if(account.Clave_SAP__c==null||account.Clave_SAP__c==''){
					//account.Clave_SAP__c = appServiceFacturacionSAPWS.getNextSAPId();		
			//}
			
		List <User> usersList =[Select Name from User where Id in(select OwnerId from Opportunity where Id =: id)];
		User owner = usersList[0];
		
		String ejecutivoName=getAliasVentas(id);
		
		String comentarioVigencia = 'Vigencia del ' +Utils.formatDate(factura.InicioVigencia_o__c) + ' al '+Utils.formatDate(factura.FinVigencia_o__c);
		String resultWS = null;
		
		if(account!=null){
			if(CFDYPAGO==statusCFD){
			codeError = service.VentaPagoWS(account.Clave_SAP__c, Utils.formatDate(factura.FechaFactura_o__c), '', factura.MembresaPagadaCon_o__c,  
			factura.Referencia_Numerica_del__c,  Utils.formatDate(factura.InicioVigencia_o__c), Utils.formatDate(factura.FinVigencia_o__c),
			comentarioVigencia,  '0', '0', 
			 factura.E_mail_para_env_o_de_Factura_Elect_nica__c, Utils.formatHour(factura.CreatedDate), owner.Name, ejecutivoName, 
			 '', Utils.getCurrency(factura.CurrencyIsoCode), Utils.fixExchange(factura.TipoCambio_o__c+''));
			}else{
			codeError = service.VentaPagoWS(account.Clave_SAP__c, Utils.formatDate(factura.FechaFactura_o__c), '', '',  
			'',  Utils.formatDate(factura.InicioVigencia_o__c), Utils.formatDate(factura.FinVigencia_o__c),
			comentarioVigencia,  Utils.obtainFacturaType(factura.Tipo_de_Facturacion__c), Utils.obtainFacturaStatus(factura.EstatusFactura__c), 
			 factura.E_mail_para_env_o_de_Factura_Elect_nica__c, Utils.formatHour(factura.CreatedDate), owner.Name, ejecutivoName, 
			 '', Utils.getCurrency(factura.CurrencyIsoCode), Utils.fixExchange(factura.TipoCambio_o__c+''));
			}	 
		}
		response =Utils.parseResponse(codeError);
		return	response; 
	}	
	
		
	
	public static ResponseWS PagoWS(String id){
		
		String codeError='';
		ResponseWS response = new ResponseWS();
		List<Opportunity> opportunityList = [Select AccountId,FechaFactura_o__c, NunOfertafisica_o__c,
											MembresaPagadaCon_o__c, Referencia_Numerica_del__c
		 									From Opportunity  where  Id =: id LIMIT 1];
		Opportunity factura = opportunityList[0];
		wwwParnetComMx.ServiceSoap service = new wwwParnetComMx.ServiceSoap();
		String resultWS = null;
		if(factura!=null){
			codeError = service.VentaPagoWS('', Utils.formatDate(factura.FechaFactura_o__c), factura.NunOfertafisica_o__c, factura.MembresaPagadaCon_o__c,  
			factura.Referencia_Numerica_del__c,  '','',
			'',  '', '', 
			 '','', '', '', 
			 '', '','');	 		
		}
		response =Utils.parseResponse(codeError);
		return	response; 
	}
	
	public static ResponseWS Venta(String id,String idVentaPago){
		String codeError='';
		Integer i=0;
		List<Opportunity> opportunityList = [Select Importe_Descuento__c,Id
		 									From Opportunity  where  Id =: id LIMIT 1];
		 									
		Opportunity factura = opportunityList[0];
		
		wwwParnetComMx.ServiceSoap service = new wwwParnetComMx.ServiceSoap();
		ResponseWS response = new ResponseWS();
		
		String resultWS = null;

		PricebookEntry pricebook = null;
		String constantCerrar= 'N';
		List<OpportunityLineItem> opps = [SELECT UnitPrice, TotalPrice,Quantity,PricebookEntryId,Discount from OpportunityLineItem where  OpportunityId =: factura.id];
		if(opps.size() > 0){
			
			if(opps.size()==1){
					constantCerrar= 'S';
			}	
			
			for( i=0;i<opps.size();i++){	
				List<PricebookEntry> priceBooks = [SELECT ProductCode from PricebookEntry where  Id =: opps[i].PricebookEntryId];
				String discount = '';
				if(opps[i].Discount!=null){
					discount = opps[i].Discount.toPlainString();
				}
				pricebook = priceBooks[0];
				OpportunityLineItem opp = null;
				if(i==(opps.size()-1)){
					constantCerrar= 'S';
				}
				
			
				codeError = service.VentaWS(idVentaPago, pricebook.ProductCode, opps[i].Quantity.toPlainString(), 
				opps[i].UnitPrice.toPlainString(), discount, constantCerrar);
	
			}			
			
			
			
		}
		
		response =Utils.parseResponse(codeError);
		return response;
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

	public static string getNextSAPId(){
		
		String toReturn ='';
		String id;
		String newID;
		List<AggregateResult> accountList = [Select MAX(Clave_SAP__c) From Account WHERE Clave_SAP__c   LIKE 'CL%'];
		AggregateResult result = accountList[0];
		id = String.valueOf(result.get('expr0'));
		toReturn = id.substring(2);
		
		newID = ''+ (Integer.valueOf(toReturn)+1);				
		
		if(newID.length()!=id.length()-2){
			for(Integer i=newID.length();i<id.length()-2;i++){
				newID = '0'+newID;
			}
		}
		
		return 'CL'+newID;
		
				
	}
	@future (callout=true)
	public static void Alive(String id){
		wwwParnetComMx.ServiceSoap service = new wwwParnetComMx.ServiceSoap();
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
	
	@future (callout=true)
	public static void generateSAPCFD(String id,String statusCFD){
		
		StatusFactura__c estatus = fetchStatus(id);
		String idVentaPago = '';
		Boolean doInsert = false;
		if(estatus==null){
			estatus= new StatusFactura__c();
			doInsert=true;
		}
		ResponseWS response =   appServiceFacturacionSAPWS.CreaSocioNegocio(id);
		if(response.getStatus()=='0'){
			if(statusCFD==CFDYPAGO){
			response = appServiceFacturacionSAPWS.VentaPago(id,statusCFD);
			}else{
				response = appServiceFacturacionSAPWS.VentaPago(id,'');
			}
			if(response.getStatus()=='0'){
				idVentaPago =Utils.parseIdVentaPago(response.getMessage());
				response = appServiceFacturacionSAPWS.Venta(id,idVentaPago);
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
			}else{
				estatus.ExtendedStatus__c = response.getMessage();
				estatus.C_digo__c = response.getStatus();
				estatus.IDFactura__c ='-1';
				estatus.IDPago__c = '-1';
				estatus.IDPedido__c = '-1';

			}		
		}else{
			estatus.ExtendedStatus__c = response.getMessage();
			estatus.C_digo__c = response.getStatus();
			estatus.IDFactura__c ='-1';
			estatus.IDPago__c = '-1';
			estatus.IDPedido__c = '-1';
		}
		
		validateSAPID(id);
		if(doInsert==true){
			estatus.Name = id;
			estatus.OpportunityId__c = id;
			insert estatus;
		}else {
			update estatus; 
		}	
	}
	
	
	
		@future (callout=true)
	public static void generateSAPPago(String id){
		
		StatusFactura__c estatus = fetchStatus(id);
		Boolean doInsert = false;
		if(estatus==null){
			estatus= new StatusFactura__c();
			doInsert=true;
		}
		ResponseWS response =   appServiceFacturacionSAPWS.PagoWS(id);
		if(response.getStatus()=='0'){
					estatus.ExtendedStatus__c = response.getMessage();
					estatus.C_digo__c = response.getStatus();
					//estatus.IDFactura__c = response.getFactura();
					estatus.IDPago__c = response.getPago();	
					
		}else{
				estatus.ExtendedStatus__c = response.getMessage();
				estatus.C_digo__c = response.getStatus();
				estatus.IDFactura__c ='-1';
				estatus.IDPago__c = '-1';
				estatus.IDPedido__c = '-1';

		}		
		
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
		
			//if(account.Clave_SAP__c==null||account.Clave_SAP__c==''){
					//account.Clave_SAP__c = appServiceFacturacionSAPWS.getNextSAPId();		
					//update account;
			//}
			
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
		
		if(estatus.C_digo__c=='0'){
			factura.NunOfertafisica_o__c = estatus.IDFactura__c;
			factura.Id_pedido__c = estatus.IDPedido__c;
			factura.IdPago__c  = estatus.IDPago__c;
			factura.codigo_error_SAP__c = estatus.C_digo__c;
			factura.errorFactura__c = false;
			factura.Mensaje_SAP__c=estatus.ExtendedStatus__c;
			
		}else{
			factura.NunOfertafisica_o__c = '';
			factura.Id_pedido__c = '';
			factura.IdPago__c  = '';
			factura.codigo_error_SAP__c = estatus.C_digo__c;
			factura.errorFactura__c = true;
			
			factura.Mensaje_SAP__c=estatus.ExtendedStatus__c;
			factura.Factura_Aprobada__c = false;
			
		}
		
		
		update factura;
	}
	

}