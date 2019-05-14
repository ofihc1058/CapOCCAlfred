//Generated by wsdl2apex

public class WsPaymentSap {
    public class Pagos_element {
        public String CardCode;
        public String Cuenta;
        public Double Monto;
        public String Referencia;
        public Integer DocNumFactura;
        public String U_SAT_FPAGO;
        private String[] CardCode_type_info = new String[]{'CardCode','http://wsdlpagos.occmcorp.com/',null,'0','1','false'};
        private String[] Cuenta_type_info = new String[]{'Cuenta','http://wsdlpagos.occmcorp.com/',null,'0','1','false'};
        private String[] Monto_type_info = new String[]{'Monto','http://wsdlpagos.occmcorp.com/',null,'1','1','false'};
        private String[] Referencia_type_info = new String[]{'Referencia','http://wsdlpagos.occmcorp.com/',null,'0','1','false'};
        private String[] DocNumFactura_type_info = new String[]{'DocNumFactura','http://wsdlpagos.occmcorp.com/',null,'1','1','false'};
        private String[] U_SAT_FPAGO_type_info = new String[]{'U_SAT_FPAGO','http://wsdlpagos.occmcorp.com/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://wsdlpagos.occmcorp.com/','true','false'};
        private String[] field_order_type_info = new String[]{'CardCode','Cuenta','Monto','Referencia','DocNumFactura','U_SAT_FPAGO'};
    }
    public class PagosResponse_element {
        public String PagosResult;
        private String[] PagosResult_type_info = new String[]{'PagosResult','http://wsdlpagos.occmcorp.com/',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://wsdlpagos.occmcorp.com/','true','false'};
        private String[] field_order_type_info = new String[]{'PagosResult'};
    }
    public class DemoSoap {
        //public String endpoint_x = 'http://wsdlpagos.occmcorp.com:1025/Demo.asmx';
//        public String endpoint_x = 'http://wsdlpagosprod.occmcorp.com:1026/Demo.asmx';
        public String endpoint_x = 'http://aquariusp.occmcorp.com:1026/Demo.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'http://wsdlpagos.occmcorp.com/', 'WsPaymentSap'};
        public String Pagos(String CardCode,String Cuenta,Double Monto,String Referencia,Integer DocNumFactura,String U_SAT_FPAGO) {
            WsPaymentSap.Pagos_element request_x = new WsPaymentSap.Pagos_element();
            request_x.CardCode = CardCode;
            request_x.Cuenta = Cuenta;
            request_x.Monto = Monto;
            request_x.Referencia = Referencia;
            request_x.DocNumFactura = DocNumFactura;
            request_x.U_SAT_FPAGO = U_SAT_FPAGO;
            WsPaymentSap.PagosResponse_element response_x;
            Map<String, WsPaymentSap.PagosResponse_element> response_map_x = new Map<String, WsPaymentSap.PagosResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'http://wsdlpagos.occmcorp.com/Pagos',
              'http://wsdlpagos.occmcorp.com/',
              'Pagos',
              'http://wsdlpagos.occmcorp.com/',
              'PagosResponse',
              'WsPaymentSap.PagosResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.PagosResult;
        }
    }
}