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
@isTest
private class testAppService {

    static testMethod void myUnitTest() {
    	
    		
    		System.debug('++++++++++++'+Utils.getCountryCode('Maxico'));
    		
    		/*
    		XMLDom xmlDOM = new XMLDom('<?xml version="1.0" encoding="utf-8"?> <env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope">   <env:Body>     <env:Fault>       <env:Code>         <env:Value>env:Receiver</env:Value>         <env:Subcode>           <env:Value>-1004</env:Value>         </env:Subcode>        </env:Code>       <env:Reason>         <env:Text xml:lang="en">\'\' is not a valid value for property \'U_TipoFactura\'. The valid values are: \'ND\' - \'No Definido\',  \'0\' - \'Contado\',  \'1\' - \'Crédito\'</env:Text>       </env:Reason>       <env:Detail>         <Object>13</Object>         <ObjectIndex>1</ObjectIndex>          <Command>AddObject</Command>         <SessionID>E5398983-B109-4F57-930F-501E3F3A244F</SessionID>       </env:Detail>     </env:Fault>   </env:Body> </env:Envelope>');
    		
    		
    		xmlDOM = new XMLDom('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://www.w3.org/2003/05/soap-envelope"><env:Body><UpdateObjectResponse xmlns="http://www.sap.com/SBO/DIS">      <RetKey>SF0020000</RetKey>    </UpdateObjectResponse>  </env:Body></env:Envelope>');
			String codigoString = '';
			String messageString = '';
			XMLDom.Element  codigo = null;
			XMLDom.Element mensaje = null;
			codigo = xmlDOM.getElementByTagName('Codigo');
			if(codigo!=null){
					codigoString = codigo.getAttribute('RetVal');
					System.debug('+++++++++++++valor: '+codigoString);
					if('0'==codigoString){
						mensaje = xmlDOM.getElementByTagName('Mensaje');
						if(mensaje!=null){
							messageString = mensaje.getAttribute('Descripcion');
						}
					}
					else{
						
					}
			}else{
				codigo = xmlDOM.getElementByTagName('Code');
				
				System.debug('essssssssstt+++:' +codigo);
			
			}	
			codigo = xmlDOM.getElementByTagName('RetKey');
			if( codigo!=null ){
					System.debug('es1212121212121tt+++:' +codigo.textContent());
			}	
			
			System.debug('valor: '+messageString);
    		*/
    		
    		
    		ResponseWS  responseWS = Utils.parseResponse('<?xml version="1.0" encoding="utf-8"?><env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/">  <env:Body>    <dis:RetKeys xmlns:dis="http://www.sap.com/SBO/DIS">      <Pago>53</Pago>    </dis:RetKeys>  </env:Body></env:Envelope>');
    		
    		System.debug('+++++++++++++++++++++++'+ responseWS.getStatus());
    		System.debug('+++++++++++++++++++++++'+ responseWS.getPago());
    		if(responseWS.getFactura()==null){
    		System.debug('+++++++++++++++++++++++'+ responseWS.getFactura());
    		}
    		System.debug('+++++++++++++++++++++++'+ Utils.parseIdVentaPago(responseWS.getMessage()));
    		
    	
    	List<StatusFactura__c> facturas = [Select s.OpportunityId__c, s.ExtendedStatus__c, s.Estatus__c From StatusFactura__c s where s.OpportunityId__c  ='0065000000An8Q5AAJ'LIMIT 1];  
		StatusFactura__c status  = facturas[0];
    	
    	
    	//System.debug('Current User:::::::::::::::::::::::::::::: ' +appServiceFacturacionSAPWS.getNextSAPId());
    	String id='0065000000An8Q5AAJ';
    	String idVentaPago='89';
    	//appServiceFacturacionSAPWS.CreaSocioNegocio(id);
 	appServiceFacturacionSAPWS.VentaPago(id,appServiceFacturacionSAPWS.CFDYPAGO);
        //appServiceFacturacionSAPWS.generateSAPCFD(id);
        
       
         //appServiceFacturacionSAPWS.Venta(id, idVentaPago);
         appServiceFacturacionSAPWS.PagoWS(id);
           //appServiceFacturacionSAPWS.PagoWS(id);
        //System.debug('.................... '+  appServiceFacturacionSAPWS.Venta(id, '1'));
        
         
        //System.debug('.................... '+ appServiceFacturacionSAPWS.getNextSAPId());
    	

    	/*
    	String id='0065000000FHC8cAAH';
    	String idVentaPago='';
        Opportunity opp = new Opportunity(Id=id);
        
        appServiceFacturacionSAPWS.Venta(id, idVentaPago);
		appServiceFacturacionSAPWS.CreaSocioNegocio(id);
        appServiceFacturacionSAPWS.VentaPago(id); 
        appServiceFacturacionSAPWS.Alive(id);
        appServiceFacturacionSAPWS.generateSAPCFD(id);
		*/
        
        
       
        
        
  
        
        
    }
}