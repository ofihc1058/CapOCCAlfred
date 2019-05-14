@isTest(seeAllData = false)
private class LeadTest {

	private static Lead insertLead() {
		Lead lead = new Lead();
		lead.LastName = 'Donjuán';
		lead.FirstName = 'Elena';
		lead.Email = 'pdonjuan@occ.com.mx';
		lead.Phone = '5583449132';
		lead.Rfc__c = 'GOCJ9807288R8';
		lead.OCCM_Cuenta_Administradora__c = '';
		lead.Status='Calificado para Conversión';
		lead.Company = 'Prueba Capacitación';
		lead.LeadSource = 'Face';
		lead.Detalle_origen__c = 'Detalle';
		lead.No_Empleados__c = '';
		lead.Industry = '';
		lead.Giro_o__c = '';
		lead.CodPostal_o__c = '';
		lead.Estado__c = '';
		lead.DelegMunic_o__c = '';
		lead.Pais_o__c = '';
		lead.Website = '';
		lead.Observacion_o__c = '';
		lead.Nombre_Comercial__c = '';
		lead.Logo__c = '';
		lead.Porque_unirte__c = '';
		lead.Campaign_Tracking__c = 'lswAs';

		insert lead;

		return lead;
	}

	private static Account insertAccount() {
		Account account = new Account();
		account.Phone = '4151511357';
		account.RFC_o__c = 'GOCJ9509266D8';
		account.OCCM_Cuenta_Administradora__c = '';
		account.Name = 'González Cerroblanco Jesús Fernando';
		account.RazonSoc_o__c = 'CAFFE CLOUDDDDDD';
		account.Name = 'CAFFE CLOUDDDDDD';
		account.Origen_Lead__c = 'Face';
		account.Detalle_origen__c = 'Detalle';
		account.No_Empleados__c = '';
		account.Industry = '';
		account.Giro_o__c = '';
		account.CodigoPostalFact_o__c = '';
		account.EstadoFact_o__c = '';
		account.DelegMunicFact_o__c = '';
		account.PaisFact_o__c = '';
		account.Website = '';
		account.Description = '';
		account.Nombre_Comercial__c = '';
		account.Logo__c = '';
		account.Porque_unirte__c = '';
		account.Campaing_Tracking__c = 'lswAs';

		insert account;

		Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.LastName = 'González Cerroblanco';
        contact.FirstName = 'Jesús Fernando';
        contact.Email = 'jesus.gonzalez@occ.com.mx';
        contact.LeadSource = 'Face';

		insert contact;
		
		return account;
	}
	
