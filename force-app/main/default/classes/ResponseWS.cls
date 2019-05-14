public with sharing class ResponseWS {
	
	String message;
	String status;
	String factura;
	String pago;
	
	public ResponseWS(String message,String status){
		this.message = message;	
		this.status = status;
	}
	public ResponseWS(){	
	}
	public String getMessage(){
		return message;
	}
	public String getStatus(){
		return status;
	}
	public String getFactura(){
		return factura;
	}
	public String getPago(){
		return pago;
	}
	
	
	public void setPago(String pago){
		this.pago = pago;	
	}
	public void setFactura(String factura){
		this.factura = factura;	
	}
	public void setMessage(String message){
		this.message = message;	
	}
	public void setStatus(String status){
		this.status = status;
	}
	
	static testMethod void TestResponseWS() {
    	ResponseWS rs= new ResponseWS();
    	ResponseWS rs1= new ResponseWS('', '');
    	String Message=rs1.getMessage();
    	String Status=rs1.getStatus();
    	String Factura=rs1.getFactura();
    	String Pago=rs1.getPago();
    	rs1.setPago('Pago');
    	rs1.setFactura('factura');
    	rs1.setMessage('message');
    	rs1.setStatus('status');
    }
}