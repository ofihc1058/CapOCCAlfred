@isTest
private class WsPaymentSapTest {
    static testMethod void WsPaymentTest() {
    	test.startTest(); 
    	WsPaymentSap.Pagos_element pagos_elemts= new WsPaymentSap.Pagos_element();
       	pagos_elemts.CardCode='card';
        pagos_elemts.Cuenta='cuent';
        pagos_elemts.Monto=0.0;
        pagos_elemts.Referencia='refe';
        pagos_elemts.DocNumFactura=20;
        pagos_elemts.U_SAT_FPAGO='01';
    	WsPaymentSap.PagosResponse_element response_element= new WsPaymentSap.PagosResponse_element();
        response_element.PagosResult='respuesta';
        WSPaymentSap.DemoSoap ws= new WSPaymentSap.DemoSoap(); 
        ws.endpoint_x = 'http://wsdlpagos.occmcorp.com:1025/demo.asmx';
        ws.inputHttpHeaders_x=new Map<String,String>();
        ws.outputHttpHeaders_x=new Map<String,String>();
        ws.clientCertName_x='';
        ws.clientCert_x='';
        ws.clientCertPasswd_x='';
        ws.timeout_x=0;
        Test.setMock(WebServiceMock.class, new WebServiceMockImpl());
        // Call the method that invokes a callout
        String result=ws.pagos('cardcode','cuenta',double.valueOf('0'),'referencia',integer.valueof(0),'01');
        
        
        test.stopTest();    
    }
    //static testMethod void WsPaymentTestAsync() {
    	//AsyncWsPaymentSap asyn= new AsyncWsPaymentSap();
    	//asyn.PagosResponse_elementFuture elef= new System.WebServiceCalloutFuture();
    	//String getValue= elef.getValue();
    	//AsyncDemoSoap ads= new AsyncDemoSoap();
    	//ads.endpoint_x = 'http://wsdlpagos.occmcorp.com:1025/demo.asmx';
        //ads.inputHttpHeaders_x =new Map<String,String>();
        //ads.clientCertName_x='';
        //ads.timeout_x=0;
    //}
}