	@isTest static void testGetNotFound() {
        Test.startTest();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'GET';
		req.params.put('id', '00Q');
		req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.LeadDto responseApi = LeadController.show();
		System.debug(responseApi);
		System.assertEquals(404, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testGetAccountNotFound() {
        Test.startTest();
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'GET';
		req.params.put('id', '001');
		req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.LeadDto responseApi = LeadController.show();
		System.debug(responseApi);
		System.assertEquals(404, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testGetOk() {
        Test.startTest();
		Lead created = insertLead();
		System.debug('Lead id a buscar: ' + created.id);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'GET';
		req.params.put('id', created.Id);
		req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.LeadDto responseApi = LeadController.show();
		System.debug(responseApi);
		System.assertEquals(200, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testGetAccountOk() {
        Test.startTest();
		Account created = insertAccount();
		System.debug('Account id a buscar: ' + created.id);
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'GET';
		req.params.put('id', created.Id);
		req.addHeader('Content-Type', 'application/json'); 
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.LeadDto responseApi = LeadController.show();
		System.debug(responseApi);
		System.assertEquals(200, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostConflictLead() {
        Test.startTest();
		Lead created = insertLead();
		System.debug('Crear nuevo lead conflict');
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9807288R8","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "pdonjuan@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "Prueba Capacitación2","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Message);
		System.assertEquals(409, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostConflictAccount() {
        Test.startTest();
		Account created = insertAccount();
		System.debug('Crear nuevo lead conflict');
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9509266D8","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "pdonjuan@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "Prueba Capacitación2","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Message);
		System.assertEquals(409, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostOk() {
        Test.startTest();
		System.debug('Crear nuevo lead Ok');
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9807288R8","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "pdonjuan@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "Prueba Capacitación2","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Lead);
		System.assertEquals(201, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostDuplicatedRFCLead() {
        Test.startTest();
		Lead created = insertLead();
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9807288R8","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "pdonjua2n@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "Prueba Capacitación2w","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
		System.debug('Crear nuevo lead RFC Repetido');
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Lead);
		System.assertEquals(409, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostDuplicatedRFCAccount() {
        Test.startTest();
		Account created = insertAccount();
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9509266D1","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "pdonjua2n@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "CAFFE CLOUDDDDDD","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
		System.debug('Crear nuevo lead Company Repetido');
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Lead);
		System.assertEquals(409, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPostDuplicatedEmailAccount() {
        Test.startTest();
		Account created = insertAccount();
		String newLead = '{"WhyJoinUs": "","Website": "","State": "Estado de México","Rfc": "GOCJ9509266D1","PostalCode": "54769","Phone": "5583449132","OriginDetail": null,'+
		'"OccAdministrativeAccount": null,"Logo": null,"LeadSource": "Conmutador","LastName": "Donjuán","IsConverted": false,"Industry": "Medios de comunicación",'+
		'"FirstName": "Elena","EmployeesNumber": "8 - 20 empleados","Email": "jesus.gonzalez@occ.com.mx","Description": "Cliente desea una vacante destacada","Country": "México",'+
		'"Company": "CAFFE CLOUDDDDDD2","CommercialName": null,"City": "Tlalnepantla","CampaingTracking": "PruebaCampaña","BusinessActivity": "Publicidad Exterior"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'POST';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(newLead);
        RestContext.request = req;
        RestContext.response = res;
		System.debug('Crear nuevo lead Company Repetido');
        OCCMClasesV2.ResponseLead responseApi = LeadController.create();
		System.debug(responseApi.Lead);
		System.assertEquals(409, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPatchLeadOk() {
        Test.startTest();
		Lead created = insertLead();
		System.debug('Patch lead Ok');
		String patchLead = '{"WhyJoinUs": "Por que si","Website": "Website","State": "Queretaro","Rfc": "Rfc","PostalCode": "37713","Phone": "4151511355","OriginDetail": "Origen Detalle",' +
        '"OccAdministrativeAccount": "Administrativa","NoLeads": 1,"Logo": "Logo","LeadSource": "LeadSource","LastName": "Jesus 2","Industry": "Gobierno","FirstName": "Jesus Fernando",' +
        '"EmployeesNumber": "10 - 58","Email": "jesus@hotmail.com","Description": "Description","Country": "Pais","Company": "Mexico2","CommercialName": "Nombre comercial"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'PATCH';
		req.params.put('id', created.Id);
		System.debug(created.Id);
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(patchLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.updateObject();
		System.debug(responseApi.Lead);
		System.assertEquals(200, res.statusCode);
		System.assertEquals('Por que si', responseApi.Lead.WhyJoinUs);
		Test.stopTest();
	}

	@isTest static void testPatchLeadNotFound() {
        Test.startTest();
		System.debug('Patch Lead Not Found');
		String patchLead = '{"WhyJoinUs": "Por que si","Website": "Website","State": "Queretaro","Rfc": "Rfc","PostalCode": "37713","Phone": "4151511355","OriginDetail": "Origen Detalle",' +
        '"OccAdministrativeAccount": "Administrativa","NoLeads": 1,"Logo": "Logo","LeadSource": "LeadSource","LastName": "Jesus 2","Industry": "Gobierno","FirstName": "Jesus Fernando",' +
        '"EmployeesNumber": "10 - 58","Email": "jesus@hotmail.com","Description": "Description","Country": "Pais","Company": "Mexico2","CommercialName": "Nombre comercial"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'PATCH';
		req.params.put('id', '00Q1');
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(patchLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.updateObject();
		System.debug(responseApi.Lead);
		System.assertEquals(404, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPatchLeadBadRequest() {
        Test.startTest();
		System.debug('Patch Lead Not Found');
		Lead created = insertLead();
		String patchLead = '{"WhyJoinUs": "Por que si","Website": "Website","State": "Queretaro","Rfc": "Rfc","PostalCode": "37713","Phone": "4151511355","OriginDetail": "Origen Detalle",' +
        '"OccAdministrativeAccount": "Administrativa","NoLeads": 1,"Logo": "Logo","LeadSource": "LeadSource","LastName": "Jesus 2","Industry": "Gobierno","FirstName": "Jesus Fernando",' +
        '"EmployeesNumber": "10 - 58","Email": "jesus@hotmail.com","Description": "Description","Country": "Pais","Company": "Mexico2","CommercialName": "Nombre comercial"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'PATCH';
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(patchLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.updateObject();
		System.debug(responseApi.Lead);
		System.assertEquals(400, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPatchAccountNotFound() {
        Test.startTest();
		System.debug('Patch Lead Not Found');
		String patchLead = '{"WhyJoinUs": "Por que si","Website": "Website","State": "Queretaro","Rfc": "Rfc","PostalCode": "37713","Phone": "4151511355","OriginDetail": "Origen Detalle",' +
        '"OccAdministrativeAccount": "Administrativa","NoLeads": 1,"Logo": "Logo","LeadSource": "LeadSource","LastName": "Jesus 2","Industry": "Gobierno","FirstName": "Jesus Fernando",' +
        '"EmployeesNumber": "10 - 58","Email": "jesus@hotmail.com","Description": "Description","Country": "Pais","Company": "Mexico2","CommercialName": "Nombre comercial"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'PATCH';
		req.params.put('id', '001Q');
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(patchLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.updateObject();
		System.debug(responseApi.Lead);
		System.assertEquals(404, res.statusCode);
		Test.stopTest();
	}

	@isTest static void testPatchAccountOk() {
        Test.startTest();
		Account created = insertAccount();
		System.debug('Patch Account Ok');
		String patchLead = '{"WhyJoinUs": "Por que si","Website": "Website","State": "Queretaro","Rfc": "Rfc","PostalCode": "37713","Phone": "4151511355","OriginDetail": "Origen Detalle",' +
        '"OccAdministrativeAccount": "Administrativa","NoLeads": 1,"Logo": "Logo","LeadSource": "LeadSource","LastName": "Jesus 2","Industry": "Gobierno","FirstName": "Jesus Fernando",' +
        '"EmployeesNumber": "10 - 58","Email": "jesus@hotmail.com","Description": "Description","Country": "Pais","Company": "Mexico2","CommercialName": "Nombre comercial"}';
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/lead/';
        req.httpMethod = 'PATCH';
		req.params.put('id', created.Id);
		System.debug(created.Id);
		req.addHeader('Content-Type', 'application/json'); 
		req.requestBody = Blob.valueof(patchLead);
        RestContext.request = req;
        RestContext.response = res;
        OCCMClasesV2.ResponseLead responseApi = LeadController.updateObject();
		System.debug(responseApi.Lead);
		System.assertEquals(200, res.statusCode);
		System.assertEquals('Por que si', responseApi.Lead.WhyJoinUs);
		Test.stopTest();
	}
	
}