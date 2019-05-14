@isTest
public class WSSalesforceReclutaTest {

    static testMethod void TestClass(){  
        test.startTest(); 
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
        String insertarCIE = WSSalesforceRecluta.InsertCieValue(opp.Id, '000064550');
        insertarCIE = WSSalesforceRecluta.InsertCieValue('000064550', '000064550');
        insertarCIE = WSSalesforceRecluta.InsertCieValue('', '');
        insertarCIE = WSSalesforceRecluta.InsertCieValue(null, null);
	
		WSSalesforceRecluta.IsNewBusinessModelAccount(accountTest.Id);
		WSSalesforceRecluta.MigrateAccount(accountTest.Id, 'Newmodel', 'cuenta@cuenta.com');
		WSSalesforceRecluta.SendAccountToOccm(accountTest.Id);
		
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
		WSSalesforceRecluta.UpdateLeadInvoiceInformation(accs);
		
		
		String pideWs= WSSalesforceRecluta.WSGenerateGeneralTask(userInfo.Id, 'Pruebas ', 'Probando todo');
		test.stopTest(); 
    }
    
    
    
    
    @isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnlyNew() {
        test.startTest(); 
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
			
		String insertarCIE = WSSalesforceRecluta.InsertCieValue(opp.Id, '000064550');
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

			
		String UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		
		String UpdatePaymentOpportunityStatusComplete= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementStringS= JSON.serialize(statementString);
		UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		
		//UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		UpdatePaymentOpportunityStatusComplete= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
		String SenttoOccm= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
		String SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		//SendProductsToOccmMethod
		
		//SendProductsToOccmMethod
		
		opp.Tipo_de_vigencia__c='Manual';
		opp.EstatusFactura__c='En transito';
		opp.Tipo_de_Facturacion__c='Credito';
		update opp;
		
		String UpdatePaymentOpportunityStatuseerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
		
		String UpdatePaymentOpportunityStatuseCompleteerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeCompleteerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		opp.FinVigencia_o__c=null;
		update opp;
		account.Cuenta_Virtual_Banamex__c=null;
		account.OCCM_Cuenta_Administradora__c = null;
		update account;
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		update account;
		opp.FinVigencia_o__c=date.today();
		update opp;
        test.stopTest(); 
    }
	@isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnly() {
        test.startTest(); 
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
			
		String insertarCIE = WSSalesforceRecluta.InsertCieValue(opp.Id, '000064550');
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
		String UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		
		//String UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		String UpdatePaymentOpportunityStatusComplete= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		statementString.VirtualAccountIdCompany = account.Cuenta_Virtual_Banamex__c;
		statementStringS= JSON.serialize(statementString);
		//UpdatePaymentOpportunityStatusErr= UpdatePaymentOpportunityStatus('SinValor');
		UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		
		//UpdatePaymentOpportunityStatusCompleteErr= UpdatePaymentOpportunityStatusComplete('SinValor');
		UpdatePaymentOpportunityStatusComplete= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
		String SenttoOccm= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
		String SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		//SendProductsToOccmMethod
		
		//SendProductsToOccmMethod
		
		opp.Tipo_de_vigencia__c='Manual';
		opp.EstatusFactura__c='En transito';
		opp.Tipo_de_Facturacion__c='Credito';
		update opp;
		
		String UpdatePaymentOpportunityStatuseerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
		
		String UpdatePaymentOpportunityStatuseCompleteerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		String UpdatePaymentOpportunityStatusFacturaAproeCompleteerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusComplete(statementStringS);
		
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		opp.FinVigencia_o__c=null;
		update opp;
		account.Cuenta_Virtual_Banamex__c=null;
		account.OCCM_Cuenta_Administradora__c = null;
		update account;
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
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
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		test.stopTest(); 
    }
	@isTest (seeAllData=true)
	static void TestPaymentOpportunitynsertCIE() {
        test.startTest(); 
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
		String insertarCIE = WSSalesforceRecluta.InsertCieValue(opp.Id, '000064550');
		test.stopTest(); 
	}
	
