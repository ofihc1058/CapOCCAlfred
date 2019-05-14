/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
//@isTest
@isTest(SeeAllData=true)
public class TestOpportunityLineItem {
	
	static testMethod void TestOpportunityLineItem() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		// Instantiate the Pricebook2 record first, setting the Id
        Pricebook2 standarPriceBook = new Pricebook2(Id = Test.getStandardPricebookId(), IsActive = true);        
        // Run an update DML on the Pricebook2 record
		// This is the weird workaround that enables IsStandard to become true
		// on the PricebookEntry record
		update standarPriceBook;
		// Re-Query for the Pricebook2 record, for debugging
		standarPriceBook = [SELECT IsStandard FROM Pricebook2 WHERE Id = :standarPriceBook.Id];

        /*Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1]; */
									
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001F';
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
        system.debug('product: ' + Json.serialize(product));

		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
		insert pbe;
		system.debug('pbe : ' + Json.serialize(pbe));
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		//ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
		insert pbe;
		system.debug('pbe1 : ' + Json.serialize(pbe));
		
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
						
		OpportunityLineItem oli= new OpportunityLineItem();
        system.debug('pbeol: ' + Json.serialize(priceBookEntry));
		for (PricebookEntry pe: priceBookEntry){
            system.debug('pbeolpe ' + Json.serialize(pe));
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
            oli.Quantity=2;
            update oli;
            delete oli;
		}
		product.Family='Empleolisto';
        update product;
        oli= new OpportunityLineItem();
        system.debug('pbeol: ' + Json.serialize(priceBookEntry));
		for (PricebookEntry pe: priceBookEntry){
            system.debug('pbeolpe ' + Json.serialize(pe));
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
            oli.Quantity=2;
            update oli;
            delete oli;
		}
        product.Family='OCCEjecutivo';
        update product;
        oli= new OpportunityLineItem();
        system.debug('pbeol: ' + Json.serialize(priceBookEntry));
		for (PricebookEntry pe: priceBookEntry){
            system.debug('pbeolpe ' + Json.serialize(pe));
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
            oli.Quantity=2;
            update oli;
            delete oli;
		}
        //lineItems = [SELECT Id, Quantity,UnitPrice FROM OpportunityLineItem WHERE OpportunityId=opp.id; Id = :standarPriceBook.Id];
		
	}
}