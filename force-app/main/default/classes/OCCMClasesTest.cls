@isTest
public class OCCMClasesTest {
	static testMethod void TestOCCMClases() {
        test.startTest(); 
    		OCCMClases.ExecutionResult executionResult= new OCCMClases.ExecutionResult(true, 'Mensaje', null);
    		executionResult.success=true;
        	executionResult.message='Mensaje';
        	executionResult.objectResult=null;
    		OCCMClases.WsExecutionResult WsExecutionResult= new OCCMClases.WsExecutionResult(true, 'Mensaje', '');
    		WsExecutionResult.success=true;
        	WsExecutionResult.message='Mensaje';
        	WsExecutionResult.objectResult='';
    		OCCMClases.ExecutionResult executionResult1= new OCCMClases.ExecutionResult();
    		OCCMClases.WsExecutionResult WsExecutionResult1= new OCCMClases.WsExecutionResult();
    		OCCMClases.PersonalData PersonalData= new OCCMClases.PersonalData();
    		OCCMClases.Error error= new OCCMClases.Error();
    		error.item='';
    		error.message='';
    		OCCMClases.StatementString st= new OCCMClases.StatementString();
	    	st.Id=1;
	    	st.EntryDateToString= Date.today();
	        st.EntryDate='';
	        st.Amount=0.0;
	        st.ReferenceNumber='';
	        st.VirtualAccountId='';
	        st.VirtualAccountIdCompany='';
	        st.ReferenceAlpha='';
	        st.ReferenceBank='';
	        st.ModifiedDate='';          
	        st.Status='';
	        st.StatusID=0;
	        st.AuthorizationNumber='';
	        st.BankId=0;
	        st.Bank='';
        	st.PaymentFormId = 0;
        	st.PaymentForm = '';
    		OCCMClases.OCCMPurchase OCCMPurchase= new OCCMClases.OCCMPurchase();
    		OCCMClases.OCCMPurchaseString OCCMPurchaseString= new OCCMClases.OCCMPurchaseString();
    		OCCMClases.OCCMPackage OCCMPackage= new OCCMClases.OCCMPackage();
    		OCCMClases.OCCMPackage occpackage= new OCCMClases.OCCMPackage(-1, '', '','',-1.0,false,false,'',null,'');
    		OCCMClases.OCCMPackageString OCCMPackageString= new OCCMClases.OCCMPackageString();
    		OCCMClases.OCCMService OCCMService= new OCCMClases.OCCMService();
    		OCCMClases.AccountSummary AccountSummary= new OCCMClases.AccountSummary();
    		OCCMClases.CompanySummary CompanySummary= new OCCMClases.CompanySummary();
    		OCCMClases.CompanySummaryString CompanySummaryString= new OCCMClases.CompanySummaryString();
    		OCCMClases.StatementString Statement= new OCCMClases.StatementString();
    		OCCMClases.ContractSummary ContractSummary= new OCCMClases.ContractSummary();
    		OCCMClases.DocumentsSAP documentSAP = new OCCMClases.DocumentsSAP('01/01/2014','Cliente','InicioVigencia','FinVigencia','ComentarioVigencia','TipoFactura','Pagada',
														    					'CorreoAlterno','Origen','HoraCreacion','NombreEjecutivo','SerieDocumento','EmpleadoVentas',
														    					'OrdenCompra','idVentaCarrito','Moneda', 'TipoCambio','FolioSalesForce','ReferenciaCIE','TipoFacturacion',
														    					'OrdenCompra2','NumProveedor','ClasificacionFactura','EstatusFactura','ObservacionesSAP','CuentaVirtual',
														    					null,'FechaPago', '01', '1234');
			OCCMClases.DocumentLineSap documentlineSap= new OCCMClases.DocumentLineSap('xxxxxxxxxxx','10','10','0'); 														    					
			OCCMClases.BusinessPartnersSap bp=new OCCMClases.BusinessPartnersSap('CodigoSN','NombreSN','Telefono1','Telefono2','Fax','PersonaContacto','DefinicionImpuesto',
								'RFC','EmpleadoVentas','TelefonoCelular','CURP','NombreExtranjero','Territorio','WebSite',
								'IDSAE','IDSalesForce','IDContactoSalesForce','Calle','Colonia','CodigoPostal','Municipio',
								'Pais','Estado','NoExterior','NoInterior','ContactoPuesto','ContactoDireccion','ContactoTelefono1',
								'ContactoTelefono2','ContactoCelular','ContactoFax','ContactoEmail');
			OCCMClases.PaymentsSap paymentsSap = new OCCMClases.PaymentsSap('CardCodeI','BancoI','ImportePagoI','TransferenceReferenceI','DocEntryI','U_EstatusdePagoI','U_FechaPagoBancarioI','U_ConceptodeCobroI');	
						    					
			OCCMClases.Sales saleDef= new OCCMClases.Sales();
			
			OCCMClases.SapPaymentResult sapPaymentResult= new OCCMClases.SapPaymentResult();
			 
    		//OCCMClases.BusinessPartners bp= new BusinessPartners();
    		//OCCMClases.BusinessPartners bp= new OCCMClases.BusinessPartners(CodigoSN: CL0026250,NombreSN: AUTOX, S.A. de C.V.Telefono1: 333333333Telefono2: 333333331Fax: 333333332PersonaContacto: nullDefinicionImpuesto: IVAP16RFC: BTT991006VB6EmpleadoVentas: 0004TelefonoCelular: CURP: NombreExtranjero: AUTOXTerritorio: 1WebSite: www.autox.mxIDSAE: SAE0000001IDSalesForce: 001W000000G7JvcIAFIDContactoSalesForce: nullCalle: cigüeñasColonia: alamedaasCodigoPostal: 52970Municipio: AcambayPais: MéxicoEstado: Estado de MéxicoNoExterior: 29NoInterior: nullContactoPuesto: nullContactoDireccion: ContactoTelefono1: nullContactoTelefono2: nullContactoCelular: nullContactoFax: nullContactoEmail: null
    		
    		//'{'success":'true','error':'','doclist':[{'DocNumPago':'273952'},{'DocNumPago':'273953'}]}"
    		
    		OCCMClases.ContractSummary cs= new OCCMClases.ContractSummary();
		    cs.ActivationDate= '';
	        cs.AvailableItems= 0;
	        cs.ContractServiceId=0;
	        cs.ExpirationDate= '';
	        cs.ExpirationPeriod=0;
	        cs.IdValidityType=0;
	        cs.LastUpdatedDate= '';
	        cs.PackageCode= '';
	        cs.PackageId=0;
	        cs.PackageName= '';
	        cs.PaymentMethodId =0;
	        cs.PaymentMethodName= '';
	        cs.PurchasedItems =0;
	        cs.PurchaseId =0;
	        cs.PurchaseStateDescription= '';
	        cs.PurchaseStateId =0;
	        cs.RecruiterId= '';
	        cs.SalesforceDocument= '';
	        cs.ServiceId =0;
	        cs.ServiceName= '';
	        cs.ServiceType=0;
	        cs.UsedItems =0;
	        cs.ValidityType= '';

			OCCMClases.Sales sale=new OCCMClases.Sales();
    		sale.Documents= documentSAP;
    		sale.BusinessPartners= bp;
    		//sales.Payments= paymentsSap;
    	test.stopTest();  
    	
    }
    static testMethod void TestSapPaymentResponse(){
        test.startTest(); 
    	List<String> lista= new List<String>(); 
    	lista.add('1234567');
    	OCCMClases.SapPaymentResult sapPaymentResult= new OCCMClases.SapPaymentResult();
    	sapPaymentResult.success=true;
    	sapPaymentResult.error= '';
    	sapPaymentResult.DocList= lista;
        test.stopTest();  
    
    }
}