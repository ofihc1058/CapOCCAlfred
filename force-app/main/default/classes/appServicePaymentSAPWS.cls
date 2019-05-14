public with sharing class appServicePaymentSAPWS {
	
	public static Map<string,string> MetodoPagos = new Map<string,string>{
    	'Efectivo'									=> '01',
    	'Cheque nominativo'							=> '02',
    	'Transferencia electrónica de fondos'		=> '03',
    	'Tarjeta de crédito'						=> '04',
    	'Monedero electrónico'						=> '05',
    	'Dinero electrónico'						=> '06',
    	'Vales de despensa'							=> '08',
    	'Dación en pago'							=> '12',
    	'Pago por subrogación'						=> '13',
    	'Pago por consignación'						=> '14',
    	'Condonación'								=> '15',
    	'Compensación'								=> '17',
    	'Novación'									=> '23',
    	'Confusión'									=> '24',
    	'Remisión de deuda'							=> '25',
    	'Prescripción o caducidad'					=> '26',
    	'A satisfacción del acreedor'				=> '27',
    	'Tarjeta de débito'							=> '28',
    	'Tarjeta de servicios'						=> '29',
        'Aplicación de anticipos'					=> '30',
        'Intermediario pagos'						=> '31',
    	'Por definir'								=> '99'
        }; 
        
        
        
    public static Map<string,string> CuentasSap = new Map<string,string>{
    	'AMBANORTE 6587'                    => '_SYS00000002982',
        'AMEX 0509'                         => '_SYS00000002154',
        'AMEX 5826'                         => '_SYS00000002153',
        'AMEX 7637'                         => '_SYS00000002984',
        'BANCOMER 1656'                     => '_SYS00000002938',
        'BANORTE 3598'                      => '_SYS00000002935',       
        'BANORTE 3883'                      => '_SYS00000000012',
        'BANORTE 8091'                      => '_SYS00000002586',
        'BANAMEX 6835'                      => '_SYS00000002683',
        'BANAMEX 8780'                      => '_SYS00000003304',
        'BANAMEX 1965'		                => '_SYS00000002981',
        'CCBANAMEX 7067'                    => '_SYS00000003004',
        'CUENTA PUENTE DIF PAGOS RECIBIDOS' => '_SYS00000002422',
        'PAYUBANAMEX 1965'	                => '_SYS00000002155',
        'PYBANORTE 5010'                    => '_SYS00000002966',
        'PAYUBMXNGB1965' 					=> '_SYS00000025875',
        'PAYUBMXEDU1965'					=> '_SYS00000025876',
        'AMEXEDU7637'						=> '_SYS00000002984'
        }; 
          
    @future (callout=true)
    public static void paymentSAPWS(String oppId){
    	system.debug('Entrando a PaymentSap');
        Map<String, String> parameters = new Map<String, String>();
        OCCMClases.SapPaymentResult result= new OCCMClases.SapPaymentResult();        
		try{
		parameters=GetParameters(oppId);
    	if (parameters!=null){
    		system.debug('Tiene parametros Id: ' +  parameters.get('oppId'));
    		if (String.isBlank(ParametersErrors(parameters))){
    			DisplayParameters(parameters);
    			WSPaymentSap.DemoSoap ws= new WSPaymentSap.DemoSoap();
                ws.timeout_x = 30000; // timeout in milliseconds
    			if (!Test.isRunningTest())
				{
                	system.debug('WS: cardcode: ' +  parameters.get('cardcode') + ', cuenta: ' + parameters.get('cuenta') + ', monto: ' + double.valueOf(parameters.get('monto'))+ ', referencia: ' + parameters.get('referencia') + ', docnumfactura: ' + parameters.get('docnumfactura') + ', paymentform: ' + parameters.get('paymentform')); 
	            	String resultString=ws.pagos(parameters.get('cardcode'),parameters.get('cuenta'),double.valueOf(parameters.get('monto')),parameters.get('referencia'),integer.valueof(parameters.get('docnumfactura')), parameters.get('paymentform'));
	            	system.debug('peticion WS: ' +resultString);
	            	result=(OCCMClases.SapPaymentResult)System.JSON.deserialize(resultString, OCCMClases.SapPaymentResult.class);
	            	system.debug('success: ' + result.success);
	            	system.debug('error: ' + result.error);
            	}
            	else{
            		result.success=true;
            		result.error='';
            		List<String> docs= new List<string>();
            		docs.add('273952');
            		docs.add('273953');
            	}
    		}else{
    			result.error=ParametersErrors(parameters);
    		}
    	}else{
    		result.error='Los parametros no coinciden';
    	}
		}
		catch(Exception e)
		{
			result.error='Exepcion: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage();
		}
    	UpdateMensajePagoSap(oppId, result);
    	system.debug('saliendo:' + result);
    }
    
    public static String ParametersErrors(Map<String, String> parameters){
    	String result='';
    	if (!(parameters.containsKey('cardcode') && !String.isBlank(parameters.get('cardcode'))))
    		result +='Falta cardcode. ';
    	if (!(parameters.containsKey('cuenta') && !String.isBlank(parameters.get('cuenta'))))
    		result +='Falta cuenta. ';
    	if (!(parameters.containsKey('monto') && !String.isBlank(parameters.get('monto'))))
    		result +='Falta monto. ';
    	if (!(parameters.containsKey('referencia') && !String.isBlank(parameters.get('referencia'))))
    		result +='Falta referencia. ';
    	if (!(parameters.containsKey('docnumfactura') && !String.isBlank(parameters.get('docnumfactura'))))
    		result +='Falta docnumfactura. ';
    	//if (!(parameters.containsKey('paymentform') && !String.isBlank(parameters.get('paymentform'))))
    	//	result +='Falta paymentform.';
    	//system.debug('ParametersError: ' + result);
    	return result;
    }
    public static Map<String, String> GetParameters(String oppId)
    {
        Map<String, String> result;
		List<Opportunity> opportunityList = [Select Id,AccountId ,OwnerId, Name,E_mail_para_env_o_de_Factura_Elect_nica__c,
											 		FormaDePago_o__c,CurrencyIsoCode, FechaFactura_o__c, Comentarios__c,Referencia_Numerica_del__c,
                                             		InicioVigencia_o__c,FinVigencia_o__c, Tipo_de_Facturacion__c,
													EstatusFactura__c,CreatedDate,TipoCambio_o__c, Importe_Descuento__c, 
													NumFact__c, Referencia_Bancaria__c,Orden_de_Compra__c,N_mero_de_Proveedor__c, Observaciones_SAP__c, Clasificaci_n_de_Factura__c,
													Banco__c, Importe__c, Referencia_Banc__c,NunOfertafisica_o__c,Estatus_de_pago__c,Fecha_de_Pago_Bancario__c,Concepto_de_Cobro__c, 
													FechaPago__c, N_mero_de_Cuenta_Pago__c, Cuenta_Banco__c, Forma_de_Pago__c
											 	From Opportunity  where  Id =: oppId LIMIT 1];	
		Opportunity factura = opportunityList[0];	        
		List<Account> accountList = [Select Clave_SAP__c,RazonSoc_o__c,Id, Personamf__c,Name, Phone,Telefono2_o__c,Fax,
										RFC_o__c,Website,Cliente_SAE__c,PaisFact_o__c, No_de_interior__c, 
										No_de_Exterior__c, EstadoFact_o__c, DelegMunicFact_o__c, Colonia_de_Facturaci_n__c, 
										CodigoPostalFact_o__c, CiudadFact_opcional_o__c, CalleFact_o__c, Cuenta_Virtual_Banamex__c
									 From Account  where  Id =: factura.AccountId LIMIT 1];			 
		Account account = accountList[0];
		if(account != null ) //!String.isNotBlank(account.Clave_SAP__c) && && !String.isNotBlank(factura.EstatusFactura__c) 
		{
	       result = new Map<String, String>();
	       result.put('oppId', factura.Id);
	       result.put('accId', account.Id);
		   result.put('cardcode', account.Clave_SAP__c);
	       result.put('cuenta', getCuentaSap(factura.Cuenta_Banco__c));
	       system.debug('cuenta_bancoa: ' + factura.Cuenta_Banco__c);
	       system.debug('cuenta bancob: ' + getCuentaSap(factura.Cuenta_Banco__c));
	       result.put('monto', string.valueOf(factura.Importe__c));
	       result.put('referencia', factura.Referencia_Banc__c);
	       result.put('docnumfactura', string.valueOf(factura.NunOfertafisica_o__c));
           if (!String.isBlank(factura.Forma_de_Pago__c))
	       		result.put('paymentform',  getFormaPago(factura.Forma_de_Pago__c));
           else
               result.put('paymentform',  '99');
		}
        return result;
    }
    
    public static OCCMClases.SapPaymentResult ConvertWsResponse(string resultWS){
    	system.debug('Resultado: ' + resultWS);
		OCCMClases.SapPaymentResult result=(OCCMClases.SapPaymentResult)System.JSON.deserialize(resultWS, OCCMClases.SapPaymentResult.class);
		system.debug('success: ' + result.success);
		return result;
    }
    public static void UpdateMensajePagoSap(String oppId, OCCMClases.SapPaymentResult wsResult)
    {
    	system.debug('---------------------------------------------------------------------------------- Metodo UpdateMensajePagoSap actualizando');
        //Map<String, String> result;
		List<Opportunity> opportunityList = [Select Id,Mensaje_pago_SAP__c, ID_pago_SAP__c, X2o_ID_pago_SAP__c 
											 	From Opportunity  where  Id =: oppId LIMIT 1];
		Opportunity factura = opportunityList[0];
		if (wsResult.success==false){
			system.debug('error wsResult: ' + wsResult.error);
			factura.Mensaje_pago_SAP__c=wsResult.error;	
		}
		else{
			factura.Mensaje_pago_SAP__c='Correcto';
			List<String> docs=wsResult.DocList;
			if (docs!=null && !docs.isEmpty()){
				factura.ID_pago_SAP__c= docs.get(0);
				if (wsResult.DocList.size()>1){
					factura.X2o_ID_pago_SAP__c= docs.get(1);
				}
			}
		}
		
        system.debug('Factura:' + JSON.serialize(factura));
        
        system.debug('---------------------------------------------------------------------------------- actualizando');
        update factura;
        system.debug('actualizado');
    }
    public static void DisplayParameters(Map<String, String> parameters){
        system.debug('----------------------------------------------------------- Display');
        system.debug('CardCode: ' + parameters.get('cardcode'));
        system.debug('cuenta: ' + parameters.get('cuenta'));
        system.debug('Monto: ' + parameters.get('monto'));
		system.debug('Referencia: ' + parameters.get('referencia'));
		system.debug('DocNumFactura: ' + parameters.get('docnumfactura'));
        system.debug('oppId: ' + parameters.get('oppId'));
		system.debug('accId: ' + parameters.get('accId'));
        system.debug('----------------------------------------------------------- Display');
    }
    
    public static String getCuentaSap(String cuentaSap){
        String toReturn ='';
        toReturn =  CuentasSap.get(cuentaSap);
        //system.debug('CuentasSap:' + toReturn);
        if(toReturn==null){
            toReturn ='';        
        }
        //system.debug('toReturn:' + toReturn);
        return toReturn;
    }
    public static String getFormaPago(String formaPago){
        String toReturn ='';
        toReturn =  MetodoPagos.get(formaPago);
        //system.debug('CuentasSap:' + toReturn);
        if(toReturn==null){
            toReturn ='';        
        }
        //system.debug('toReturn:' + toReturn);
        return toReturn;
    }
}