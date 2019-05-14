public with sharing class LeadService {

	private AccountService accountService;

	public LeadService() { 
		this.accountService = new AccountService();
	}

	public OCCMClasesV2.LeadDto getLead(String id) {
		String idType = PrincipalService.getIdType(id);
		System.debug('Tipo Id: ' + idType);
		if (idType != 'Lead') return PrincipalService.accountToLeadDto(this.accountService.getAccountById(id));
		OCCMClasesV2.LeadDto responseLead = this.getLeadById(id);
		if (responseLead == null) return null;
		return responseLead.IsConverted ? PrincipalService.accountToLeadDto(this.accountService.getAccountById(responseLead.ConvertedAccountId)) : responseLead;
	}

	public OCCMClasesV2.LeadDto getLeadById(String idLead) {
		System.debug('Obtener lead con id: ' + idLead);
		Lead lead = this.getLeadObjectById(idLead);
		return lead == null ? null : PrincipalService.leadToLeadDto(lead);
	}

	public Map<String, Object> createLead(OCCMClasesV2.LeadDto leadDto) {
		System.debug('Crear nuevo lead');
		Map<String, Object> response = new Map<String, Object>();
		try {
			Lead leadExist = this.getLeadByCompanyOrEmail(leadDto.Company, leadDto.Email);
			if (leadExist != null) 
			{
				response.put('Status', 'Error');
				if(!leadExist.IsConverted) {
					response.put('Message', 'Duplicated Lead Razón Social: ' + leadDto.Company + ' Email: ' + leadDto.Email);
					this.updateNoLead(leadExist);
					PrincipalService.createTask(leadExist.OwnerId, leadExist.Id, null, leadDto.Email, leadDto.Phone);
				} else {
					response.put('Message', 'Duplicated Account Razón Social: ' + leadDto.Company + ' Email: ' + leadDto.Email);
					this.updateNoLeadAccount(leadExist.ConvertedAccountId, leadDto.Email, leadDto.Phone);
				}
				return response;
			}
			if (String.isNotBlank(leadDto.Rfc))
			{
				Lead leadRfcExist = this.getLeadByRfc(leadDto.Rfc);
				if (leadRfcExist != null) 
				{
					response.put('Status', 'Error');
					if(!leadRfcExist.IsConverted) {
						response.put('Message', 'Duplicated Lead RFC: ' + leadDto.Rfc );
						this.updateNoLead(leadRfcExist);
						PrincipalService.createTask(leadRfcExist.OwnerId, leadRfcExist.Id, null, leadDto.Email, leadDto.Phone);
					} else {
						response.put('Message', 'Duplicated Account RFC: ' + leadDto.Rfc );
						this.updateNoLeadAccount(leadRfcExist.ConvertedAccountId, leadDto.Email, leadDto.Phone);
					}
					return response;
				}
				OCCMClasesV2.AccountDto rfcExists = this.accountService.getAccountByRFC(leadDto.Rfc);
				if (rfcExists != null)
				{
					response.put('Status', 'Error');
					response.put('Message', 'Duplicated Account RFC: ' + leadDto.Rfc);
					this.updateNoLeadAccount(rfcExists.Id, leadDto.Email, leadDto.Phone);
					return response;
				}
				
			}
			OCCMClasesV2.AccountDto accountExist = this.accountService.getAccountByCompany(leadDto.Company);
			if (accountExist != null)
			{
				response.put('Status', 'Error');
				response.put('Message', 'Duplicated Account Razón Social: ' + leadDto.Company);
				this.updateNoLeadAccount(accountExist.Id, leadDto.Email, leadDto.Phone);
				return response;
			}
			Contact contactExist = this.accountService.getAccountByEmail(leadDto.Email);
			if (contactExist != null)
			{
				response.put('Status', 'Error');
				response.put('Message', 'Duplicated Account Email: ' + leadDto.Email);
				OCCMClasesV2.AccountDto accountByContact = this.accountService.getAccountById(contactExist.AccountId);
				this.updateNoLeadAccount(contactExist.AccountId, leadDto.Email, leadDto.Phone);
				return response;
			}

			response.put('Status', 'Created');
			response.put('Message', this.insertLead(leadDto));
			return response;

		}catch(Exception  e) {
			response.put('Status', 'Error');
			response.put('Message', e.getMessage());
			return response;
		}
	}

	private OCCMClasesV2.LeadDto insertLead(OCCMClasesV2.LeadDto leadDto) {
		Lead lead = new Lead();
		lead.LastName = leadDto.LastName;
		lead.FirstName = leadDto.FirstName;
		lead.Email = leadDto.Email;
		lead.Phone = leadDto.Phone;
		lead.Rfc__c = leadDto.Rfc;
		lead.OCCM_Cuenta_Administradora__c = leadDto.OccAdministrativeAccount;
		lead.Company = leadDto.Company;
		lead.LeadSource = leadDto.LeadSource;
		lead.Detalle_origen__c = leadDto.OriginDetail;
		lead.No_Empleados__c = leadDto.EmployeesNumber;
		lead.Industry = leadDto.Industry;
		lead.Giro_o__c = leadDto.BusinessActivity;
		lead.CodPostal_o__c = leadDto.PostalCode;
		lead.Estado__c = leadDto.State;
		lead.DelegMunic_o__c = leadDto.City;
		lead.Pais_o__c = leadDto.Country;
		lead.Website = leadDto.Website;
		lead.Observacion_o__c = leadDto.Description;
		lead.Nombre_Comercial__c = leadDto.CommercialName;
		lead.Logo__c = leadDto.Logo;
		lead.Porque_unirte__c = leadDto.WhyJoinUs;
		lead.Campaign_Tracking__c = leadDto.CampaignTracking;
		lead.NoLeads__c = 1.0;
		insert lead;

		return PrincipalService.leadToLeadDto(lead);
	}

	public Map<String, Object> patchLeadService(String id, Map<String, Object> filteredData) {
		System.debug('Patch lead: ' + id);
		Map<String, Object> response = new Map<String, Object>();
		try {
			String leadType = PrincipalService.getIdType(id);
			if (leadType != 'Lead') return this.accountService.patchAccount(id, filteredData);
			Lead lead = this.getLeadObjectById(id);
            if (lead != null)
            {
                if (!lead.IsConverted) return this.patchLead(id, filteredData, lead);
				OCCMClasesV2.AccountDto account = this.accountService.getAccountById(lead.ConvertedAccountId);
                return this.accountService.patchAccount(account.Id, filteredData);
            }

			response.put('Status', 'NOT_FOUND');
			response.put('Message', 'Id not found: ' + id);
			return response;

		}catch(Exception  e) {
			response.put('Status', 'Error');
			response.put('Message', e.getMessage());
			return response;
		}
	}


	private void updateNoLead(Lead lead) {
		System.debug('Actualizar toques lead: ' + lead.Id);
		Double total = 1.0;
		if(lead.NoLeads__c != null) { total = lead.NoLeads__c; }
		lead.NoLeads__c = total + 1.0;
		update lead;
	}

	private void updateNoLeadAccount(String accountId, String email, String phone) {
		System.debug('Actualizar toques account: ' + accountId);
		List<Account> account = this.accountService.getAccountObject(accountId);
		if(account.size() >= 0) {
			Double total = 1.0;
			if(account[0].NoLeads__c != null) { total = account[0].NoLeads__c; }
			account[0].NoLeads__c = total + 1.0;
			update account[0];
			PrincipalService.createTask(account[0].OwnerId, null, account[0].Id, email, phone);
		}
	}

	private Lead getLeadByCompanyOrEmail(String company, String email) {
		System.debug('Obtener lead con email: ' + email + ' company: ' + company);
		List<Lead> lead = [Select Id, Name, LastName, FirstName, Email, Phone, RFC__c, OCCM_Cuenta_Administradora__c, Company, OwnerId, LeadSource, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c, CodPostal_o__c, Estado__c, 
							DelegMunic_o__c, Pais_o__c, Website, Observacion_o__c, Nombre_Comercial__c, Logo__c, 
							Porque_unirte__c, Campaign_Tracking__c, IsConverted, NoLeads__c, ConvertedAccountId
								From Lead
								WHERE (Company = :company OR Email = :email)];
		return lead.size() == 0 ? null : lead[0];
	}

	private Lead getLeadByRfc(String rfc) {
		System.debug('Obtener lead con rfc: ' + rfc );
		List<Lead> lead = [Select Id, Name, LastName, FirstName, Email, Phone, RFC__c, OCCM_Cuenta_Administradora__c, Company, OwnerId, LeadSource, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c, CodPostal_o__c, Estado__c, 
							DelegMunic_o__c, Pais_o__c, Website, Observacion_o__c, Nombre_Comercial__c, Logo__c, 
							Porque_unirte__c, Campaign_Tracking__c, IsConverted, NoLeads__c, ConvertedAccountId
								From Lead
								WHERE RFC__c = :rfc];
		return lead.size() == 0 ? null : lead[0];
	}

	private Map<String, Object> patchLead(String id, Map<String, Object> filteredData, Lead lead) {
		Map<String, Object> response = new Map<String, Object>();
		try
		{
			System.debug('Patch lead: ' + id);
			String serializedLead = JSON.serialize( PrincipalService.leadToLeadDto(lead) );
			Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(serializedLead);
			System.debug('Antes de actualizar: ' + payload);
			for(String key :payload.keyset())
			{
				System.debug('Key: ' + key);
				System.debug('Value: ' + payload.get(key));
				if(filteredData.containsKey(key))
				{
				
					payload.remove(key); // value is returned before its removed
  					payload.put(key, filteredData.get(key));
					System.debug('Actualizar: ' + payload.get(key));
				}
			}

			if(payload.get('LastName') != null ) if(!String.isBlank(payload.get('LastName').ToString())) lead.LastName = payload.get('LastName').ToString();
			if(payload.get('FirstName')  != null ) if(!String.isBlank(payload.get('FirstName').ToString())) lead.FirstName = payload.get('FirstName').ToString();
			if(payload.get('Email')  != null ) if(!String.isBlank(payload.get('Email').ToString())) lead.Email = payload.get('Email').ToString();
			if(payload.get('Phone') == null) { lead.Phone = null; } else { lead.Phone = payload.get('Phone').ToString(); }
			if(payload.get('EmployeesNumber') == null) { lead.No_Empleados__c = null; } else { lead.No_Empleados__c = payload.get('EmployeesNumber').ToString(); }
			if(payload.get('Industry') == null) { lead.Industry = null; } else { lead.Industry = payload.get('Industry').ToString(); }
			if(payload.get('BusinessActivity') == null) { lead.Giro_o__c = null; } else { lead.Giro_o__c = payload.get('BusinessActivity').ToString(); }
			if(payload.get('PostalCode') == null) { lead.CodPostal_o__c = null; } else { lead.CodPostal_o__c = payload.get('PostalCode').ToString(); }
			if(payload.get('State') == null) { lead.Estado__c = null; } else { lead.Estado__c = payload.get('State').ToString(); }
			if(payload.get('City') == null) { lead.DelegMunic_o__c = null; } else { lead.DelegMunic_o__c = payload.get('City').ToString(); }
			if(payload.get('Country') == null) { lead.Pais_o__c = null; } else { lead.Pais_o__c = payload.get('Country').ToString(); }
			if(payload.get('Website') == null) { lead.Website = null; } else { lead.Website = payload.get('Website').ToString(); }
			if(payload.get('Description') == null) { lead.Observacion_o__c = null; } else { lead.Observacion_o__c = payload.get('Description').ToString(); }
			if(payload.get('CommercialName') == null) { lead.Nombre_Comercial__c = null; } else { lead.Nombre_Comercial__c = payload.get('CommercialName').ToString(); }
			if(payload.get('Logo') == null) { lead.Logo__c = null; } else { lead.Logo__c = payload.get('Logo').ToString(); }
			if(payload.get('WhyJoinUs') == null) { lead.Porque_unirte__c = null; } else { lead.Porque_unirte__c = payload.get('WhyJoinUs').ToString(); }

			update lead;

			response.put('Status', 'SUCCESS');
			response.put('Message', PrincipalService.leadToLeadDto(lead));
			return response;
		}
		catch (Exception e)
		{
			response.put('Status', 'Error');
			response.put('Message', e.getMessage());
			return response;
		}
	}

	private Lead getLeadObjectById(String idLead) {
		System.debug('Obtener lead con id: ' + idLead);
		List<Lead> lead = [Select Id, Name, LastName, FirstName, Email, Phone, RFC__c, OCCM_Cuenta_Administradora__c, Company, OwnerId, LeadSource, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c, CodPostal_o__c, Estado__c, 
							DelegMunic_o__c, Pais_o__c, Website, Observacion_o__c, Nombre_Comercial__c, Logo__c, 
							Porque_unirte__c, Campaign_Tracking__c, IsConverted, NoLeads__c, ConvertedAccountId
								From Lead
								WHERE Id = :idLead];
		return lead.size() == 0 ? null : lead[0];
	}
	
}