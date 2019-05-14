public with sharing class GetContractedPackagesController {
	public String accountId {get; set;}
	public String accountName {get; set;}
	public String accountLogin {get; set;}
	public List<OCCMClases.ContractSummary> fullContractedSummaryList {get; set;}
	public List<OCCMClases.ContractSummary> pageContractSummaryList {get; set;}
	public Paginacion paginador {get; set;}
	
	public GetContractedPackagesController()
	{
		Integer cuantosElementos=0;
		accountId = Apexpages.currentPage().getParameters().get('id');
		accountName = Apexpages.currentPage().getParameters().get('name');
		OCCMClases.ExecutionResult jsonResult;
		try
		{
			if (!String.isBlank(accountId)){
				system.debug('Llamando al WS GetContractedPackagesController model account');
				jsonResult = WSSalesforceRecluta.GetContractedPackages(accountId);
				system.debug('Regresando WS GetContractedPackagesController:' + JsonResult);
				if (JsonResult.success==true)
				{
					fullContractedSummaryList=(List<OCCMClases.ContractSummary>)jsonResult.objectResult;
					cuantosElementos= fullContractedSummaryList.size();
					system.debug('cuantosElementos:' + cuantosElementos);
				}else
				{
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, JsonResult.message));
					system.debug('SinRegreso de elemenots:' + JsonResult.message);
				}
				paginador=new Paginacion(cuantosElementos);
				ViewData();
			}
		}
		catch(Exception e)
		{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Error'+e.getMessage()));
		}
	}

	public PageReference ViewData()
	{ 
		BindData(1);
		return null;
	}

	private void BindData(Integer newPageIndex)
	{
		Transient Integer counter = 0;
		try
		{
			pageContractSummaryList= new List<OCCMClases.ContractSummary>();
			paginador.ActualizaMinMax(newPageIndex);
			for(OCCMClases.ContractSummary cs: fullContractedSummaryList)
			{
				counter++;
				if (counter > paginador.min && counter <= paginador.max) 
					pageContractSummaryList.add(cs);
			}
			paginador.pageNumber = newPageIndex;
			if (pageContractSummaryList == null || pageContractSummaryList.size() <= 0) 
				ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'No hay datos disponibles para esta vista.'));
		}
		catch(Exception ex)
		{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,ex.getMessage()));
		}
	}
	public PageReference nextBtnClick() {
		BindData(paginador.pageNumber + 1);
		return null;
	}
	public PageReference previousBtnClick() {
		BindData(paginador.pageNumber - 1);
		return null;
	}
	public PageReference FirstBtnClick() {
		BindData(1);
		return null;
	}
	public PageReference LastBtnClick() {
		BindData(paginador.totalPageNumber);
		return null;
	}
	static testMethod void myTest()
	{
		Account accountTest= new Account();
		accountTest.PaisFact_o__c = 'Mexico';
		accountTest.EstadoFact_o__c = 'Queretaro';
		accountTest.CiudadFact_opcional_o__c = 'Queretaro';
		accountTest.DelegMunicFact_o__c = 'Queretaro';
		accountTest.CalleFact_o__c = 'Calle';
		accountTest.No_de_Exterior__c = 'Ext';
		accountTest.No_de_interior__c = '01';
		accountTest.Colonia_de_Facturaci_n__c = 'Colonia';
		accountTest.CiudadFact_opcional_o__c = 'Ciudad';
		accountTest.CodigoPostalFact_o__c = '00000';   
		accountTest.RFC_o__c = 'RFCA000000AAA';
		accountTest.Phone='0000000000';
		accountTest.Website='NA';
		accountTest.Name = 'OMicro';
		//accountTest.OCCM_Password_Cuenta_Administradora__c = 'password';
		//accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		//accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		accountTest.Type='Individual';
		accountTest.Industry='Industria';
		accountTest.Giro_o__c='Madera';
		accountTest.No_Empleados__c = '501 - 600 empleados';
		accountTest.Tipo_de_Vacante__c = 'Ejecutivo';
		accountTest.N_mero_de_Vacantes__c = '4 a 10';
		accountTest.MembresiaInteres_o__c = '5';
		accountTest.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		accountTest.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		accountTest.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		accountTest.OCCM_Password_Cuenta_Administradora__c='Hola';
		accountTest.Cuenta_Virtual_Banamex__c='BAN000000';
		String accountTestJSON = JSON.serialize(accountTest);
		//String resultadoExec = '';
		
		insert accountTest;	
	
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=accountTest.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;

		Apexpages.currentPage().getParameters().put('id', accountTest.Id);
		Apexpages.currentPage().getParameters().put('name', accountTest.Name);

		GetContractedPackagesController obj = new GetContractedPackagesController();

		PageReference p;
		p = obj.previousBtnClick();
		p = obj.nextBtnClick();
		p = obj.FirstBtnClick();
		p = obj.LastBtnClick();
	}
	
}