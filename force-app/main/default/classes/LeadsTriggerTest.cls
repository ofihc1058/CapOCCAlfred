@isTest
private class LeadsTriggerTest {
    static testMethod void TestClassOK(){
        test.startTest();
         
        Rule__c rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='ls_new_lead__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule;
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Si';
        ruleDet.weighing__c = 1.0;
        insert ruleDet;
        
        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='ls_day_week__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule;
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Lunes';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Martes';
        ruleDet.weighing__c = 0.2;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Miercoles';
        ruleDet.weighing__c = 0.1;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Jueves';
        ruleDet.weighing__c = 0.1;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Viernes';
        ruleDet.weighing__c = 0.2;
        insert ruleDet;

        rule= new Rule__c();
        rule.Operation__c ='<>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'misefago@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'micantonpasa@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        
		rule= new Rule__c();
        rule.Operation__c ='>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NoLeads__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
		
        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='FechaCreacion__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '2019/03/01';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
		
        rule= new Rule__c();
        rule.Operation__c ='IN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Móvil';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'mise';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        rule= new Rule__c();
        rule.Operation__c ='Start';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Calle_o__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'mise';
        ruleDet.weighing__c = 0.5;

        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='DoNotCall';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'true';
        ruleDet.weighing__c = 0.5;

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
        lead.LeadSource= 'occ_web';
        // lead.CreationDate = datetime.now();
        // 
        lead.NumberOfEmployees=1;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        insert lead;  
     
        test.stopTest();
        system.debug('Sali');
    }
    
    static testMethod void TestClass(){
        test.startTest();
         
        Rule__c rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='ls_new_lead__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule;
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Si';
        ruleDet.weighing__c = 1.0;
        insert ruleDet;
        
        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='ls_day_week__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule;
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Lunes';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Martes';
        ruleDet.weighing__c = 0.2;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Miercoles';
        ruleDet.weighing__c = 0.1;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Jueves';
        ruleDet.weighing__c = 0.1;
        insert ruleDet;
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Viernes';
        ruleDet.weighing__c = 0.2;
        insert ruleDet;

        rule= new Rule__c();
        rule.Operation__c ='<>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'misefago@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'micantonpasa@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        
		rule= new Rule__c();
        rule.Operation__c ='>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NoLeads__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
		
        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='FechaCreacion__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '2019/03/01';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
		
        rule= new Rule__c();
        rule.Operation__c ='IN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Móvil';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'mise';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        rule= new Rule__c();
        rule.Operation__c ='Start';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Calle_o__c';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'mise';
        ruleDet.weighing__c = 0.5;

        rule= new Rule__c();
        rule.Operation__c ='=';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='DoNotCall';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'true';
        ruleDet.weighing__c = 0.5;

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

        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='0000000000';
        lead.email='email@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '0000000000';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.MobilePhone = '0000000000';    
        lead.LeadSource= 'occ_web';
        lead.NumberOfEmployees=1;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        test.stopTest();
        system.debug('Sali');
    }
}