public with sharing class AccountMigrationButtonController
{
	/******************************
	*    ATRIBUTOS DE LA CLASE    *
	******************************/
	
	private String accountId;
	
	public Boolean hideRadioOptions { get; set; }
	
	public String migrationType { get; set; }
         
	public Account account {get; set;}
	
	public List<SelectOption> options {get; set;}
    
	public String emailMigration {get; set;}

	/***********
	* METODOS  *
	***********/


	/*****************************************************************************
	* CONSTRUCTOR                                                                *
	*                                                                            *
	*****************************************************************************/
	public AccountMigrationButtonController()
	{
		accountId = Apexpages.currentPage().getParameters().get('id');
		
		hideRadioOptions=false;
		
		account = [SELECT
					Id,
					Name,
					Type,
					Correo_de_Supervisor__c
				FROM Account WHERE Id =: accountId];
	
        emailMigration = '';
        
		migrationType = 'Nada que hacer';
		
		options = new List<SelectOption>();
        
        options.add(new SelectOption('Nada que hacer','Migración manual')); 
        options.add(new SelectOption('G','Migración de usuario en Blanco ( Con nueva cuenta administradora y cuentas actuales como subcuentas)')); 
        options.add(new SelectOption('C','Migración de usuario Histórico Confidencial (Cuenta privada actual como cuenta administradora)'));
        options.add(new SelectOption('P','Migración de usuario Histórico Público (Cuenta pública actual como cuenta administradora)'));
	}


	/**
	* @description Metodo que realiza la migracion de account
	* @param
	* @return PageReference hacia la migracion de account
	*/
	
	public PageReference invokeIsNewBusinessModelAccount()
	{
		//System.debug('ingresando a invokeIsNewBusinessModelAccount');
		String JsonResult;
				
		try
		{
			//system.debug('Llamando al WS is new business model account');
			JsonResult = WSSalesforceRecluta.IsNewBusinessModelAccount(accountId);
			//system.debug('Regresando WS isnewbusinessmodelaccount');
		}
		catch(Exception e)
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Error'+e.getMessage()));
		}
			
		//System.debug('Resultado SIN deserializar: ' + JsonResult);
		
		OCCMClases.ExecutionResult result = (OCCMClases.ExecutionResult) JSON.deserialize(JsonResult, OCCMClases.ExecutionResult.class);
		
		System.debug('Resultado deserializado: ' + result);
		System.debug('Resultado Success: ' + result.success);
		System.debug('Resultado message: ' + result.message);
		System.debug('Resultado objectResult: ' + result.objectResult);
			
		if (result.message == 'La cuenta ya pertenecia al modelo de paquetes.')
		{
			//system.debug('/apex/AccountPreviouslyMigrated?id=');
			return new PageReference('/apex/AccountPreviouslyMigrated?id=' + account.Id);
		}
		else
		{
			//system.debug('/apex/AccountMigrationOptions?id=');
			return new PageReference('/apex/AccountMigrationOptions?id=' + account.Id);
		}
	}
	

	/**
	* @description Metodo que regresa a la pagina de detalle de account  
	* @param
	* @return PageReference hacia la pagina de detalle de account
	*/
	public PageReference BackToAccount()
	{
		return new PageReference('/' + account.Id);
	}
	

	public PageReference invokeMigrateAccount()
	{
		String JsonResult;
		//system.debug('accountId:' + accountId);
		//system.debug('migrationType:' + migrationType);
		//system.debug('emailMigration:' + emailMigration);
		if (migrationType == 'Nada que hacer')
		{
			return new PageReference('/' + account.Id);
		}
		else
		{
			try
			{
				JsonResult = WSSalesforceRecluta.MigrateAccount(accountId, migrationType, emailMigration);
			}
			catch(Exception e)
			{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Error'+e.getMessage()));
			}
			//system.debug('JsonResult:' + JsonResult);
			//System.debug('OTRO Resultado SIN deserializar: ' + JsonResult);
			OCCMClases.ExecutionResult result= new OCCMClases.ExecutionResult();
			if (JsonResult!=null){
				result = (OCCMClases.ExecutionResult) JSON.deserialize(JsonResult, OCCMClases.ExecutionResult.class);
			}else
			{
				result.success =false;
				result.message='No regreso valores el metodo de migracion.';
			}
			
			//System.debug('OTRO Resultado deserializado: ' + result);
			//System.debug('OTRO Resultado Success: ' + result.success);
			//System.debug('OTRO Resultado message: ' + result.message);
			//System.debug('OTRO Resultado objectResult: ' + result.objectResult);
			
			if(result.success == true)
			{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Informe: '+result.message));
				hideRadioOptions=true;
				return null;
			}
			else
			{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Error: '+ result.message));
				hideRadioOptions=true;
				return null;
			}
			
			return null;
		}
	}
		
		

	static testMethod void myTest()
	{
		Account acc = new Account(
						Name = 'Test Acc',
						RecordTypeId = '0125000000055YM',
						Phone = '018001232222',
						Website = 'www.something.com',
						Type = 'Individual',
						Industry = 'Alimentos y Bebidas',
						No_Empleados__c = 'Menos de 8 empleados',
						Tipo_de_Vacante__c = 'Ejecutivo',
						N_mero_de_Vacantes__c = '11 a 20',
						Producto_de_inter_s__c = 'Membresía OCC Premium',
						RFC_o__c = '12345678',
						CalleFact_o__c = 'calle',
						No_de_Exterior__c = '125',
						Colonia_de_Facturaci_n__c = 'Colonia',
						DelegMunicFact_o__c = 'Tapachula,Chis.',
						CiudadFact_opcional_o__c = 'Ciudad',
						CodigoPostalFact_o__c = '123456',
						PaisFact_o__c = 'Mexico',
						C_mo_se_enter_de_OCCMundial__c = 'Por recomendacion'
						);
		insert acc;
		Apexpages.currentPage().getParameters().put('id', acc.Id);
		
		AccountMigrationButtonController obj = new AccountMigrationButtonController();
		
		PageReference p;
		
		p = obj.invokeIsNewBusinessModelAccount();
		
		obj.migrationType = 'Algo distinto de Nada que hacer';
		
		p = obj.invokeMigrateAccount();
		
		p = obj.BackToAccount();
		
		obj.emailMigration='Test@test.com';
		p = obj.invokeMigrateAccount();
		
		obj.migrationType ='G';
		p = obj.invokeMigrateAccount();
		obj.migrationType ='C';
		p = obj.invokeMigrateAccount();
		obj.migrationType ='P';
		p = obj.invokeMigrateAccount();
		
		p = obj.BackToAccount();
		
	}

	
	static testMethod void myTest1()
	{
		Account acc = new Account(
						Name = 'Test Acc',
						RecordTypeId = '0125000000055YM',
						Phone = '018001232222',
						Website = 'www.something.com',
						Type = 'Individual',
						Industry = 'Alimentos y Bebidas',
						No_Empleados__c = 'Menos de 8 empleados',
						Tipo_de_Vacante__c = 'Ejecutivo',
						N_mero_de_Vacantes__c = '11 a 20',
						Producto_de_inter_s__c = 'Membresía OCC Premium',
						RFC_o__c = '12345678',
						CalleFact_o__c = 'calle',
						No_de_Exterior__c = '125',
						Colonia_de_Facturaci_n__c = 'Colonia',
						DelegMunicFact_o__c = 'Tapachula,Chis.',
						CiudadFact_opcional_o__c = 'Ciudad',
						CodigoPostalFact_o__c = '123456',
						PaisFact_o__c = 'Mexico',
						C_mo_se_enter_de_OCCMundial__c = 'Por recomendacion'
						);
		insert acc;
		
		Apexpages.currentPage().getParameters().put('id', acc.Id);
		
		AccountMigrationButtonController obj = new AccountMigrationButtonController();
		
		PageReference p;
		
		//p = obj.invokeIsNewBusinessModelAccount();
		obj.emailMigration='Test@test.com';
		p = obj.invokeMigrateAccount();
		
		obj.migrationType = 'Nada que hacer';
		
		//p = obj.invokeMigrateAccount();
		
		//p = obj.BackToAccount();
	}
	
}