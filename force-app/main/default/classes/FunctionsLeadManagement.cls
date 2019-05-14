public with sharing class FunctionsLeadManagement {
	/// <summary> Funcion que regresa la lada de un numero de telefono  
    /// </summary>
    /// <param name="phone">Numero telefonico.</param>
    /// <returns>El codigo de lada o vacio si no  existe
    /// </returns>
	public static String GetLadaCode(string numTelefono){
		if (numTelefono.length() == 10) {
			if (numTelefono.startsWith('55') || numTelefono.startsWith('33') || numTelefono.startsWith('81')){
				return numTelefono.substring(0,2);
			}else{
				return numTelefono.substring(0,3);
			}
		}
		if (numTelefono.length() == 12) {
			return GetLadaCode(numTelefono.substring(2,10));
		}
		if (numTelefono.length() == 13) {
			return GetLadaCode(numTelefono.substring(3,10));
		}
		return '';
	}
	/// <summary> Funcion que regresa la lada de un numero de telefono  
    /// </summary>
    /// <param name="phone">Numero telefonico.</param>
    /// <returns>El codigo de lada o vacio si no  existe
    /// </returns>
    public static string GetGeneralLeadAssigner(){
		List<OCCConfig__c> config = [SELECT Id, AssignLeadToId__c FROM OCCConfig__c LIMIT 1];
		if ( config.size()>0 && !string.isBlank(config[0].AssignLeadToId__c)){
			return config[0].AssignLeadToId__c;
		}
		return '';
	}
	public static Map<string, string> GetLadaCodeId(string ladaCode){
		//string LadaCode= GetLadaCode(numTelefono);
		Map<String, String> result= new Map<String, String>();
		if (LadaCode!=''){
			List<Lada__c> ladaId= [SELECT Id, Name  FROM Lada__c WHERE Name =: ladaCode Limit 1];
			if (ladaId.size()>0){
				for(Lada__c ld: ladaId)	{
					system.debug('LadaId');
					system.debug(ld.Id);
					result.Put('LadaId',ld.Id);
				}
			}
			else{
				system.debug('Error en base a lada la zonaid');
				system.debug(ladaCode);
				result.Put('Error','LadaCode: The lada code does not exist into Database ' + LadaCode + ' Code');
			}
		}
		else{
			result.Put('Error','Invalid Lada code');
		}
		return result;
	}
	public static Map<string, string> GetAtentionZoneId(string ladaCodeId){
		Map<String, String> result= new Map<String, String>();
		List<Zona_Atencion_Lada__c> ZoneId= [SELECT Id, Name, Lada__c, Zona_de_Atencion__c FROM Zona_Atencion_Lada__c WHERE Lada__c =: ladaCodeId Limit 1];
		if (ZoneId.size()>0){
			for(Zona_Atencion_Lada__c att: ZoneId)	{
				//attentionzoneId = att.Zona_de_Atencion__c;
				system.debug('Zona_Atencion_Lada__c');
				system.debug(att.Zona_de_Atencion__c);
				result.Put('attentionzoneid', att.Zona_de_Atencion__c);
			}
		}
		else{
			system.debug('Error en base a lada la zonaid');
			system.debug(result);
			result.Put('Error','AtentionZoneId The atentionzone for Ladacode does not exist into Database ' + ladaCodeId + ' Code');
		}
		return result;
	}
}