	@isTest (seeAllData=true)
	static void TestAutorizationOpportunity() {
        test.startTest(); 
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
		//String insertarCIE = WSSalesforceRecluta.InsertCieValue(opp.Id, opp.NumFact__c.substring(6, opp.NumFact__c.length()));
		test.stopTest(); 
	}
	
	
	static testMethod void TestSendsIsNewBusinessModelAccountRequest() {
        test.startTest(); 
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
		String createOccmAccountMethod= WSSalesforceRecluta.CreateOccmAccountMethod(account.Id);
		
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
		OCCMClases.PersonalData getRegisteredAccount1 = WSSalesforceRecluta.GetRegisteredAccount(personalDataInfo);
			
			
		//SendsIsNewBusinessModelAccountRequest(String inputAccountId)
		//
		test.stopTest();  
	}
	
    
    @isTest (seeAllData=true)
	static void TestPaymentOpportunityStatusOnlyMissingAccount() {
        test.startTest();
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
		String SenttoOccm= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
		String SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		
		//Se manda error en la oportunidad sin cuenta asignada
		opp.AccountId =	null;
		update opp;
		SenttoOccm= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
		SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
		opp.AccountId =	account.Id;
		update opp;
		test.stopTest();  
	}
	static testMethod void TestLeadQuote() {
        test.startTest(); 
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
		
		OCCMClases.ExecutionResult getLeadDataUsingLeadId = WSSalesforceRecluta.GetLeadDataUsingLeadId(null);
		String sendLeadToOccm = WSSalesforceRecluta.SendLeadToOccm(null);
		String wsIsregisteresCompany = WSSalesforceRecluta.WSIsRegisteredCompany(null);
		String wsRegisterLead = WSSalesforceRecluta.WSRegisterLead(null);

		String personalDataInfoJSON = JSON.serialize(personalDataInfo);
		String personalDataInfoJSONList = '[' + personalDataInfoJSON + ']';
		String sendLeadToOccm1 = WSSalesforceRecluta.SendLeadToOccm(lead.Id);
		OCCMClases.ExecutionResult getLeadDataUsingLeadId1 = WSSalesforceRecluta.GetLeadDataUsingLeadId(lead.Id);
		OCCMClases.ExecutionResult getLeadDataUsingLeadId2 = WSSalesforceRecluta.GetLeadDataUsingLeadId(null);
		String wsIsregisteresCompany1 = WSSalesforceRecluta.WSIsRegisteredCompany(lead.Id);
		OCCMClases.ExecutionResult isRegisteredCompanymethod = WSSalesforceRecluta.IsRegisteredCompanymethod(personalDataInfo,false);
		OCCMClases.ExecutionResult isRegisteredCompanymethod1 = WSSalesforceRecluta.IsRegisteredCompanymethod(personalDataInfo,true);
		OCCMClases.ExecutionResult isRegisteredCompanymethod2 = WSSalesforceRecluta.IsRegisteredCompanymethod(null,false);
		
		String wsIsRegisteredCompany= WSSalesforceRecluta.WSIsRegisteredCompany(personalDataInfoJSON);
		String wsRegisterLead1 = WSSalesforceRecluta.WSRegisterLead(lead.Id);
		wsIsRegisteredCompany= WSSalesforceRecluta.WSIsRegisteredCompany(personalDataInfoJSONList);
		
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
			String updateSalesforceLeadAccount = WSSalesforceRecluta.UpdateSalesforceIdLeadAccount(lead.Id,account.Id);
			String  wsRegisterLeada = WSSalesforceRecluta.WSRegisterLead(personalDataInfoJSONList); 
			String  wsRegisterLeada1 = WSSalesforceRecluta.WSRegisterLead(personalDataInfoJSON);
			String  wsRegisterLeada2 = WSSalesforceRecluta.WSRegisterLead(null);
			
			OCCMClases.ExecutionResult  registerLeadMethoda2 = WSSalesforceRecluta.RegisterLeadMethod(personalDataInfo);
			OCCMClases.ExecutionResult  registerLeadMethoda3 = WSSalesforceRecluta.RegisterLeadMethod(null);			
			//String  generaTareasRegisterCompany = GeneraTareasRegisterCompany();
			Map<Boolean,String> GenerarTarea= WSSalesforceRecluta.GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', 'No existe', 'Atención a Clientes');
			Map<Boolean,String> GenerarTarea1= WSSalesforceRecluta.GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', '', 'Atención a Clientes');
			//Map<Boolean,String> GenerarTarea2=GeneraTareasPreviousRegisteredCompany('Existencia de prospecto', null, 'Atención a Clientes');
			
			OCCMClases.ExecutionResult result= new OCCMClases.ExecutionResult(true, 'Resultado satisfactorio', personalDataInfo);
			Map<Boolean,String> GenerarTarea3= WSSalesforceRecluta.GeneraTareasRegisterCompany(result, 'Sin existencia previa', 'Atención a Clientes');
			Map<Boolean,String> GenerarTarea4= WSSalesforceRecluta.GeneraTareasRegisterCompany(result, '', 'Atención a Clientes');
			//Map<Boolean,String> GenerarTarea5=GeneraTareasRegisterCompany(result, null, 'Atención a Clientes');
			
			personalDataInfo.FechaMigracionPaquetes='2013-01-01';
			PersonalDataInfo.WebPage='www.aplica.com';
			OCCMClases.ExecutionResult  registerLeadMethodaErroresRegistros = WSSalesforceRecluta.RegisterLeadMethod(personalDataInfo);
        test.stopTest();  
	}
	@isTest (seeAllData=true)
	static void TestOpportunityQuote() {
        test.startTest(); 
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
			String clpsinqlierr= WSSalesforceRecluta.CompleteListProductsInQuote('A00000000000');
			String clpsinqliMerr= WSSalesforceRecluta.CompleteListProductsInQuoteMethod('A00000000000');
			//Se manda llamar sin productos para que genere execpcion el codigo y validar la parte de errores
			String SenttoOccmErr1= WSSalesforceRecluta.SendProductsToOccm(null);
			String SenttoOccmErr= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
			
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
			String clpsinqlierr1= WSSalesforceRecluta.CompleteListProductsInQuote(quote.Id);
			String clpsinqliMerr1= WSSalesforceRecluta.CompleteListProductsInQuoteMethod(quote.Id);
			
			
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
			String clpsinqli= WSSalesforceRecluta.CompleteListProductsInQuote(quote.Id);
			String clpsinqliM= WSSalesforceRecluta.CompleteListProductsInQuoteMethod(quote.Id);

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
			String SenttoOccmErr2= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
			
			opp.SyncedQuoteId = quote.Id;
			
			update opp;
			
			String SenttoOccmErr3= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
			
			account.Cuenta_Virtual_Banamex__c='BAN000011';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			account.OCCM_Password_Cuenta_Administradora__c='Hola';
			update account;
			
			String SenttoOccmErr4= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
			
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
			String SenttoOccm= WSSalesforceRecluta.SendProductsToOccm(opp.Id);
			
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
			String UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			String UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.FinVigencia_o__c = null;
			opp.Tipo_de_vigencia__c='Manual';
			update opp;
			
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.FinVigencia_o__c = Date.today();
			opp.Tipo_de_vigencia__c='Automática';
			update opp;
			
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			
			opp.Tipo_de_Facturacion__c='Credito';
			update opp;
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			String SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='Online';
			
			update opp;
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='No Credito (factura previa)';
			update opp;
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='No Credito';
			update opp;
			UpdatePaymentOpportunityStatus=WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
			
			opp.Tipo_de_Facturacion__c='MacroCreditoCor';
			update opp;
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			SenttoOccmM= WSSalesforceRecluta.SendProductsToOccmMethod(opp.Id);
			
			account.OCCM_Password_Cuenta_Administradora__c = 'password';
			account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
			update account;
			
			UpdatePaymentOpportunityStatus= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringS);
			UpdatePaymentOpportunityStatusFacturaApro= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringS);
			
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
			String UpdatePaymentOpportunityStatusOK= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringSerb);
			String UpdatePaymentOpportunityStatusFacturaAproOK= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringSerb);
			
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
			String UpdatePaymentOpportunityStatuseerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusFacturaAproeerr= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringSer);
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
			String UpdatePaymentOpportunityStatusFacturaErrr1= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringSer);
			
			String UpdatePaymentOpportunityStatus1= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusError5= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringSer);
			statementString.ReferenceBank='REFQUENOEXISTE';
			statementStringSer= JSON.serialize(statementString);
			String UpdatePaymentOpportunityStatus2= WSSalesforceRecluta.UpdatePaymentOpportunityStatus(statementStringSer);
			String UpdatePaymentOpportunityStatusError6= WSSalesforceRecluta.UpdatePaymentOpportunityStatusMethod(statementStringSer);
			
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
			String BorrarProductosOpportunidad = WSSalesforceRecluta.DeleteListProductsInOpportunity(quote.Id);
			BorrarProductosOpportunidad =WSSalesforceRecluta.DeleteListProductsInOpportunity('A00000000000');
			String clpdeleerr1= WSSalesforceRecluta.DeleteListProductsInQuote(quote.Id);
			String clpdeleerr= WSSalesforceRecluta.DeleteListProductsInQuote('A00000000000');
			
			String clpdele=WSSalesforceRecluta.DeleteListProductsInQuote(quote.Id);
			String clpsinqliMComplete= WSSalesforceRecluta.CompleteListProductsInQuoteMethod(quote.Id);
      	test.stopTest(); 
    }
	
    static testMethod void TestGetContractedPackages() {
        test.startTest(); 
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
        
        OCCMClases.ExecutionResult execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('', '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'C', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'test@occ.com.mx');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'correofake');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(null, 'C', 'correofake');
        test.stopTest();  
	}
	static testMethod void TestMigrateAccount() {
        test.startTest(); 
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
        OCCMClases.ExecutionResult execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('', '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, '', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'M', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId('sd2585l76fdkj', 'C', '');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'test@occ.com.mx');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(accountTest.Id, 'C', 'correofake');
        execRes= WSSalesforceRecluta.GetAccountSummaryUsingAccountId(null, 'C', 'correofake');
        test.stopTest();  
	}
}