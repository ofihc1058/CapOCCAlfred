public with sharing class PrincipalService {

	public static String getIdType(String id) {
		if (id.length() < 3) return 'Invalid Id';
		String type = id.substring(0, 3);
		
		switch on type {

			when  '00Q' {
				return 'Lead';
				}
			when  '001' {
				return 'Account';
				}
			when else {
				return 'Invalid Id';
			}

		}
	}

	public static OCCMClasesV2.LeadDto accountToLeadDto(OCCMClasesV2.AccountDto account) {
		if(account == null) return null;
		OCCMClasesV2.LeadDto accountCreated = new OCCMClasesV2.LeadDto();
		accountCreated.Id = account.Id;
		accountCreated.LastName = account.LastName;
		accountCreated.FirstName = account.FirstName;
		accountCreated.Email = account.Email;
		accountCreated.Phone = account.Phone;
		accountCreated.Rfc = account.Rfc;
		accountCreated.OccAdministrativeAccount = account.OccAdministrativeAccount;
		accountCreated.Company = account.Company;
		accountCreated.LeadSource = account.LeadSource;
		accountCreated.OriginDetail = account.OriginDetail;
		accountCreated.EmployeesNumber = account.EmployeesNumber;
		accountCreated.Industry = account.Industry;
		accountCreated.BusinessActivity = account.BusinessActivity;
		accountCreated.PostalCode = account.PostalCode;
		accountCreated.State = account.State;
		accountCreated.City = account.City;
		accountCreated.Country = account.Country;
		accountCreated.Website = account.Website;
		accountCreated.Description = account.Description;
		accountCreated.CommercialName = account.CommercialName;
		accountCreated.Logo = account.Logo;
		accountCreated.WhyJoinUs = account.WhyJoinUs;
		accountCreated.CampaignTracking = account.CampaignTracking;
		accountCreated.NoLeads = account.NoLeads;
		accountCreated.ConvertedAccountId = account.Id;
		accountCreated.IsConverted = true;
		return accountCreated;
	}

	public static void createTask(String ownerId, String leadId, string accountId, string email, string phone) {
		Task t = new Task();
		t.OwnerId = ownerId;
		t.Status = 'No iniciada';
		t.Priority = 'Normal';
		t.ReminderDateTime = System.now();
		t.ActivityDate = System.today();
		t.IsReminderSet = true;
		t.Subject = 'Intento de contacto';
		t.Description = 'El contacto se ha tratado de registrar nuevamente con el siguiente correo: ' + email + ' y el siguiente teléfono: ' + phone;
		if(String.IsnotBlank(leadId)){
			t.WhoId = leadId;
		}
		if(String.IsnotBlank(accountId)) {
			t.WhatID  = accountId;
		}
		insert t;
	}

	public static OCCMClasesV2.LeadDto leadToLeadDto(Lead lead) {
		OCCMClasesV2.LeadDto leadDto = new OCCMClasesV2.LeadDto();
		leadDto.Id = lead.Id;
		leadDto.LastName = lead.LastName;
		leadDto.FirstName = lead.FirstName;
		leadDto.Email = lead.Email;
		leadDto.Phone = lead.Phone;
		leadDto.Rfc = lead.Rfc__c;
		leadDto.OccAdministrativeAccount = lead.OCCM_Cuenta_Administradora__c;
		leadDto.Company = lead.Company;
		leadDto.LeadSource = lead.LeadSource;
		leadDto.OriginDetail = lead.Detalle_origen__c;
		leadDto.EmployeesNumber = lead.No_Empleados__c;
		leadDto.Industry = lead.Industry;
		leadDto.BusinessActivity = lead.Giro_o__c;
		leadDto.PostalCode = lead.CodPostal_o__c;
		leadDto.State = lead.Estado__c;
		leadDto.City = lead.DelegMunic_o__c;
		leadDto.Country = lead.Pais_o__c;
		leadDto.Website = lead.Website;
		leadDto.Description = lead.Observacion_o__c;
		leadDto.CommercialName = lead.Nombre_Comercial__c;
		leadDto.Logo = lead.Logo__c;
		leadDto.WhyJoinUs = lead.Porque_unirte__c;
		leadDto.NoLeads = lead.NoLeads__c;
		leadDto.IsConverted = lead.IsConverted;
		leadDto.CampaignTracking = lead.Campaign_Tracking__c;
		leadDto.ConvertedAccountId = lead.ConvertedAccountId;
		return leadDto;
	}
}