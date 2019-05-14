@isTest
private class FunctionsLeadManagementTest {
	
	@isTest static void test_method_one() {
		// Implement test code
		string result='';
        Map<String, String> resultMap= new Map<string, string>();
		
        result= FunctionsLeadManagement.GetGeneralLeadAssigner();
        
		OCCConfig__c ass= new OCCConfig__c();
		ass.AssignLeadToId__c='005123423457890';
		insert ass;
        
        Lada__c lada= new Lada__c();
        lada.Name = '442';
        insert lada;
        //lada= new Lada__c();
        //lada.Name = '55';
        //insert lada;
        ZonaAtencion__c za= new ZonaAtencion__c();
        za.Name = 'Corporativo';
        insert za;
            
        Zona_Atencion_Lada__c zal= new Zona_Atencion_Lada__c();
        zal.Lada__c = lada.Id;
        //zal.Name = 'ZAL';
        zal.Zona_de_Atencion__c = za.Id;
        insert zal;
        

		result= FunctionsLeadManagement.GetLadaCode('551231239876');
        result= FunctionsLeadManagement.GetLadaCode('5512312398');
        result= FunctionsLeadManagement.GetLadaCode('4428668623');
		result= FunctionsLeadManagement.GetLadaCode('014427891234');
		result= FunctionsLeadManagement.GetLadaCode('0444427891234');
		result= FunctionsLeadManagement.GetLadaCode('0444427891234543');
        resultMap = new Map<string, string>();
        resultMap = FunctionsLeadManagement.GetLadaCodeId('');
        resultMap = FunctionsLeadManagement.GetLadaCodeId('442');
        resultMap = FunctionsLeadManagement.GetLadaCodeId('81');
        resultMap = FunctionsLeadManagement.GetAtentionZoneId(lada.Id);
        resultMap = FunctionsLeadManagement.GetAtentionZoneId(za.Id);
        resultMap = FunctionsLeadManagement.GetAtentionZoneId('123456789');

		result= FunctionsLeadManagement.GetGeneralLeadAssigner();

	}

}