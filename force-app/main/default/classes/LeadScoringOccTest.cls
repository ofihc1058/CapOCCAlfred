@isTest
private class LeadScoringOccTest {
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
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=1;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassStringDiferente(){
        test.startTest();
        
        Rule__c rule= new Rule__c();
        rule.Operation__c ='<>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'misefago@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'micantonpasa@occ.com.mx';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;

        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='0000000000';
        lead.Email='email@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '0000000000';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.MobilePhone = '0000000000';    
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=1;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id, (Object)lead);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassMayorNumeroString(){
        test.startTest();
         
        Rule__c rule= new Rule__c();
        rule.Operation__c ='>';
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
        rule.Operation__c ='>';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '1';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
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
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassMinorNumeroString(){
        test.startTest();
         
        Rule__c rule= new Rule__c();
        rule.Operation__c ='<';
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
        rule.Operation__c ='<';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
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
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
	static testMethod void TestClassInString(){
        test.startTest();
        
        Rule__c rule= new Rule__c();
        rule.Operation__c ='IN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'ruebas';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
		rule= new Rule__c();
        rule.Operation__c ='IN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='0000000000';
        lead.email='emailPruebas@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '0000000000';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.MobilePhone = '0000000000';    
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
	static testMethod void TestClassNotInString(){
        test.startTest();
        
        Rule__c rule= new Rule__c();
        rule.Operation__c ='NOTIN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'Casandra';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
		rule= new Rule__c();
        rule.Operation__c ='NOTIN';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='0000000000';
        lead.email='emailPruebas@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '0000000000';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.MobilePhone = '0000000000';    
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassStartString(){
        test.startTest();
        
        Rule__c rule= new Rule__c();
        rule.Operation__c ='START';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='Email';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = 'email';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
		rule= new Rule__c();
        rule.Operation__c ='START';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
        Lead lead = new Lead();
        lead.FirstName='Nombre';
        lead.LastName='Apellido';
        lead.title='Posicion';
        lead.phone='0000000000';
        lead.email='emailPruebas@email.com';
        lead.Company='TestMethod';
        lead.Industry='Explotacion de Recursos Forestales';
        lead.MobilePhone= '0000000000';
        lead.PostalCode='000000';
        lead.Website='http://www.pruebas.com';  
        lead.MobilePhone = '0000000000';    
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassBetweenNumeroString(){
        test.startTest();
        
		Rule__c rule= new Rule__c();
        rule.Operation__c ='Between';
        rule.Default_Weighing__c=0.00;
        rule.Field__c='NumberOfEmployees';
        rule.Messure__c='';
        rule.Object__c ='Lead';
        rule.Active__c = true;
        insert rule; 
        
        RulesDetails__c ruleDet= new RulesDetails__c();
        ruleDet.Rule__c = rule.Id;
        ruleDet.value1__c = '1';
        ruleDet.value2__c = '10';
        ruleDet.weighing__c = 0.5;
        insert ruleDet;
        
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
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees = 5;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
    static testMethod void TestClassException(){
        test.startTest();

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
        lead.LeadSource= 'Web';
        lead.NumberOfEmployees=1;
        lead.NoLeads__c=0;
        lead.DoNotCall=true;
        // lead.CreationDate = datetime.now();
        insert lead;    
        
        LeadScoringOcc ls = new LeadScoringOcc();
        ls = new LeadScoringOcc('Lead', lead.Id);
        system.debug('LeadScoring: ' + string.valueOf(ls.LeadScoringVal));
        system.debug('Errors: ');
        system.debug(ls.Errors);
        test.stopTest();
        system.debug('Sali');
    }
}