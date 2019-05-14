@isTest
private class testTrigger {

 	static testMethod void myUnitTest() {
 		//Metodo anterior con error
 		//Opportunity opp = new Opportunity(name = 'IS TEST 2' , StageName = 'Prospect',CloseDate = date.newinstance(2010, 10, 21),Id='0065000000An8Q5AAJ',Description='');  	
       	//opp.Description='Algo';
       	//update opp;
		//opp = new Opportunity(name = 'IS TEST 2' , StageName = 'Prospect',CloseDate = date.newinstance(2010, 10, 21),Description='');
		//insert opp;
	 
	 	Opportunity o = new Opportunity(name = 'IS TEST B2' , StageName = 'Prospect',CloseDate = date.newinstance(2010, 10, 21),Description='');
		insert o;
       	o.Description='Algo';
       	update o;
	 	
 	}
 	static testMethod void TestAccountTrigger() {
    	Account accountTest= new Account();
		accountTest.Phone = '0000000000';			    
		accountTest.Fax	= '0000000000';   
		accountTest.PaisFact_o__c = 'Mexico';
		accountTest.EstadoFact_o__c = 'Queretaro';
		accountTest.CiudadFact_opcional_o__c = 'Queretaro';
		accountTest.DelegMunicFact_o__c = 'Queretaro';
		accountTest.CalleFact_o__c = 'Calle';
		accountTest.No_de_Exterior__c = 'Ext';
		accountTest.No_de_interior__c = '01';
		accountTest.Colonia_de_Facturaci_n__c = 'Colonia';
		accountTest.CodigoPostalFact_o__c = '00000';   
		accountTest.RFC_o__c = 'RFCA000000AAA';
		accountTest.Name = 'OMicro';
		accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		
		insert accountTest;
		Account getAccount=[Select Id, Name, CalleFact_o__c, No_de_Exterior__c, No_de_interior__c, 
									Colonia_de_Facturaci_n__c, DelegMunicFact_o__c, EstadoFact_o__c,
									CodigoPostalFact_o__c, PaisFact_o__c, Cuenta_Virtual_Banamex__c, Is_Future_Context__c
								From Account
								WHERE Name =: accountTest.Name AND OCCM_Cuenta_Administradora__c =: accountTest.OCCM_Cuenta_Administradora__c
								LIMIT 1];
								
    	getAccount.Is_Future_Context__c=false;
    	getAccount.RFC_o__c = 'RFCA000000CCC';
    	update getAccount;
    	
    	getAccount.Is_Future_Context__c=false;
    	getAccount.PaisFact_o__c = 'Mexicando';
		update getAccount;
		
		//getAccount.Is_Future_Context__c=false;
		getAccount.EstadoFact_o__c = 'San Luis Potosi';
		//update getAccount;
    	
    	getAccount.Is_Future_Context__c=false;
		getAccount.CiudadFact_opcional_o__c = 'San Luis Potosi';
		update getAccount;
    	
    	//getAccount.Is_Future_Context__c=false;
		getAccount.DelegMunicFact_o__c = 'San Luis Potosi';
		//update getAccount;

    	getAccount.Is_Future_Context__c=false;
		getAccount.CalleFact_o__c = 'CalleAct';
		update getAccount;

		//getAccount.Is_Future_Context__c=false;
		getAccount.No_de_Exterior__c = 'Exter';
		//update getAccount;
		
		//getAccount.Is_Future_Context__c=false;
		getAccount.No_de_interior__c = 'Int';
		//update getAccount;
		
		getAccount.Is_Future_Context__c=false;
		getAccount.Colonia_de_Facturaci_n__c = 'FactColo';
		update getAccount;
		
		//getAccount.Is_Future_Context__c=false;
		getAccount.CodigoPostalFact_o__c = '11111';
		//update getAccount;
		
		getAccount.Is_Future_Context__c=false;
		getAccount.name='NameAct';
		update getAccount;
		
		//getAccount.Is_Future_Context__c=false;
		getAccount.Cuenta_Virtual_Banamex__c='BAN111111';
		update getAccount;
		
    	getAccount.Is_Future_Context__c=true;
    	getAccount.RFC_o__c = 'RFCA000000DDD';
		getAccount.PaisFact_o__c = 'Mexico1';
		getAccount.EstadoFact_o__c = 'Jalisco';
		getAccount.CiudadFact_opcional_o__c = 'Guadalajara';
		getAccount.DelegMunicFact_o__c = 'Guadalajara';
		getAccount.CalleFact_o__c = 'Calle1Act';
		getAccount.No_de_Exterior__c = 'ExtAct';
		getAccount.No_de_interior__c = '01Act';
		getAccount.Colonia_de_Facturaci_n__c = 'ColoniaAct';
		getAccount.CodigoPostalFact_o__c = '00000';
		getAccount.name='Nombre';
    	update getAccount;
    	
    }
    static testMethod void TestLeadTrigger() {
    	Lead leadTest= new Lead();
		
		leadTest.Is_Future_Context__c=true;
		leadTest.OCCM_Cuenta_Administradora__c='xmxcuentax';
		leadTest.RFC__c = 'RFCA000000AAA';
		leadTest.Calle_o__c = 'Calle';
		leadTest.No_de_Exterior_de_Facturacion__c =  'Ext';
		leadTest.No_de_interior_de_Facturacion__c =  '01';
		leadTest.Colonia__c = 'Colonia';
		leadTest.DelegMunic_o__c = 'Queretaro';
		leadTest.Estado__c  = 'Queretaro';
		leadTest.CodPostal_o__c = '00000';   
		leadTest.Pais_o__c = 'Mexico';
		leadTest.FirstName = 'TestUser';
		leadTest.LastName = 'UserTest';
		leadTest.OCCM_Password_Cuenta_Administradora__c='Password';
		leadTest.Company= 'CompanyName';
		leadTest.Phone = '4421231234';
		
		insert leadTest;
		Lead getLead=[Select Id, Company, FirstName, LastName, Is_Future_Context__c, OCCM_Cuenta_Administradora__c, RFC__c,
									Calle_o__c, No_de_Exterior_de_Facturacion__c, No_de_interior_de_Facturacion__c,
									Colonia__c, DelegMunic_o__c, Estado__c, CodPostal_o__c, Pais_o__c, 
									OCCM_Password_Cuenta_Administradora__c
								From Lead
								WHERE FirstName =: leadTest.FirstName AND LastName =: leadTest.LastName AND
									OCCM_Cuenta_Administradora__c =: leadTest.OCCM_Cuenta_Administradora__c
								LIMIT 1];
								
    	getLead.Is_Future_Context__c=false;
    	getLead.RFC__c = 'RFCA000000CCC';
    	update getLead;
    	
    	getLead.Is_Future_Context__c=false;
    	getLead.Pais_o__c = 'Mexicando';
		update getLead;
		
		getLead.Is_Future_Context__c=false;
		getLead.Estado__c = 'San Luis Potosi';
		update getLead;
    	
    	getLead.Is_Future_Context__c=false;
		getLead.DelegMunic_o__c = 'San Luis Potosi';
		update getLead;

    	getLead.Is_Future_Context__c=false;
		getLead.Calle_o__c = 'CalleAct';
		update getLead;

		getLead.Is_Future_Context__c=false;
		getLead.No_de_Exterior_de_Facturacion__c = 'Exter';
		update getLead;
		
		getLead.Is_Future_Context__c=false;
		getLead.No_de_interior_de_Facturacion__c = 'Int';
		update getLead;
		
		getLead.Is_Future_Context__c=false;
		getLead.Colonia__c = 'FactColo';
		update getLead;
		
		getLead.Is_Future_Context__c=false;
		getLead.CodPostal_o__c = '11111';
		update getLead;

    	getLead.Is_Future_Context__c=true;
    	getLead.RFC__c = 'RFCA000000CCC';
    	getLead.Pais_o__c = 'Mexicando';
		getLead.Estado__c = 'San Luis Potosi';
		getLead.DelegMunic_o__c = 'San Luis Potosi';
		getLead.Calle_o__c = 'CalleAct';
		getLead.No_de_Exterior_de_Facturacion__c = 'Exter';
		getLead.No_de_interior_de_Facturacion__c = 'Int';
		getLead.Colonia__c = 'FactColo';
		getLead.CodPostal_o__c = '11111';
		update getLead;
    }
    static testMethod void myUnitTest1() {
        // TO DO: implement unit test
        User usr= new User();
        usr=[SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        
        Account account= new Account();
        account.OwnerId=usr.Id;
		account.PaisFact_o__c = 'Mexico';
		account.EstadoFact_o__c = 'Queretaro';
		account.CiudadFact_opcional_o__c = 'Queretaro';
		account.DelegMunicFact_o__c = 'Queretaro';
		account.CalleFact_o__c = 'Calle';
		account.No_de_Exterior__c = 'Ext';
		account.No_de_interior__c = '01';
		account.Colonia_de_Facturaci_n__c = 'Colonia';
		account.CiudadFact_opcional_o__c = 'Ciudad';
		account.CodigoPostalFact_o__c = '00000';   
		account.RFC_o__c = 'RFCA000000BBB';
		account.Phone='0000000000';
		account.Website='NA';
		account.Name = 'OMicroNew';
		account.OCCM_Password_Cuenta_Administradora__c = 'password';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
        //select OwnerId from Account where Id =: c.AccountId
        
		Case caso = new Case();
		caso.OwnerId = usr.Id;
        caso.Status = 'Ingreso';
        caso.Origin = 'chat';
        caso.AccountId=account.Id;
       	insert caso;
       	caso.Status = 'Escalado';
		caso.Origin = 'Teléfono';
		caso.Area_responsable__c='Ventas';
		update caso; 
    }

}