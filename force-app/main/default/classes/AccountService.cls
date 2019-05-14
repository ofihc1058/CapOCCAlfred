public with sharing class AccountService {
	public AccountService() {
		
	}

	public OCCMClasesV2.AccountDto getAccountById(String id) {
		System.debug('Obtener cuenta con id' + id);
		List<Account> account = this.getAccountObject(id);
		return account.size() == 0 ? null : this.createDto(account[0]);
	}

	public List<Account> getAccountObject(String id) {
		List<Account> account = [Select Id, Name, Phone, RFC_o__c, OCCM_Cuenta_Administradora__c, RazonSoc_o__c, OwnerId, Origen_Lead__c, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c , CodigoPostalFact_o__c, EstadoFact_o__c, Porque_unirte__c,
							DelegMunicFact_o__c, PaisFact_o__c, Website, Description, Nombre_Comercial__c, Logo__c, NoLeads__c, Campaing_Tracking__c
								From Account
								WHERE Id = :id];
		return account;
	}

	public OCCMClasesV2.AccountDto getAccountByCompany(String company) {
		System.debug('Obtener cuenta con company: ' +  company);
		List<Account> account = [Select Id, Name, Phone, RFC_o__c, OCCM_Cuenta_Administradora__c, RazonSoc_o__c, OwnerId, Origen_Lead__c, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c , CodigoPostalFact_o__c, EstadoFact_o__c, Porque_unirte__c,
							DelegMunicFact_o__c, PaisFact_o__c, Website, Description, Nombre_Comercial__c, Logo__c, NoLeads__c, Campaing_Tracking__c
								From Account
								WHERE Name = :company];
		return account.size() == 0 ? null : this.createDto(account[0]);
	}

	public OCCMClasesV2.AccountDto getAccountByRFC(String rfc) {
		System.debug('Obtener cuenta con rfc: ' +  rfc);
		List<Account> account = [Select Id, Name, Phone, RFC_o__c, OCCM_Cuenta_Administradora__c, RazonSoc_o__c, OwnerId, Origen_Lead__c, 
							Detalle_origen__c, No_Empleados__c, Industry, Giro_o__c , CodigoPostalFact_o__c, EstadoFact_o__c, Porque_unirte__c,
							DelegMunicFact_o__c, PaisFact_o__c, Website, Description, Nombre_Comercial__c, Logo__c, NoLeads__c, Campaing_Tracking__c
								From Account
								WHERE RFC_o__c = :rfc];
		return account.size() == 0 ? null : this.createDto(account[0]);
	}

	public Contact getAccountByEmail(String email) {
		System.debug('Obtener cuenta email: ' + email);
		List<Contact> contact = [Select Id, AccountId, LastName, FirstName, Email, LeadSource, OwnerId
								From Contact
								WHERE Email = :email];
		return contact.size() == 0 ? null : contact[0];
	}

	public Map<String, Object> patchAccount(String id, Map<String, Object> filteredData) {
		Map<String, Object> response = new Map<String, Object>();
		try
		{
			System.debug('Patch account: ' + id);
			List<Account> accountList = this.getAccountObject(id);
			if (accountList.size() == 0)
			{
				response.put('Status', 'NOT_FOUND');
				response.put('Message', 'Id not found: ' + id);
				return response;
			}

			OCCMClasesV2.AccountDto account = this.createDto(accountList[0]);
			String serializedAccount = JSON.serialize(account);
			Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(serializedAccount);
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
			if(payload.get('Phone') == null) { accountList[0].Phone = null; } else { accountList[0].Phone = payload.get('Phone').ToString(); }
			if(payload.get('EmployeesNumber') == null) { accountList[0].No_Empleados__c = null; } else { accountList[0].No_Empleados__c = payload.get('EmployeesNumber').ToString(); }
			if(payload.get('Industry') == null) { accountList[0].Industry = null; } else { accountList[0].Industry = payload.get('Industry').ToString(); }
			if(payload.get('BusinessActivity') == null) { accountList[0].Giro_o__c = null; } else { accountList[0].Giro_o__c = payload.get('BusinessActivity').ToString(); }
			if(payload.get('PostalCode') == null) { accountList[0].CodigoPostalFact_o__c = null; } else { accountList[0].CodigoPostalFact_o__c = payload.get('PostalCode').ToString(); }
			if(payload.get('State') == null) { accountList[0].EstadoFact_o__c = null; } else { accountList[0].EstadoFact_o__c = payload.get('State').ToString(); }
			if(payload.get('City') == null) { accountList[0].DelegMunicFact_o__c = null; } else { accountList[0].DelegMunicFact_o__c = payload.get('City').ToString(); }
			if(payload.get('Country') == null) { accountList[0].PaisFact_o__c = null; } else { accountList[0].PaisFact_o__c = payload.get('Country').ToString(); }
			if(payload.get('Website') == null) { accountList[0].Website = null; } else { accountList[0].Website = payload.get('Website').ToString(); }
			if(payload.get('Description') == null) { accountList[0].Description = null; } else { accountList[0].Description = payload.get('Description').ToString(); }
			if(payload.get('CommercialName') == null) { accountList[0].Nombre_Comercial__c = null; } else { accountList[0].Nombre_Comercial__c = payload.get('CommercialName').ToString(); }
			if(payload.get('Logo') == null) { accountList[0].Logo__c = null; } else { accountList[0].Logo__c = payload.get('Logo').ToString(); }
			if(payload.get('WhyJoinUs') == null) { accountList[0].Porque_unirte__c = null; } else { accountList[0].Porque_unirte__c = payload.get('WhyJoinUs').ToString(); }

			update accountList[0];
			
			Contact contact = this.getContactByAccountId(accountList[0].Id);
			if(contact != null) 
			{
				String serializedContact = JSON.serialize(contact);
				Map<String, Object> payloadContact = (Map<String, Object>)JSON.deserializeUntyped(serializedContact);
				System.debug('Antes de actualizar contacto: ' + payloadContact);
				for(String key :payloadContact.keyset())
				{
					System.debug('Key: ' + key);
					System.debug('Value: ' + payloadContact.get(key));
					if(filteredData.containsKey(key))
					{
					
						payloadContact.remove(key); // value is returned before its removed
						payloadContact.put(key, filteredData.get(key));
						System.debug('Actualizar: ' + payloadContact.get(key));
					}
				}
				if(payloadContact.get('LastName') != null ) if(!String.isBlank(payloadContact.get('LastName').ToString())) contact.LastName = payloadContact.get('LastName').ToString();
				if(payloadContact.get('FirstName')  != null ) if(!String.isBlank(payloadContact.get('FirstName').ToString())) contact.FirstName = payloadContact.get('FirstName').ToString();
				if(payloadContact.get('Email')  != null ) if(!String.isBlank(payloadContact.get('Email').ToString())) contact.Email = payloadContact.get('Email').ToString();
				System.debug('Despues de actualizar contacto: ' + payloadContact);

				update contact;

				System.debug('Despues de actualizar contacto: ' + contact.LastName);
			}
			response.put('Status', 'SUCCESS');
			response.put('Message', PrincipalService.accountToLeadDto(this.createDto(accountList[0])));
			return response;
		}
		catch (Exception e)
		{
			response.put('Status', 'Error');
			response.put('Message', e.getMessage());
			return response;
		}
	}

	private OCCMClasesV2.AccountDto createDto(Account account) {
		OCCMClasesV2.AccountDto response = new OCCMClasesV2.AccountDto();
		response.Id = account.Id;
		response.LastName = '';
		response.FirstName = '';
		response.Email = '';
		response.Phone = account.Phone;
		response.Rfc = account.RFC_o__c;
		response.OccAdministrativeAccount = account.OCCM_Cuenta_Administradora__c;
		response.Company = account.Name;
		response.LeadSource = account.Origen_Lead__c;
		response.OriginDetail = account.Detalle_origen__c;
		response.EmployeesNumber = account.No_Empleados__c;
		response.Industry = account.Industry;
		response.BusinessActivity = account.Giro_o__c;
		response.PostalCode = account.CodigoPostalFact_o__c;
		response.State = account.EstadoFact_o__c;
		response.City = account.DelegMunicFact_o__c;
		response.Country = account.PaisFact_o__c;
		response.Website = account.Website;
		response.Description = account.Description;
		response.CommercialName = account.Nombre_Comercial__c;
		response.Logo = account.Logo__c;
		response.WhyJoinUs = account.Porque_unirte__c;
		response.NoLeads = account.NoLeads__c;
		response.CampaignTracking = account.Campaing_Tracking__c;
		response.OwnerId = account.OwnerId;
		
		Contact contact = this.getContactByAccountId(account.Id);
		if (contact != null)
		{
			response.LastName = contact.LastName;
			response.FirstName = contact.FirstName;
			response.Email = contact.Email;
		}

		return response;
	}

	private Contact getContactByAccountId(String accountId) {
		System.debug('Obtener contacto por account id');
		List<Contact> contact = [Select Id, AccountId, LastName, FirstName, Email, LeadSource, OwnerId
								From Contact
								WHERE AccountId = :accountId LIMIT 100];
		return contact.size() == 0 ? null : contact[0];
	}
}