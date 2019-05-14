@isTest
private class appServicePaymentSAPWSTest {
     static testMethod void TestClass(){
     	test.startTest();
        appServicePaymentSAPWS.getFormaPago('Efectivo');
        appServicePaymentSAPWS.getFormaPago('Cheque nominativo');
        appServicePaymentSAPWS.getFormaPago('Transferencia electrónica de fondos');
        appServicePaymentSAPWS.getFormaPago('Tarjeta de crédito');
        appServicePaymentSAPWS.getFormaPago('Monedero electrónico');
        appServicePaymentSAPWS.getFormaPago('Dinero electrónico');
        appServicePaymentSAPWS.getFormaPago('Vales de despensa');
        appServicePaymentSAPWS.getFormaPago('Dación en pago');
        appServicePaymentSAPWS.getFormaPago('Pago por subrogación');
        appServicePaymentSAPWS.getFormaPago('Pago por consignación');
        appServicePaymentSAPWS.getFormaPago('Condonación');
        appServicePaymentSAPWS.getFormaPago('Compensación');
        appServicePaymentSAPWS.getFormaPago('Novación');
        appServicePaymentSAPWS.getFormaPago('Confusión');
        appServicePaymentSAPWS.getFormaPago('Remisión de deuda');
        appServicePaymentSAPWS.getFormaPago('Prescripción o caducidad');
        appServicePaymentSAPWS.getFormaPago('A satisfacción del acreedor');
        appServicePaymentSAPWS.getFormaPago('Tarjeta de débito');
        appServicePaymentSAPWS.getFormaPago('Tarjeta de servicios');
         appServicePaymentSAPWS.getFormaPago('Aplicación de anticipos');
         appServicePaymentSAPWS.getFormaPago('Intermediario pagos');
        appServicePaymentSAPWS.getFormaPago('Por definir');
         
        appServicePaymentSAPWS.getCuentaSap('AMBANORTE 6587');
        appServicePaymentSAPWS.getCuentaSap('AMEX 0509');
        appServicePaymentSAPWS.getCuentaSap('AMEX 5826');
        appServicePaymentSAPWS.getCuentaSap('AMEX 7637');
        appServicePaymentSAPWS.getCuentaSap('BANCOMER 1656');
        appServicePaymentSAPWS.getCuentaSap('BANORTE 3598');
        appServicePaymentSAPWS.getCuentaSap('BANORTE 3883');
        appServicePaymentSAPWS.getCuentaSap('BANORTE 8091');
        appServicePaymentSAPWS.getCuentaSap('BANAMEX 6835');
        appServicePaymentSAPWS.getCuentaSap('BANAMEX 8780');
        appServicePaymentSAPWS.getCuentaSap('BANAMEX 1965');
        appServicePaymentSAPWS.getCuentaSap('CCBANAMEX 7067');
        appServicePaymentSAPWS.getCuentaSap('CUENTA PUENTE DIF PAGOS RECIBIDOS');
        appServicePaymentSAPWS.getCuentaSap('PAYUBANAMEX 1965');
        appServicePaymentSAPWS.getCuentaSap('PYBANORTE 5010');
        appServicePaymentSAPWS.getCuentaSap('PAYUBMXNGB1965');
        appServicePaymentSAPWS.getCuentaSap('PAYUBMXEDU1965');
        appServicePaymentSAPWS.getCuentaSap('AMEXEDU7637');
        appServicePaymentSAPWS.getCuentaSap('');
        appServicePaymentSAPWS.getCuentaSap(null);
        
        Map<String, String> parameters = new Map<String, String>();
        String result= appServicePaymentSAPWS.ParametersErrors(parameters);
        system.debug(result);
        
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
        account.Clave_SAP__c='TST000000';
        account.RazonSoc_o__c='razon social';
        account.Personamf__c='a';
        account.Telefono2_o__c = '1234567890';
        account.Fax = '1234567890';
        account.Cliente_SAE__c= '';    
		insert account;
        system.debug('accountId: ' + account.Id);
		
        Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='100000';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='bzavala@testmaper.com';
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
        insert opp;
        system.debug('OpportunityID: ' + opp.Id);
        
        system.debug('new OpportunityID: ' + opp.Id);
        parameters=appServicePaymentSAPWS.GetParameters(opp.Id);
        appServicePaymentSAPWS.DisplayParameters(parameters);
        OCCMClases.SapPaymentResult wsResult= new OCCMClases.SapPaymentResult();
		wsResult.success=true;
    	wsResult.error='';
    	wsResult.DocList =new List<String>(); 
		
        appServicePaymentSAPWS.UpdateMensajePagoSap(opp.Id, wsResult);
        //appServicePaymentSAPWS.paymentSAPWS('1sw233454ssf');
        
        string resultSapPayment='{' + 
            			'"success":true,' +
            			'"error":"",' +
            			'"doclist":[' +
            			'	"273952",' +
            			'	"273953"' +
            			']' +
            			'}';
       appServicePaymentSAPWS.ConvertWsResponse(resultSapPayment);
       
       //opp.Factura_cobrada__c=true;
       //update opp;
        
       appServicePaymentSAPWS.paymentSAPWS(opp.Id);
    }
}