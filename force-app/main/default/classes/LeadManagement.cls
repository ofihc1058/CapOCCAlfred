public with sharing class LeadManagement {

	private String IdObject {get; set;}
	public String LadaCode  {get; set;}
	public String LadaCodeId  {get; set;}
	public String AttentionZoneId {get; set;}
	public String AttentionZone {get; set;}
	public string Assigments {get; set;}
	public string NumTelefono {get; set;}
	public List<OCCMClasesV2.Assignation> AssignTo {get; set;}
	public Integer TotalAssigned {get; set;}
	public Map<string, string> Errors {get; set;}
    private List<OCCMClasesV2.AssignationWrapper> AssignationWrapperList  {get; set;}
	public String GetGeneralLeadAssigner  {get; set;}
	public Boolean Success {
		get{
			if (Errors.size()==0){
	   			return true;
			}
	    	else{
				GetGeneralLeadAssigner= FunctionsLeadManagement.GetGeneralLeadAssigner();
				system.debug('GetGeneralLeadAssigner: ');
				system.debug(GetGeneralLeadAssigner);
	      		return false; 
			}
		}
	    private set;
	}

	/* public Boolean GetLadaCode(string numTelefono){
		if (numTelefono.length() == 10) {
			if (numTelefono.startsWith('55') || numTelefono.startsWith('33') || numTelefono.startsWith('81')){
				LadaCode =  numTelefono.substring(0,2);
				return true;
			}else{
				LadaCode = numTelefono.substring(0,3);
				return true;
			}
		}
		if (numTelefono.length() == 12) {
			return GetLadaCode(numTelefono.substring(2,10));
		}
		if (numTelefono.length() == 13) {
			return GetLadaCode(numTelefono.substring(3,10));
		}
		return false;
	} */

	private void  FillInitialData(string idObject, string numTelefono){
	        this.IdObject=idObject;
	        this.NumTelefono = numTelefono;
	        this.LadaCode = '';
			this.AttentionZone = '';
			this.AttentionZoneId = '';
			this.NumTelefono = '';
	    	this.Assigments='';
			this.GetGeneralLeadAssigner='';
	        this.Success = false;
	        this.Errors = new Map<string, string>();
	    	AssignTo = new List<OCCMClasesV2.Assignation>();
	    	AssignationWrapperList = new List<OCCMClasesV2.AssignationWrapper>();
			this.TotalAssigned=0;
	}
	public LeadManagement(){
		FillInitialData('', '');
	}

	public LeadManagement(string idObject, string numTelefono){
		FillInitialData(idObject, numTelefono);
		system.debug('numTelefono' + numTelefono);
		LadaCode= FunctionsLeadManagement.GetLadaCode(numTelefono);
		system.debug('lada: ' + LadaCode);
		if (LadaCode != ''){
		//if (Funciones.GetLadaCode(numTelefono) != ''){
			SYSTEM.debug('Entro a llenar lead');
			if (FillLadaAssignmentConsultant()){
				system.debug('total assignesd' + string.valueOf(this.TotalAssigned));
            	System.debug('FillCuantos');
				FillCuantos();
				system.debug('FillTotalAssigned');
				FillTotalAssigned();
				system.debug('total assignesd: ' + string.valueOf(this.TotalAssigned));
				//System.debug('FillCuantos');
				//system.debug(AssignTo);
				FillAssignationWraper();
				//System.debug('AssignationWrapperList');
				//system.debug(AssignationWrapperList);
			}
		}
		else{
			Errors.Put('PhoneNumber','The phone number must be 10 characters ' + numTelefono + ' number.');
			system.debug('Error GetLadaCode');
			system.debug(Errors);
		}
	}
	
	private Boolean FillLadaAssignmentConsultant(){
		OCCMClasesV2.Assignation ass= new OCCMClasesV2.Assignation();
        Map<string, assignment__c> assigmentTableList= new Map<string, assignment__c>();
        try{
			system.debug('Obtiene el ID de la lada');
			Map<String, String> getCode=FunctionsLeadManagement.GetLadaCodeId(LadaCode);
			//system.debug('getCode');
			//system.debug(getCode);
			if (getCode.containsKey('LadaId')){
				LadaCodeId = getCode.get('LadaId');
			}
			else
			{
				system.debug('Error al obtener Lada');
				system.debug(getCode);
				Errors= getCode;
				return false;
			}
			system.debug('Obtiene en base a lada el id de la zona');
			getCode = FunctionsLeadManagement.GetAtentionZoneId(LadaCodeId);
			if (getCode.containsKey('attentionzoneid')){
				AttentionZoneId = getCode.get('attentionzoneid');
			}
			else
			{
				Errors= getCode;
				system.debug('Error al obtener Zona');
				system.debug(Errors);
				return false;
			}

            system.debug('Obtiene en base al ID de zon la informacion de Zona de atencion');
            List<ZonaAtencion__c> Zone = [SELECT Id, Name FROM ZonaAtencion__c WHERE Id =: AttentionZoneId];
            if (Zone.size()>0){
        		for(ZonaAtencion__c atz: Zone)	{
        			AttentionZone = atz.Name;
        		}
        	}
        	else{
            	Errors.Put('ZonaAtencion','The Atention Zone does not exist into Database' + AttentionZoneId + ' Id.');
				system.debug('Error al obtener Zona');
				system.debug(Errors);
            	return false;
            }
            system.debug('Obtiene en la lista de asignadores por zona de atencion');
            List<Zona_Atencion_consultor__c> AssigZoneList= [SELECT Assignment__c, Zona_de_Atencion__c, Name, Percentage__c FROM Zona_Atencion_consultor__c WHERE Zona_de_Atencion__c =: String.escapeSingleQuotes(this.AttentionZoneId)];
			if (AssigZoneList.size()>0){
            	string listUsers='';
                for(Zona_Atencion_consultor__c assInst: AssigZoneList){
                    if (listUsers != ''){
                        listUsers= listUsers + ', \'';
                    }
                    else
                    {
                        listUsers= + '\'';
                    }
                    listUsers= listUsers + assInst.Assignment__c + '\'';
                }
                String query= 'SELECT Name__c, UserName__c, Usuario__c, Name, Id FROM assignment__c WHERE Id IN ('+ listUsers +')';
                //system.debug('query: ');
                List<assignment__c> usrData = Database.query(query);
                //List<assignment__c> usrData = [SELECT Name__c, UserName__c, user__c, Name, Id FROM assignment__c WHERE Id IN ( listUsers )];
                //system.debug('usrData: ');
                //system.debug(usrData);
                if (usrData.size()>0){
                	for(assignment__c dataUser: usrData){
                         assigmentTableList.Put(dataUser.Id, dataUser);
                    }                    
                }else{
                    Errors.Put('Assignment','Not apper assigment for this institution');
					system.debug('Assignment');
					system.debug(Errors);
                    return false;
                }
                assignment__c edc= new assignment__c();
                for(Zona_Atencion_consultor__c assInst: AssigZoneList){
                    ass= new OCCMClasesV2.Assignation(); 
                    if (assigmentTableList.containsKey(assInst.Assignment__c)){
                        edc= assigmentTableList.get(assInst.Assignment__c);
                        ass.UserId=edc.Usuario__c;
	            		ass.UserName= edc.UserName__c;
                        //system.debug('ass.Assignments__c');
                        //system.debug(assInst.Assignments__c);
                        //system.debug(assInst.percentage__c);
                        ass.AssigmentName= assInst.Name;
                        ass.Percentage = assInst.percentage__c;
                        ass.AssigmentId = assInst.Assignment__c;
                    system.debug('Ass');
                    system.debug(ass);
            		this.AssignTo.add(ass);
                    }
                    else{
                        Errors.Put('Zona_Atencion_consultor__c','The assigment isntitution record dos not have assignemte configures');
						system.debug('Zona_Atencion_consultor__c');
						system.debug(Errors);
            			return false;
                    } 
            	}
                system.debug('AssignTo');
                system.debug(AssignTo);
            }else{
            	Errors.Put('AssigZoneList','The zone Does not have assigned consultants');
				system.debug('The zone Does not have assigned consultants');
                system.debug(Errors);
            	return false;
            }
        }
        catch (Exception e) {
			system.debug(e);
            Errors.put('FillLadaAssignmentConsultant', e.getCause() + '---' + e.getMessage());
            return false;
        }
        return true;
	}
	
	private Integer Cuantos(String userId){
    	try{
    		string queryA= 'SELECT COUNT() FROM AssignedLead__c WHERE usuario__c= \''+ 
    				String.escapeSingleQuotes(userId)+
                '\' and FechaAsignacion__c = THIS_MONTH and FechaAsignacion__c = THIS_YEAR ' +
				' and ZonaAtencionId__c = \'' + AttentionZoneId + '\'';
            system.debug('QueryA');
            system.debug(QueryA);
            //system.debug(Database.countQuery(queryA));
            return Database.countQuery(queryA);
    	}
    	catch (Exception e) {
            system.debug('ExceptionCuantos');
            system.debug(e);
        	return 0;
        }
    }

	private void FillCuantos(){
		system.debug('Entro a cuantos');
		for(OCCMClasesV2.Assignation ass: this.AssignTo){
			ass.HowMany=Cuantos(ass.UserId);
			system.debug('howMany');
			system.debug(ass.HowMany);
			this.TotalAssigned= this.TotalAssigned + ass.HowMany;
			system.debug('TotalAssigned'); 
			system.debug(this.TotalAssigned); 
		}
    }

	private void FillTotalAssigned(){
		for(OCCMClasesV2.Assignation ass: this.AssignTo){
			if (this.TotalAssigned==0 ){
				ass.TotalPercentage = ass.Percentage - (ass.HowMany * 100);    
			}else
			{
				ass.TotalPercentage = ass.Percentage - ((ass.HowMany * 100)/ this.TotalAssigned);    
			} 
			//system.debug('ass');
			//system.debug(ass);
		}
    }
	private void FillAssignationWraper(){
        for(OCCMClasesV2.Assignation ass: this.AssignTo){
    		this.AssignationWrapperList.add(new OCCMClasesV2.AssignationWrapper(ass));
    	}
        this.AssignationWrapperList.sort();
        //system.debug('this.AssignationWrapperList');
        //system.debug(this.AssignationWrapperList);
        //system.debug('this.TotalAssigned');
        //system.debug(this.TotalAssigned);
    }
    public string GetUserToAssign(string orden){
        if (orden=='Asc')    {
            system.debug('Asc');
            system.debug(this.AssignationWrapperList.get(0).assig.UserId);
            return this.AssignationWrapperList.get(0).assig.UserId;
        }else{
            system.debug('Desc');
            Integer last=AssignationWrapperList.size();
			system.debug(last);
			system.debug('AssignationWrapperList');
			system.debug(AssignationWrapperList);
            system.debug(this.AssignationWrapperList.get(last - 1).assig.UserId);
            return this.AssignationWrapperList.get(last - 1).assig.UserId;
        }
    }
}