public class AssignedLeadCreation {
    public static String CreateLeadSignation(string userId, string leadId, string phone){
        try{
			// if ( ladaCode != ''){ debe guardar sin importar la lada
			AssignedLead__c assLead=new AssignedLead__c();
			assLead.FechaAsignacion__c= DateTime.now();
			assLead.assignedlead__c=leadId;
			assLead.usuario__c= userId;
			assLead.Phone__c = phone;
            String LadaCode='';
            LadaCode= FunctionsLeadManagement.GetLadaCode(phone);
            if (LadaCode == '')
                return 'Numero de telefono invalido';
            Map<String,String> getCode=FunctionsLeadManagement.GetLadaCodeId(LadaCode);
            String LadaCodeId = '';
            if (getCode.containsKey('LadaId'))
                LadaCodeId = getCode.get('LadaId');
            else
                return getCode.get('Error');

            getCode = FunctionsLeadManagement.GetAtentionZoneId(LadaCodeId);
            if (getCode.containsKey('attentionzoneid'))
                assLead.ZonaAtencionId__c = getCode.get('attentionzoneid');
            else
                return getCode.get('Error');
			insert assLead;
			//}   
        }
        catch(Exception e){
            return e.getMessage();
        }
        return '';
    }
}