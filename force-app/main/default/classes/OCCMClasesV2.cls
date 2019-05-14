global with sharing class OCCMClasesV2 {

	global class ExecutionResult
	{
        public Boolean success { get; set; }
        public String message { get; set; }
        public Object objectResult { get; set; }
        public ExecutionResult(){
        
        }
        public ExecutionResult(Boolean Estatus, String Mensaje, Object ObjetoResulta){
        	success=Estatus;
        	message=Mensaje;
        	objectResult=ObjetoResulta;
        }
	}

    global class AccountDto {
        public String Id { get; set; }
        public String LastName { get; set; }
        public String FirstName { get; set; }
        public String Email { get; set; }
        public String Phone { get; set; }
        public String Rfc { get; set; }
        public String OccAdministrativeAccount { get; set; }
        public String Company { get; set; }
        public String LeadSource { get; set; }
        public String OriginDetail { get; set; }
        public String CampaignTracking { get; set;}
        public String EmployeesNumber { get; set; }
        public String Industry { get; set; }
        public String BusinessActivity { get; set; }
        public String PostalCode { get; set; }
        public String State { get; set; }
        public String City { get; set; }
        public String Country { get; set; }
        public String Website { get; set; }
        public String Description { get; set; }
        public String CommercialName { get; set; }
        public String Logo { get; set; }
        public Decimal NoLeads { get; set; }
        public String WhyJoinUs { get; set; }
        public String OwnerId { get; set; }

        public AccountDto() {}
    }

    global class ResponseLead {
        public String Message { get; set;}
        public LeadDto Lead { get; set;}
        
        public ResponseLead() {}
    }

    global class LeadDto {
        public String Id { get; set; }
        public String LastName { get; set; }
        public String FirstName { get; set; }
        public String Email { get; set; }
        public String Phone { get; set; }
        public String Rfc { get; set; }
        public String OccAdministrativeAccount { get; set; }
        public String Company { get; set; }
        public String LeadSource { get; set; }
        public String OriginDetail { get; set; }
        public String CampaignTracking { get; set;}
        public String EmployeesNumber { get; set; }
        public String Industry { get; set; }
        public String BusinessActivity { get; set; }
        public String PostalCode { get; set; }
        public String State { get; set; }
        public String City { get; set; }
        public String Country { get; set; }
        public String Website { get; set; }
        public String Description { get; set; }
        public String CommercialName { get; set; }
        public String Logo { get; set; }
        public String WhyJoinUs { get; set; }
        public String ConvertedAccountId { get; set; }
        public Decimal NoLeads { get; set; }
        public Boolean IsConverted { get; set; }

        public LeadDto() { }
    }
	
	global class Assignation {
		public String AssigmentName {get; set;}
        public String AssigmentId {get; set;}
		public String UserId {get; set;}
		public String UserName {get; set;}
		public Double Percentage {get; set;}
		public Integer HowMany {get; set;}
        public Double TotalPercentage {get; set;}
		
		public Assignation(){
			AssigmentName ='';
            AssigmentId='';
			UserId='';
			UserName='';
			Percentage= 0.0;
			HowMany=0;
            TotalPercentage=0.0;
		}
		
	}
	//Implementacion para ordenar la lista de objetos Assignation
    global class AssignationWrapper implements Comparable {
		public Assignation assig;
    	// Constructor
        public AssignationWrapper(Assignation ass) {
            assig = ass;
        }
        // Compare opportunities based on the opportunity amount.
        global Integer compareTo(Object compareTo) {
        // Cast argument to AssignationWrapper
        	AssignationWrapper compareToassig = (AssignationWrapper)compareTo;
            // The return value of 0 indicates that both elements are equal.
            Integer returnValue = 0;
            if (assig.TotalPercentage > compareToassig.assig.TotalPercentage) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (assig.TotalPercentage < compareToassig.assig.TotalPercentage) {
                // Set return value to a negative value.
                returnValue = -1;
            }
            return returnValue;      
        }
    }
    global class ScoreLeadProperties
	{
        public string Name { get; set; }
        public string Type { get; set; }
        public Schema.DisplayType DataType { get; set; }
        public object Value { get; set; }
        
        public ScoreLeadProperties(){
         
        }
        public ScoreLeadProperties(string name, String type, Object value, Schema.DisplayType dataType){
        	this.Name = name;
            this.Type=type;
        	this.Value=value;
            this.DataType = DataType;
        }
	}
}