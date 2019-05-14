@isTest
private class AssignedLeadCreationTest {
@isTest static void test_method_one() {
		system.debug('LeadManagement');
		test.startTest();
		
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		User userInfo1 = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: '0055'
							LIMIT 1];
        //system.debug('userInfo');
		//system.debug(userInfo);
        //system.debug(userInfo1);

        ZonaAtencion__c zonaAtencion = new ZonaAtencion__c();
		zonaAtencion.Name = 'Corporativo';
		insert zonaAtencion;
		//system.debug('zonaAtencion');
		//system.debug(zonaAtencion);

		Lada__c ld= new Lada__c();
		ld.Name = '55';
		insert ld;
		//system.debug('ld');
		//system.debug(ld);

		Zona_atencion_lada__c zal= new Zona_atencion_lada__c();
		zal.Lada__c = ld.Id;
		zal.Zona_de_atencion__c = zonaAtencion.Id;
		insert zal;
		//system.debug('zonaAtencionLD');
		//system.debug(zal);

		ld= new Lada__c();
		ld.Name = '591';
		insert ld;
		//system.debug('ld');
		//system.debug(ld);

		zal= new Zona_atencion_lada__c();
		zal.Lada__c = ld.Id;
		zal.Zona_de_atencion__c = zonaAtencion.Id;
		insert zal;
		//system.debug('zonaAtencionLD');
		//system.debug(zal);

        List<assignment__c> assignList = new List<assignment__c>();
        assignment__c assign= new assignment__c();
        assign.Usuario__c= userInfo.Id;
        assignList.add(assign);
        assignment__c assign1= new assignment__c();
        assign1.Usuario__c= userInfo1.Id;
        assignList.add(assign1);
        insert assignList;
		//system.debug('assignList');
        //system.debug(assignList);

        List<Zona_Atencion_Consultor__c> assinstList = new List<Zona_Atencion_Consultor__c>();
		Zona_Atencion_Consultor__c assLada= new Zona_Atencion_Consultor__c();
        assLada.zona_de_atencion__c= zonaAtencion.Id;
        assLada.Assignment__c = assign.Id;
        assLada.percentage__c=70;
		insert assLada;
        //system.debug('assLada');
		//system.debug(assLada);
        assLada= new Zona_Atencion_Consultor__c();
        assLada.zona_de_atencion__c= zonaAtencion.Id;
        assLada.Assignment__c = assign1.Id;
        assLada.percentage__c=30;
        insert assLada;
        //system.debug('assLada');
		//system.debug(assLada);
        
        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='5521567890';
        lead.email='email@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '5581567890';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.LeadSource= 'Web';
        // lead.CreationDate = datetime.now();
        insert lead;  
		//system.debug('lead');
		//system.debug(lead);
        //system.debug(lead);
        AssignedLeadCreation.CreateLeadSignation(userInfo.Id, lead.Id, lead.phone);  //string userId, string leadId, string phone
    
    
		AssignedLeadCreation.CreateLeadSignation(null, null, null);  //string userId, string leadId, string phone
		system.debug('Proceso LeadManagement');
		system.debug('Salgo de LeadManagement');
		test.stopTest();
	}
}