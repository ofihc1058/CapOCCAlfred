public with sharing class RecruiterDataServiceWrapper {
//Clase utilizada para realizar el consumo de webservice de recluta, los metodos de comunicacion se establecen aqui	
	/*
	Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
From PricebookEntry 
WHERE Pricebook2Id = '01s50000000MWxHAAW' AND ProductCode like 'NBE175' AND IsActive =true

Metodos en la clase
	RecruiterDataService.RecruiterDataServiceSoap CreateConectionWebService()
	
	OCCMClases.ExecutionResult CreateOccmLead(String jsonPersonalData, String inputLeadId)
	OCCMClases.ExecutionResult CreateOccmAccount(String jsonPersonalData, String inputAccountId)
	OCCMClases.ExecutionResult UpdateAccountInformation(String jsonPersonalData, String inputAccountId)
	
	
	OCCMClases.ExecutionResult SendMigrationAccount(OCCMClases.AccountSummary inputAccountSummary, String inputAccountId)
	OCCMClases.ExecutionResult SendsIsNewBusinessModelAccountRequest(String inputAccountId)
	
	OCCMClases.ExecutionResult CreateOccmPurchase(OCCMClases.OCCMPurchase inputPurchase, String inputOpportunityId)
	OCCMClases.ExecutionResult UpdateInvoiceLeadInformation(String jsonPersonalData, String inputLeadId)
	
	OCCMClases.ExecutionResult DeleteListProductsInOpportunity(String quoteId)
	OCCMClases.ExecutionResult DeleteListProductsInQuote(String quoteId){

	
	
	UpdateSalesforceIdLeadAccountOCCM
	
	*/
	
	public static OCCMClases.ExecutionResult SendGetContractedPackages(OCCMClases.AccountSummary inputAccountSummary)
	{
		system.debug('BZF2:');
		OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult(false,'',null);
		OCCMClases.WsExecutionResult wsExecutionResult=new OCCMClases.WsExecutionResult(false,'','');
	    String inputAccountSummaryJson=JSON.serialize(inputAccountSummary);
	    system.debug('inputAccountSummaryJson:' + inputAccountSummaryJson);
	    String resultWS='';
		try{
	    	RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			if (!Test.isRunningTest())
			{
   				resultWS=ws.GetContractedPackages(inputAccountSummaryJson);
   				//resultWS='[{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":20,"ContractServiceId":89444,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-7X","PackageId":384,"PackageName":"Plan de 100 Reportes Adicionales de Perfil Conductual (PDA)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":20,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":9,"ContractServiceId":89445,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1CMicro","PackageId":464,"PackageName":"Cortesía Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":61,"ServiceName":"Cortesía de Publicación de vacantes en Plan Mensual","ServiceType":2,"UsedItems":1,"ValidityType":"Mes"}]';
   				//resultWS='[{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":20,"ContractServiceId":89444,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-7X","PackageId":384,"PackageName":"Plan de 100 Reportes Adicionales de Perfil Conductual (PDA)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":20,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":9,"ContractServiceId":89445,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1CMicro","PackageId":464,"PackageName":"Cortesía Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":61,"ServiceName":"Cortesía de Publicación de vacantes en Plan Mensual","ServiceType":2,"UsedItems":1,"ValidityType":"Mes"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":100,"ContractServiceId":89446,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1Micro","PackageId":601,"PackageName":"Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":100,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":146,"ServiceName":"Publicación de vacantes incluidas en Plan Mensual","ServiceType":2,"UsedItems":0,"ValidityType":"Mes"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":3000,"ContractServiceId":89447,"ExpirationDate":"2013-09-06 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1Micro","PackageId":601,"PackageName":"Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":3000,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":148,"ServiceName":"Consulta de datos personales incluidas en Plan Mensual","ServiceType":2,"UsedItems":0,"ValidityType":"Mes"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":10,"ContractServiceId":89448,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1Micro","PackageId":601,"PackageName":"Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":152,"ServiceName":"Consulta de Reportes PDA incluidas en Plan Mensual","ServiceType":2,"UsedItems":0,"ValidityType":"Mes"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":100,"ContractServiceId":89399,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-1I","PackageId":213,"PackageName":"Plan Elite Anual 5","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":100,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":1000,"ContractServiceId":89400,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-1I","PackageId":213,"PackageName":"Plan Elite Anual 5","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":1000,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":20,"ServiceName":"Consulta de datos personales en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":10,"ContractServiceId":89401,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-1I","PackageId":213,"PackageName":"Plan Elite Anual 5","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":10,"ContractServiceId":89402,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-2Y","PackageId":599,"PackageName":"CORTESIA DE VACANTES DE PAQUETE L","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":33,"ServiceName":"Cortesía de Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":100,"ContractServiceId":89403,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-2Y","PackageId":599,"PackageName":"CORTESIA DE VACANTES DE PAQUETE L","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":100,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":35,"ServiceName":"Cortesía de Consulta de datos personales en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-09 23:02:50","AvailableItems":1,"ContractServiceId":89404,"ExpirationDate":"2014-05-09 23:02:50","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-09 23:02:50","PackageCode":"PACKOFR10-2Y","PackageId":599,"PackageName":"CORTESIA DE VACANTES DE PAQUETE L","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430506,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064550","ServiceId":39,"ServiceName":"Cortesía de Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-03-14 14:22:57","AvailableItems":0,"ContractServiceId":86998,"ExpirationDate":"2014-03-14 14:22:57","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-04-04 17:41:55","PackageCode":"PACKOFR10-1-60D","PackageId":136,"PackageName":"Paquete de Vacantes (Vig. 60 dias)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":428938,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasIT","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":1,"ValidityType":"Meses"},{"ActivationDate":"2013-03-14 14:22:57","AvailableItems":10,"ContractServiceId":86999,"ExpirationDate":"2014-03-21 14:22:57","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-04-04 17:41:55","PackageCode":"PACKOFR10-1-60D","PackageId":136,"PackageName":"Paquete de Vacantes (Vig. 60 dias)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":428938,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasIT","ServiceId":20,"ServiceName":"Consulta de datos personales en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-03-14 14:22:57","AvailableItems":1,"ContractServiceId":87000,"ExpirationDate":"2014-03-14 14:22:57","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-04-04 17:41:55","PackageCode":"PACKOFR10-1-60D","PackageId":136,"PackageName":"Paquete de Vacantes (Vig. 60 dias)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":428938,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasIT","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-03-08 20:06:50","AvailableItems":0,"ContractServiceId":85191,"ExpirationDate":"2013-04-08 20:06:50","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-04-11 10:52:59","PackageCode":"PACKOFR10-10NB","PackageId":483,"PackageName":"Plan Básico Empresarial Mensual 10 Vacantes","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":427773,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":47,"ServiceName":"Publicación de vacantes en Plan Mensual","ServiceType":2,"UsedItems":10,"ValidityType":"Mes"},{"ActivationDate":"2013-03-08 20:06:50","AvailableItems":386,"ContractServiceId":85192,"ExpirationDate":"2013-04-15 20:06:50","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-04-11 10:52:59","PackageCode":"PACKOFR10-10NB","PackageId":483,"PackageName":"Plan Básico Empresarial Mensual 10 Vacantes","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":427773,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":400,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":49,"ServiceName":"Consulta de datos personales en Plan Mensual","ServiceType":2,"UsedItems":14,"ValidityType":"Mes"},{"ActivationDate":"2013-03-08 20:06:50","AvailableItems":1,"ContractServiceId":85193,"ExpirationDate":"2013-04-08 20:06:50","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-04-11 10:52:59","PackageCode":"PACKOFR10-10NB","PackageId":483,"PackageName":"Plan Básico Empresarial Mensual 10 Vacantes","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":427773,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":53,"ServiceName":"Consulta de Reportes PDA en Plan Mensual","ServiceType":2,"UsedItems":0,"ValidityType":"Mes"},{"ActivationDate":"2013-02-20 16:26:38","AvailableItems":1,"ContractServiceId":78935,"ExpirationDate":"2014-02-20 16:26:38","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-02-20 16:26:38","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":423025,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-02-20 16:26:38","AvailableItems":10,"ContractServiceId":78936,"ExpirationDate":"2014-02-20 16:26:38","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-02-20 16:26:38","PackageCode":"PACKOFR10-5P","PackageId":324,"PackageName":"CORTESIA DE PLAN DE VACANTES G","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":423025,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-02-20 16:06:17","AvailableItems":92,"ContractServiceId":78923,"ExpirationDate":"2014-02-20 16:06:17","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-02-20 16:06:17","PackageCode":"PACKOFR10-4G","PackageId":284,"PackageName":"CORTESIA DE PAQUETE DE 3 DATOS DE CONTACTO","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":423015,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":100,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Pruebas TI","ServiceId":20,"ServiceName":"Consulta de datos personales en Plan Anual","ServiceType":2,"UsedItems":8,"ValidityType":"Meses"},{"ActivationDate":"2013-01-30 12:42:47","AvailableItems":1,"ContractServiceId":71755,"ExpirationDate":"2014-01-30 12:42:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-01-30 12:42:47","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":416904,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-01-30 12:42:47","AvailableItems":1,"ContractServiceId":71756,"ExpirationDate":"2014-01-30 12:42:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-01-30 12:42:47","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":416904,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-01-30 12:40:25","AvailableItems":1,"ContractServiceId":71749,"ExpirationDate":"2013-01-30 12:44:29","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-01-30 12:41:08","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":416900,"PurchaseStateDescription":"Cancelado","PurchaseStateId":4,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-01-30 12:40:25","AvailableItems":1,"ContractServiceId":71750,"ExpirationDate":"2013-01-30 12:44:29","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-01-30 12:41:08","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":416900,"PurchaseStateDescription":"Cancelado","PurchaseStateId":4,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-21 16:57:58","AvailableItems":60,"ContractServiceId":58852,"ExpirationDate":"2013-12-21 16:57:58","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-21 16:57:58","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":406426,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":60,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas IT","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-21 16:57:58","AvailableItems":571,"ContractServiceId":58853,"ExpirationDate":"2013-12-21 16:57:58","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-21 16:57:58","PackageCode":"PACKOFR10-2S","PackageId":244,"PackageName":"CORTESIA DE VACANTES DE PAQUETE C","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":406426,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":600,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas IT","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":29,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 18:56:47","AvailableItems":0,"ContractServiceId":58597,"ExpirationDate":"2013-12-20 18:56:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 18:56:47","PackageCode":"PACKOFR10-5","PackageId":124,"PackageName":"Paquete 5 Vacantes","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":406185,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":5,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":5,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 18:56:47","AvailableItems":1,"ContractServiceId":58598,"ExpirationDate":"2013-12-20 18:56:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 18:56:47","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":406185,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 18:55:00","AvailableItems":0,"ContractServiceId":58595,"ExpirationDate":"2013-12-20 18:55:00","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 18:55:00","PackageCode":"PACKOFR10-10","PackageId":125,"PackageName":"Paquete 10 Vacantes","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":406184,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":10,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 18:55:00","AvailableItems":1,"ContractServiceId":58596,"ExpirationDate":"2013-12-20 18:55:00","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 18:55:00","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":406184,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 10:54:33","AvailableItems":0,"ContractServiceId":58402,"ExpirationDate":"2013-12-20 10:54:33","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 10:54:33","PackageCode":"PACKOFR10-10","PackageId":125,"PackageName":"Paquete 10 Vacantes","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":405993,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":10,"ValidityType":"Meses"},{"ActivationDate":"2012-12-20 10:54:33","AvailableItems":1,"ContractServiceId":58403,"ExpirationDate":"2013-12-20 10:54:33","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-20 10:54:33","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":405993,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas TI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-18 11:46:48","AvailableItems":1,"ContractServiceId":57889,"ExpirationDate":"2013-12-18 11:46:48","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-18 11:46:48","PackageCode":"PACKOFDESTR11-1","PackageId":183,"PackageName":"Paquete Vacantes Destacadas","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":405546,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Pruebas","ServiceId":23,"ServiceName":"Vacantes Destacadas en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-18 11:46:48","AvailableItems":1,"ContractServiceId":57890,"ExpirationDate":"2013-12-18 11:46:48","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-18 11:46:48","PackageCode":"PACKOFPREMR11-1","PackageId":184,"PackageName":"Vacante Premium","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":405546,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Pruebas","ServiceId":24,"ServiceName":"Vacantes Premium en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-18 11:46:48","AvailableItems":1,"ContractServiceId":57891,"ExpirationDate":"2013-12-18 11:46:48","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-18 11:46:48","PackageCode":"PACKOFDPR11-1","PackageId":229,"PackageName":"Paquete Vacantes Destacadas Premium","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":405546,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Pruebas","ServiceId":25,"ServiceName":"Vacantes Destacadas Premium en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-13 14:11:51","AvailableItems":0,"ContractServiceId":57226,"ExpirationDate":"2013-09-01 14:11:51","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-13 14:11:51","PackageCode":"PACKOFR10-10","PackageId":125,"PackageName":"Paquete 10 Vacantes","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":404921,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":10,"ValidityType":"Meses"},{"ActivationDate":"2012-12-13 14:11:51","AvailableItems":1,"ContractServiceId":57227,"ExpirationDate":"2013-09-01 14:11:51","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-13 14:11:51","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":404921,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"PruebasTI","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-05 10:32:25","AvailableItems":1,"ContractServiceId":55465,"ExpirationDate":"2013-12-05 10:32:25","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-05 10:32:25","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403490,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"ActivConsola","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-05 10:32:25","AvailableItems":0,"ContractServiceId":55466,"ExpirationDate":"2013-12-05 10:32:25","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-05 10:32:25","PackageCode":"PACKOFR10-A","PackageId":188,"PackageName":"Plan de vacantes A","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403490,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"ActivConsola","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":10,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:50:19","AvailableItems":1,"ContractServiceId":55185,"ExpirationDate":"2012-12-30 10:50:19","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:50:19","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403252,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:50:19","AvailableItems":1,"ContractServiceId":55186,"ExpirationDate":"2012-12-30 10:50:19","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:50:19","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403252,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:45:15","AvailableItems":1,"ContractServiceId":55182,"ExpirationDate":"2012-12-30 10:45:15","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:45:15","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403250,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:45:15","AvailableItems":1,"ContractServiceId":55183,"ExpirationDate":"2012-12-30 10:45:15","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:45:15","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403250,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:41:47","AvailableItems":1,"ContractServiceId":55180,"ExpirationDate":"2012-12-30 10:41:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:41:48","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403249,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-12-04 10:41:48","AvailableItems":1,"ContractServiceId":55181,"ExpirationDate":"2012-12-30 10:41:48","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-12-04 10:41:48","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":403249,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"SALE04","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-11-27 14:18:41","AvailableItems":0,"ContractServiceId":53661,"ExpirationDate":"2013-11-27 14:18:41","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-11-27 14:18:41","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":402047,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":1,"ValidityType":"Meses"},{"ActivationDate":"2012-11-27 14:18:41","AvailableItems":1,"ContractServiceId":53662,"ExpirationDate":"2013-11-27 14:18:41","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-11-27 14:18:41","PackageCode":"PACKPDAR11-1","PackageId":185,"PackageName":"Paquete de Reportes PDA","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":402047,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"pruebas","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2012-11-27 14:16:47","AvailableItems":0,"ContractServiceId":53659,"ExpirationDate":"2013-11-27 14:16:47","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2012-11-27 14:16:47","PackageCode":"PACKOFR10-1","PackageId":117,"PackageName":"Paquete 1 Vacante","PaymentMethodId":3,"PaymentMethodName":"DineroMail","PurchaseId":402045,"PurchaseStateDescription":"Autorizado","PurchaseStateId":3,"PurchasedItems":1,"RecruiterId":"xmxjavier352x","SalesforceDocument":"prueba","ServiceId":19,"ServiceName":"Publicación de vacantes en Plan Anual","ServiceType":2,"UsedItems":1,"ValidityType":"Meses"}]';
   				//resultWS='{"success":true,"message":"La empresa ya se encuentra migrada.","objectResult":"No se ecuenta[{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":20,"ContractServiceId":89444,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-7X","PackageId":384,"PackageName":"Plan de 100 Reportes Adicionales de Perfil Conductual (PDA)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":20,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":9,"ContractServiceId":89445,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1CMicro","PackageId":464,"PackageName":"Cortesía Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":61,"ServiceName":"Cortesía de Publicación de vacantes en Plan Mensual","ServiceType":2,"UsedItems":1,"ValidityType":"Mes"}]"}';
   				wsExecutionResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
   				//system.debug('Resultado:' + resultWS);
   				system.debug('Resultado:' + wsExecutionResult.objectResult);

   				if (wsExecutionResult !=null && !String.isBlank(wsExecutionResult.objectResult)){
   				//if (!String.isBlank(resultWS)){
   					executedStatusResult=new OCCMClases.ExecutionResult(true,'Satisfactorio',(List<OCCMClases.ContractSummary>) System.JSON.deserialize(wsExecutionResult.objectResult, List<OCCMClases.ContractSummary>.class));
   					//executedStatusResult=new OCCMClases.ExecutionResult(true,'Satisfactorio',(List<OCCMClases.ContractSummary>) System.JSON.deserialize(resultWS, List<OCCMClases.ContractSummary>.class));
   				}
   				else
   				{
   					executedStatusResult=new OCCMClases.ExecutionResult(false,'Sin paquetes contratados',null);
   				}

   				system.debug('contractSummary:');
			}
			else
			{
   				resultWS='[{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":20,"ContractServiceId":89444,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":12,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-7X","PackageId":384,"PackageName":"Plan de 100 Reportes Adicionales de Perfil Conductual (PDA)","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":20,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":22,"ServiceName":"Consulta de Reportes PDA en Plan Anual","ServiceType":2,"UsedItems":0,"ValidityType":"Meses"},{"ActivationDate":"2013-05-31 17:53:07","AvailableItems":9,"ContractServiceId":89445,"ExpirationDate":"2013-08-30 17:53:07","ExpirationPeriod":1,"IdValidityType":2,"LastUpdatedDate":"2013-05-23 17:53:07","PackageCode":"PACKOFR10-1CMicro","PackageId":464,"PackageName":"Cortesía Plan Básico PyME Mensual 1 Vacante","PaymentMethodId":4,"PaymentMethodName":"Contado","PurchaseId":430568,"PurchaseStateDescription":"En tránsito","PurchaseStateId":7,"PurchasedItems":10,"RecruiterId":"xmxjavier352x","SalesforceDocument":"Folio-000064736","ServiceId":61,"ServiceName":"Cortesía de Publicación de vacantes en Plan Mensual","ServiceType":2,"UsedItems":1,"ValidityType":"Mes"}]';
   				List<OCCMClases.ContractSummary> contractSummary= (List<OCCMClases.ContractSummary>) System.JSON.deserialize(resultWS, List<OCCMClases.ContractSummary>.class);
   				executedStatusResult=new OCCMClases.ExecutionResult(true,'Satisfactorio',(List<OCCMClases.ContractSummary>) System.JSON.deserialize(resultWS, List<OCCMClases.ContractSummary>.class));
   				system.debug('wsExecutionResult:' + resultWS);
			}
		}
        catch(JSONException e)
		{
			executedStatusResult=new OCCMClases.ExecutionResult(false,'Exepcion SendGetContractedPackages error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString(),null);
        	//system.debug(messageResult);
		}
		system.debug('executedStatusResult:' + executedStatusResult);
		return executedStatusResult;
	}

	/// <summary> Metodo de envio de cuenta a recluta, se envia el Id de la cuenta a enviar, internamente se busca el AccountId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    public static OCCMClases.ExecutionResult DeleteListProductsInOpportunity(String quoteId){
    	//system.debug('quoteId:' + quoteId );
    	String result='';// 'Error en proceso: ' + 'quoteId:' + quoteId;
		Quote presupuesto= new Quote();
		OpportunityLineItem[] productosOportunidad;
		Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        String mensaje='';
        //Recupera el Id de presupuesto
		try
		{
			presupuesto = [SELECT Id, Name, OpportunityId FROM Quote WHERE Id =: quoteId];
		}
		catch(Exception e)
		{
			//system.debug('Error al recuperar la información del presupuesto. ' + e.getMessage());
			messageResult +='Exepcion DeleteListProductsInOpportunity presupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		//Si no es vacio el presupuesto elimina los productos que tenga la oportunidad
		if (presupuesto!=null){
			//Si no es vacio recupera los productos de la oportunidad
			try 
		    {
				productosOportunidad = [SELECT Id, OpportunityId, PricebookEntryId, PricebookEntry.Name, PricebookEntry.ProductCode, Quantity, UnitPrice
								FROM OpportunityLineItem 
								WHERE OpportunityId =: presupuesto.OpportunityId];  	
		    }
		    catch(Exception e)
			{
		        messageResult +='Exepcion DeleteListProductsInOpportunity productosOportunidad error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
			}
			//Si no es valcia la la lista de productos de la oportunidad entonces elimina los productos
			if (productosOportunidad!=null){
				mensaje= Funciones.GetMessageErrorFromDeleteDML(Database.delete(productosOportunidad));
				if (!String.isBlank(mensaje)){
					messageResult = mensaje;
				}
				else
				{
					successResult=true;
				}
			}
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
    }
	/// <summary> Metodo de envio de cuenta a recluta, se envia el Id de la cuenta a enviar, internamente se busca el AccountId y  
    /// 		  se envia la informacion a OCCM para su validacion y registro.
    /// </summary>
    /// <param name="inputAccountId">Id de la cuenta que se va a enviar.</param>
    /// <returns>}regresa el mensaje de error que se genera al ejecutar el procedimiento, si no existe error se regresa vacio 
    /// </returns>
    public static OCCMClases.ExecutionResult DeleteListProductsInQuote(String quoteId){
    	//system.debug('quoteId:' + quoteId );
    	String result='';// 'Error en proceso: ' + 'quoteId:' + quoteId;
		Quote presupuesto;
		QuoteLineItem[] productosPresupuesto;
		Boolean successResult=false;
        String messageResult='';
        Object objectResult=null;
        OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
        //Recupera el Id de presupuesto
		try
		{
			presupuesto = [SELECT Id, Name, OpportunityId FROM Quote WHERE Id =: quoteId];
		}
		catch(Exception e)
		{
			//system.debug('Error al recuperar la información del presupuesto. ' + e.getMessage());
			messageResult +='Exepcion DeleteListProductsInOpportunity presupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		//Si no es vacio el presupuesto elimina los productos que tenga la oportunidad
		if (presupuesto!=null){
			//Si no es vacio recupera los productos de la oportunidad
			//system.debug('Obtiene producto presupuesto');
			//Recupera los productos del presupuesto
			try 
		    {
				productosPresupuesto = [Select q.QuoteId, q.PricebookEntry.ProductCode, q.PricebookEntry.Name, q.PricebookEntryId, q.Id 
											From QuoteLineItem q
											where q.QuoteId =:presupuesto.Id];  	
		    }
		    catch(Exception e)
			{
		        messageResult +='Exepcion DeleteListProductsInQuote productosPresupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
			}
			
			if (productosPresupuesto!=null){
				List<QuoteLineItem> productosEliminar1 =  new List<QuoteLineItem>();
				//system.debug('Producto presupuesto no es nulo');
				//Se realiza la busqueda de productos que terminen con letra para eliminarlo de la lista
				for(QuoteLineItem quoteTemp : productosPresupuesto)
				{
					String productoCode=quoteTemp.PricebookEntry.ProductCode;
					//system.debug('productoCode: ' + productoCode);
					String lastChar= productoCode.substring(productoCode.length() -1, productoCode.length());
					//system.debug('lastChar: ' + lastChar);
					if (!lastChar.isNumeric()){
						productosEliminar1.add(quoteTemp);
						//delete quoteTemp;
						//system.debug('lastChar no es numerico');
					}
				}
				if (productosEliminar1!=null){
					String mensaje= Funciones.GetMessageErrorFromDeleteDML(Database.delete(productosEliminar1));
					if (!String.isBlank(mensaje)){
						messageResult = mensaje;
					}
					else
					{
						successResult=true;
					}
				}
			}
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
    }
	
	/// <summary> Metodo que realiza la conexion al ws, pasa credenciales y regresa el objeto con la informacion del ws listo para consumir el metodo que se necesita  
    /// </summary>
    /// <param name=""></param>
    /// <returns>Objeto instancia del web service, internamente se asigna la autentificacion en un solo paso o nulo si existe un error en validacion 
    /// </returns>
    public static RecruiterDataService.RecruiterDataServiceSoap CreateConectionWebService(){
    	RecruiterDataService.RecruiterDataServiceSoap ws = new RecruiterDataService.RecruiterDataServiceSoap();
		RecruiterDataService.AuthHeader objAuthHeader=new RecruiterDataService.AuthHeader();
		Logins_Webservice_OCCM__c cs1 = Logins_Webservice_OCCM__c.getInstance('OCCM');
		if (cs1 !=null){
			objAuthHeader.UserName=cs1.Nombre_de_usuario__c;
			objAuthHeader.Password=cs1.Contrasena__c;
		}
		ws.AuthHeader=objAuthHeader;
		ws.timeout_x = 59000; //igual a 59 segundos, el maximo son 60 segundos, default, son 10 segundos
		return ws;
    }
    
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo de migracion de cuentas
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la creacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult SendMigrationAccount(OCCMClases.AccountSummary inputAccountSummary, String inputAccountId)
	{
		//system.debug('SendMigrationAccount inputAccountId:' + inputAccountId);
		//system.debug('SendMigrationAccount inputAccountSummary:' + inputAccountSummary);
		OCCMClases.AccountSummary AccountSummaryInfo=null;
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    String inputAccountSummaryJson=JSON.serialize(inputAccountSummary);
	    system.debug('inputAccountSummaryJson:' + inputAccountSummaryJson);
	    //List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    OCCMClases.WsExecutionResult wsExecutionResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult inputExecutedResult=new OCCMClases.ExecutionResult();
	    inputExecutedResult = new OCCMClases.ExecutionResult(true, '', inputAccountSummaryJson);
	    String stringOccmAccountSummary = JSON.serialize(inputExecutedResult);
	    system.debug('stringOccmAccountSummary: ' + stringOccmAccountSummary);
	    String resultWS;
	    Boolean resultExecution=false;
		try{	
			//system.debug('AntesresultWS: ' + resultWS);
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			if (!Test.isRunningTest())
			{
   				resultWS=ws.MigrateAccount(stringOccmAccountSummary);
   				system.debug('wsExecutionResult:' + resultWS);
   				wsExecutionResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
   				//system.debug('wsExecutionResult.message:' + wsExecutionResult.message);
			}
			else
			{
   				resultWS= '{"success":true,"message":"Empresa Migrada con exito","objectResult":"' + stringOccmAccountSummary + '"}';
   				wsExecutionResult.success=true;
   				wsExecutionResult.message='Empresa registrada con exito';
   				wsExecutionResult.objectResult=stringOccmAccountSummary;
			}
			//system.debug('resultWS: ' + resultWS);
			//successResult=false;
			if (wsExecutionResult.success==false){
				//successResult=false;
				//system.debug('Entre a metodo falso:');
				if (wsExecutionResult.objectResult==null)
				{
					//system.debug('ObjectResult null:');
					messageResult += wsExecutionResult.message;
					//system.debug('messageResult validacion falsa:' + messageResult);
				}
				else
				{
					//system.debug('ObjectResult tiene lista de errores:');
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutionResult.objectResult));
				}
			}
			else{
				//system.debug('El resultado del webservice es true');
				Account acc;
				try 
			    {
			    	//Agregar campo para insertar la fecha en que se envio a OCCM y cambiarla al envio
			    	//Se agregara una opcion que diga Enviada para determinar que la oportunidad y ase envio a inventario en transito
			    	//Validar que exista la opcion en el codigo
					acc = [Select a.OCCM_Cuenta_Administradora__c, a.OCCM_Password_Cuenta_Administradora__c, a.Id, a.Name,a.Phone, a.Migracion_a_modelo_de_paquetes__c 
								From Account a
								WHERE Id =: inputAccountId LIMIT 1];
					//system.debug('Encontre cuenta para actualizar');   	
			    }
			    catch(Exception e)
				{
			        	messageResult +='Exepcion EnviarOportunidadOCCM opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
				}
				if (acc !=null){
					try 
			    	{
			    		String companySummaryDataString='';
						companySummaryDataString= wsExecutionResult.objectResult;
						//Deserealizar el objeto
						//system.debug('WsExecutedStatusResult.objectResult:' + wsExecutionResult.objectResult);
						OCCMClases.CompanySummaryString companySummaryInfo= (OCCMClases.CompanySummaryString) System.JSON.deserialize(companySummaryDataString, OCCMClases.CompanySummaryString.class);
			    		//companySummaryInfo=(OCCMClases.CompanySummaryString)WsExecutedStatusResult.objectResult; 
			    		if (!Test.isRunningTest())
						{
			   				acc.OCCM_Cuenta_Administradora__c = companySummaryInfo.ManagerAccountId;
							acc.OCCM_Password_Cuenta_Administradora__c = companySummaryInfo.Password;
						}
						else
						{
							//Se agregan datos ficticios en la cuenta
			   				acc.OCCM_Cuenta_Administradora__c = 'xmxkirikix';
							acc.OCCM_Password_Cuenta_Administradora__c ='pswkir'; 
						}
			    		acc.Migracion_a_modelo_de_paquetes__c = Date.today();
						List<Account> accToUpdate = new List<Account>();
						//system.debug('Actualizo cuenta');
						accToUpdate.add(acc);
						//Validacion de guardado
						if (accToUpdate!=null){
							//system.debug('Mando actualizar cuenta');
							String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(accToUpdate, false));
							if (!String.isBlank(mensaje)){
								messageResult += mensaje;
							}
							else
							{
								successResult=true;
							}	
							system.debug('Resultado de actualizacion' + successResult + ' Mensaje:' + messageResult);
						}
			    	}
			    	catch(Exception e)
					{
			        	messageResult +='Exepcion SendMigrationAccount opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
					}
					
				}
				//system.debug('Estatus migracion: ' + messageResult);
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion CreateOccmLead error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		//system.debug('messageResultRegreso:' + messageResult);
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo de IsNewBusinessModelAccount
    /// validando que la cuenta este migrada al nuevo modelo
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la creacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult SendsIsNewBusinessModelAccountRequest(String inputAccountId)
	{
		//system.debug('SendMigrationAccount:' + inputAccountId);
		if (inputAccountId.length()==15){
			//try{   
				ID sID = inputAccountId;
				inputAccountId=sID;   
				// if we get here, it's a valid ID and the sID field is an 18 character one
			//} catch (System.StringException e){   
					// if it goes here, it's not an ID. Do something if you need to.
			//}
		}
		system.debug('SendMigrationAccountFixed:' + inputAccountId);
		//OCCMClases.CompanySummaryString companySummaryInfo=null;
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.wsExecutionResult wsExecutionResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult ExecutedStatusResult=new OCCMClases.ExecutionResult();
	    String resultWS;
	    Boolean resultExecution=false;
		List<OCCMClases.Error> errorsList= new List<OCCMClases.Error>();
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			if (!Test.isRunningTest())
			{
   				resultWS=ws.IsNewBusinessModelAccount(inputAccountId);
   				wsExecutionResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
			}
			else
			{
   				resultWS= '{"success":true,"message":"Empresa registrada con exito","objectResult":"' + inputAccountId + '"}';
   				wsExecutionResult.success=true;
   				wsExecutionResult.message='Empresa registrada con exito';
   				wsExecutionResult.objectResult=inputAccountId;
			}
			//system.debug('ResultWS' + resultWS);
			
			successResult=false;
			//system.debug('ya deserealizo el objeto' + WsExecutedStatusResult.objectResult);
			//messageResult=wsExecutedStatusResult.message;
			if (wsExecutionResult.success==false){
				successResult=false;
				if (wsExecutionResult.objectResult==null)
				{
					messageResult +=wsExecutionResult.message;
				}
				else
				{
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutionResult.objectResult));
				}
				//system.debug('messageResult:' + messageResult);
			}
			else{
				//system.debug('El resultado del webservice es true');
				Account acc;
				try 
			    {
					acc = [Select a.OCCM_Cuenta_Administradora__c, a.OCCM_Password_Cuenta_Administradora__c, a.Id, a.Name,a.Phone 
								From Account a
								WHERE Id =: inputAccountId LIMIT 1];   	
			    }
			    catch(Exception e)
				{
			        	messageResult +='Exepcion SendsIsNewBusinessModelAccountRequest acc error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
				}
				if (acc !=null){
					try 
			    	{
			    		String companySummaryDataString='';
						companySummaryDataString= wsExecutionResult.objectResult;
						//Deserealizar el objeto
						OCCMClases.CompanySummaryString companySummaryInfo= (OCCMClases.CompanySummaryString) System.JSON.deserialize(companySummaryDataString, OCCMClases.CompanySummaryString.class); 
			    		if (!Test.isRunningTest())
						{
			   				acc.OCCM_Cuenta_Administradora__c = companySummaryInfo.ManagerAccountId;
							acc.OCCM_Password_Cuenta_Administradora__c = companySummaryInfo.Password;
						}
						else
						{
							acc.OCCM_Cuenta_Administradora__c = 'xmxkirikix';
							acc.OCCM_Password_Cuenta_Administradora__c ='pswkir'; 
						}
						acc.Migracion_a_modelo_de_paquetes__c=Date.today();
			    		//system.debug('Voy a actualizar la cuenta');
						List<Account> accToUpdate = new List<Account>();
						accToUpdate.add(acc);
						//Validacion de guardado
						String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(accToUpdate, false));
						if (!String.isBlank(mensaje)){
							messageResult = mensaje;
						}
						else
						{
							successResult=true;
						}	
			    	}
			    	catch(Exception e)
					{
			        	messageResult +='Exepcion SendMigrationAccount opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
					}
				}
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion SendsIsNewBusinessModelAccountRequest error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo de contratacion de paquetes
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la creacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult CreateOccmPurchase(OCCMClases.OCCMPurchase inputPurchase, String inputOpportunityId)
	{
		//system.debug('CreateOccmPurchase:' + inputOpportunityId);
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.ExecutionResult returnedExecutedStatusResult=new OCCMClases.ExecutionResult();
	    OCCMClases.WsExecutionResult wsExecutionResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult inputExecutedResult=new OCCMClases.ExecutionResult();
	    String inputPurchaseJson=JSON.serialize(inputPurchase);
	    //system.debug('inputPurchaseJson:' + inputPurchaseJson);
	    inputExecutedResult = new OCCMClases.ExecutionResult(true, '', inputPurchaseJson);
	    String stringOccmPurchase = JSON.serialize(inputExecutedResult);
	    system.debug('stringOccmPurchase: ' + stringOccmPurchase);
	    String resultWS;
	    Boolean resultExecution=false;
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			system.debug('inputPurchase:' + inputPurchase);
			system.debug('stringOccmPurchase:' + stringOccmPurchase);
			if (!Test.isRunningTest())
			{
   				resultWS=ws.ContractServices(stringOccmPurchase);
   				wsExecutionResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);	
			}
			else
			{
				   wsExecutionResult.success=true;
				   wsExecutionResult.message='';
				   wsExecutionResult.objectResult = inputPurchaseJson;
			}
			//system.debug('ResultWS' + resultWS);
			//wsExecutedStatusResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
			successResult=false;
			//messageResult=wsExecutedStatusResult.message;
			if (wsExecutionResult.success==false){
				successResult=false;
				if (wsExecutionResult.objectResult==null)
				{
					messageResult += wsExecutionResult.message;
				}
				else
				{
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutionResult.objectResult));
				}
				//System.debug('messageResult:' + messageResult);
			}
			else{
				//system.debug('El resultado del webservice es true');
				Opportunity opp;
				try 
			    {
			    	//Agregar campo para insertar la fecha en que se envio a OCCM y cambiarla al envio
			    	//Se agregara una opcion que diga Enviada para determinar que la oportunidad y ase envio a inventario en transito
			    	//Validar que exista la opcion en el codigo
					opp = [Select EstatusFactura__c, Fecha_de_envio_de_paquetes_OCCM__c
								From Opportunity o
								WHERE Id =: inputOpportunityId 
								LIMIT 1];    	
			    }
			    catch(Exception e)
				{
			        	messageResult +='Exepcion EnviarOportunidadOCCM opp error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString();
				}
				if (opp !=null){
					opp.EstatusFactura__c ='En transito';
					opp.Fecha_de_envio_de_paquetes_OCCM__c=Date.today();
					List<Opportunity> oppsToUpdate = new List<Opportunity>();
					oppsToUpdate.add(opp);
					String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(oppsToUpdate, false));
					if (!String.isBlank(mensaje)){
						messageResult = mensaje;
					}
					else
					{
						successResult=true;
					}	
				}
				//system.debug('Estatus factura: ' + messageResult);
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion CreateOccmLead error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		returnedExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return returnedExecutedStatusResult;
	}
	
    /// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo de generacion de cuentas
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la creacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult CreateOccmLead(String jsonPersonalData, String inputLeadId)
	{
		//system.debug('jsonPersonalData:' + jsonPersonalData);
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.WsExecutionResult wsExecutedStatusResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    String resultWS;
	    Boolean resultExecution=false;
		OCCMClases.PersonalData ps=new OCCMClases.PersonalData();
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			system.debug('JSONDataInput:' + jsonPersonalData);
			if (!Test.isRunningTest())
			{
   				resultWS=ws.CreateAccountCompany(jsonPersonalData);
   				wsExecutedStatusResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
   				system.debug('ResultWS' + resultWS);
			}
			else
			{
   				resultWS= '{"success":true,"message":"Empresa registrada con exito","objectResult":"' + jsonPersonalData + '"}';
   				wsExecutedStatusResult.success=true;
   				wsExecutedStatusResult.message='Empresa registrada con exito';
   				wsExecutedStatusResult.objectResult=jsonPersonalData;
			}
			//system.debug('ResultWS' + resultWS);
			
			successResult=false;
			//messageResult=wsExecutedStatusResult.message;
			if (wsExecutedStatusResult.success==false){
				if (wsExecutedStatusResult.objectResult==null)
				{
					messageResult += wsExecutedStatusResult.message;
				}
				else
				{
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				}
			}
			else{
				//system.debug('El resultado del webservice es true');
				String PersonalDataString='';
				PersonalDataString= wsExecutedStatusResult.objectResult;
				OCCMClases.PersonalData personalDataFromDotNet= (OCCMClases.PersonalData) System.JSON.deserialize(PersonalDataString, OCCMClases.PersonalData.class);
				if (Test.isRunningTest())
				{
					personalDataFromDotNet.ManagerAccount='xmxrunningtx';
					personalDataFromDotNet.PasswordManagerAccount='pswrun';
				}
				//system.debug('ManagerAccount:' + personalDataFromDotNet.ManagerAccount);
				if (!(personalDataFromDotNet.ManagerAccount=='' || personalDataFromDotNet.ManagerAccount=='null' || personalDataFromDotNet.ManagerAccount==null)){
					Lead lead=null;
					lead = [SELECT Id, OCCM_Cuenta_Administradora__c, OCCM_Password_Cuenta_Administradora__c, Migracion_a_modelo_de_paquetes__c FROM Lead WHERE Id =: inputLeadId LIMIT 1];
					if (lead!=null){
						lead.OCCM_Cuenta_Administradora__c = personalDataFromDotNet.ManagerAccount;
						//lead.OCCM_Password_Cuenta_Administradora__c =personalDataFromDotNet.PasswordManagerAccount; 
						lead.Migracion_a_modelo_de_paquetes__c=date.today();
						List<Lead> leadsToUpdate = new List<Lead>();
						leadsToUpdate.add(lead);
						String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(leadsToUpdate, false));
						if (!String.isBlank(mensaje)){
							messageResult = mensaje;
						}
						else
						{
							successResult=true;
						}
					}
				}
				//system.debug('Sin errores:');
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion CreateOccmLead error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo de generacion de cuentas
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la creacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult CreateOccmAccount(String jsonPersonalData, String inputAccountId)
	{
		system.debug('jsonPersonalData:' + jsonPersonalData);
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.WsExecutionResult wsExecutedStatusResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    String resultWS;
	    Boolean resultExecution=false;
		OCCMClases.PersonalData ps=new OCCMClases.PersonalData();
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			
			if (!Test.isRunningTest())
			{
				system.debug('Entre antes de ejecutar WS:' + jsonPersonalData);
   				resultWS=ws.CreateAccountCompany(jsonPersonalData);
   				system.debug('resultWS:' + resultWS);
   				wsExecutedStatusResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);
			}
			else
			{
   				resultWS= '{"success":true,"message":"Creacion de prueba","objectResult":"' + jsonPersonalData + '"}';
   				wsExecutedStatusResult.success=true;
   				wsExecutedStatusResult.message='Empresa registrada con exito';
   				wsExecutedStatusResult.objectResult=jsonPersonalData;
			}
			//system.debug('ResultWS' + resultWS);
			
			successResult=false;
			//messageResult=wsExecutedStatusResult.message;
			
			if (wsExecutedStatusResult.success==false){
				system.debug('Success: False');
				//messageResult =	Funciones.GetMessageErrorFromListErrors(wsExecutedStatusResult.objectResult);
				if (wsExecutedStatusResult.objectResult==null)
				{
					system.debug('ObjectResult null:');
					messageResult += wsExecutedStatusResult.message;
					system.debug('messageResult validacion falsa:' + messageResult);
				}
				else
				{
					system.debug('ObjectResult tiene lista de errores:');
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				}
			}
			else{
				system.debug('El resultado del webservice es true');
				String PersonalDataString='';
				PersonalDataString= wsExecutedStatusResult.objectResult;
				OCCMClases.PersonalData personalDataFromDotNet= (OCCMClases.PersonalData) System.JSON.deserialize(PersonalDataString, OCCMClases.PersonalData.class);
				system.debug('ManagerAccount:' + personalDataFromDotNet.ManagerAccount);
				if (Test.isRunningTest())
				{
	   				personalDataFromDotNet.ManagerAccount='TestUser';
	   				personalDataFromDotNet.PasswordManagerAccount='Pass';
	   				
				}
				if (!String.isBlank(personalDataFromDotNet.ManagerAccount)) //	!(=='' || personalDataFromDotNet.ManagerAccount=='null' || personalDataFromDotNet.ManagerAccount==null))
				{
					Account account=null;
					account = [SELECT Id, OCCM_Cuenta_Administradora__c, OCCM_Password_Cuenta_Administradora__c, Migracion_a_modelo_de_paquetes__c FROM Account WHERE Id =: inputAccountId LIMIT 1];
					if (account!=null){
						account.OCCM_Cuenta_Administradora__c = personalDataFromDotNet.ManagerAccount;
						//account.OCCM_Password_Cuenta_Administradora__c =personalDataFromDotNet.PasswordManagerAccount;  
						account.Migracion_a_modelo_de_paquetes__c=date.today();
						List<account> leadsToUpdate = new List<account>();
						leadsToUpdate.add(account);
						String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(leadsToUpdate, false));
						if (!String.isBlank(mensaje)){
							messageResult = mensaje;
						}
						else
						{
							successResult=true;
						}
					}
				}
				//System.debug('Sin errores:');
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion CreateOccmAccount error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
        	//system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo para actualizar los datos fiscales del prospecto en OCCM
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la actualizacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult UpdateInvoiceLeadInformation(String jsonPersonalData, String inputLeadId)
	{
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.WsExecutionResult wsExecutedStatusResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    String resultWS;
	    Boolean resultExecution=false;
		OCCMClases.PersonalData ps=new OCCMClases.PersonalData();
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			if (!Test.isRunningTest())
			{
				//system.debug('jsonPersonalData: ' + jsonPersonalData);
   				resultWS=ws.UpdateInvoiceInformation(jsonPersonalData);
				//system.debug(resultWS);
				wsExecutedStatusResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);	
			}
			else
			{
   				wsExecutedStatusResult.success=true;
   				wsExecutedStatusResult.message='Proceso satisfactorio';
   				wsExecutedStatusResult.objectResult=jsonPersonalData;	
			}
			successResult=false;
			//messageResult=wsExecutedStatusResult.message;
			if (wsExecutedStatusResult.success==false){
				//messageResult =	Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				if (wsExecutedStatusResult.objectResult==null)
				{
					messageResult += wsExecutedStatusResult.message;
				}
				else
				{
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				}
			}
			else{
				String PersonalDataString=wsExecutedStatusResult.objectResult;
				OCCMClases.PersonalData personalDataFromDotNet= (OCCMClases.PersonalData) System.JSON.deserialize(PersonalDataString, OCCMClases.PersonalData.class);
				Lead lead=null;
				//system.debug('LeadId:'+inputLeadId);
				//system.debug('personalDataFromDotNet.SalesforceID:'+personalDataFromDotNet.SalesforceId);
				lead = [SELECT Id, Is_Future_Context__c FROM Lead WHERE Id =: inputLeadId LIMIT 1];
				if (lead!=null){
					lead.Is_Future_Context__c = true;
					List<Lead> leadsToUpdate = new List<Lead>();
					leadsToUpdate.add(lead);
					String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(leadsToUpdate, false));
					if (!String.isBlank(mensaje)){
							messageResult = mensaje;
					}
					else
					{
						successResult=true;
					}
				}
				//System.debug('Sin errores:');
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion UpdateInvoiceLeadInformation error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
	        	//system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo para actualizar el Id de salesforce al migrar la cuenta 
    /// de prospecto a cuenta.
    /// </summary>
    /// <param name="inputLeadId">SalesforceId de prospecto antes de convertir.</param>
    /// <param name="inputAccountId">SalesforceId de Account una vez convertido el prospecto.</param>
    /// <returns>Resultado de la actualizacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult UpdateSalesforceIdLeadAccountOCCM(String inputLeadId, String inputAccountId)
	{
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
		OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
		String resultWS;
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			//system.debug('UpdateInvoiceLeadInformation JSONData:' + jsonPersonalData);
			if (!Test.isRunningTest())
			{
   				resultWS=ws.UpdateSaleforceIdLeadAccount(inputLeadId, inputAccountId);
   				executedStatusResult= (OCCMClases.ExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.ExecutionResult.class);
			}
			else
			{
   				resultWS= '';
   				executedStatusResult.success=true;
			}
			//system.debug(resultWS);
			
			//messageResult=wsExecutedStatusResult.message;
			if (executedStatusResult.success==false){
				messageResult=executedStatusResult.message;
				successResult=false;
				//system.debug('Resultado:' + successResult + ' Error:' + messageResult);
			}
			else{
				messageResult='';
				successResult=true;
				//system.debug('Sin errores:');
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion UpdateSalesforceIdLeadAccountOCCM error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
	        	//system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		return ExecutedStatusResult;
	}
	
	/// <summary>
    /// Metodo para mandar establecer la comunicacion con web service de recluta, consumiendo el metodo para actualizar los datos fiscales del prospecto en OCCM
    /// </summary>
    /// <param name="jsonPersonalData">Se obtinene previamente la instancia de personal data que corresponde al lead que se enviara a OCCM.</param>
    /// <param name="inputLeadId">LeadId que se enviara a OCCM.</param>
    /// <returns>Resultado de la actualizacion de la cuenta en OCCM, el cual sera enviado al metodo del web service que lo manda llamar.</returns>
	public static OCCMClases.ExecutionResult UpdateAccountInformation(String jsonPersonalData, String inputAccountId)
	{
		Boolean successResult=false;
	    String messageResult='';
	    Object objectResult=null;
	    List<OCCMClases.Error> listError= new List<OCCMClases.Error>();
	    OCCMClases.WsExecutionResult wsExecutedStatusResult=new OCCMClases.WsExecutionResult();
	    OCCMClases.ExecutionResult executedStatusResult=new OCCMClases.ExecutionResult();
	    String resultWS;
	    //Boolean resultExecution=false;
		OCCMClases.PersonalData ps=new OCCMClases.PersonalData();
		try{	
			RecruiterDataService.RecruiterDataServiceSoap ws = CreateConectionWebService();
			//System.debug('UpdateInvoiceLeadInformation JSONData:' + jsonPersonalData);
			if (!Test.isRunningTest())
			{
   				resultWS=ws.UpdateInvoiceInformation(jsonPersonalData);
				//system.debug('ResultadoWS' + resultWS);
				wsExecutedStatusResult= (OCCMClases.WsExecutionResult) System.JSON.deserialize(resultWS, OCCMClases.WsExecutionResult.class);	
			}
			else
			{
   				wsExecutedStatusResult.success=true;
   				wsExecutedStatusResult.message='Proceso satisfactorio';
   				wsExecutedStatusResult.objectResult=jsonPersonalData;
			}
			//successResult=false;
			messageResult=wsExecutedStatusResult.message;
			if (wsExecutedStatusResult.success==false){
				//messageResult =	Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				if (wsExecutedStatusResult.objectResult==null)
				{
					messageResult += wsExecutedStatusResult.message;
				}
				else
				{
					messageResult += Funciones.GetMessageErrorFromListErrors(String.valueOf(wsExecutedStatusResult.objectResult));
				}
				//system.debug('Resultado:' + successResult + ' Error:' + messageResult);
			}
			else{
				String PersonalDataString='';
				PersonalDataString= wsExecutedStatusResult.objectResult;
				OCCMClases.PersonalData personalDataFromDotNet= (OCCMClases.PersonalData) System.JSON.deserialize(PersonalDataString, OCCMClases.PersonalData.class);
				Account account=null;
				//system.debug('LeadId:'+inputAccountId);
				//system.debug('personalDataFromDotNet.SalesforceID:'+personalDataFromDotNet.SalesforceId);
				account = [SELECT Id, Is_Future_Context__c FROM Account WHERE Id =: inputAccountId LIMIT 1];
				if (account!=null){
					account.Is_Future_Context__c = true;
					List<Account> leadsToUpdate = new List<Account>();
					leadsToUpdate.add(account);
					String mensaje= Funciones.GetMessageErrorFromSaveDML(Database.update(leadsToUpdate, false));
					if (!String.isBlank(mensaje)){
						messageResult = mensaje;
					}
					else
					{
						successResult=true;
						//System.debug('Sin errores:');
					}
				}
				//System.debug('Sin errores:');
			}
		}
        catch(JSONException e)
		{
        	messageResult='Exepcion UpdateAccountInformation error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + '; Mensaje:' + e.getMessage() + '; Stack Trace: ' + e.getStackTraceString();
	        //system.debug(messageResult);
		}
		ExecutedStatusResult= new OCCMClases.ExecutionResult(successResult, messageResult, objectResult);
		//System.debug('ExecutedStatusResult:' + ExecutedStatusResult);
		return ExecutedStatusResult;
	}
/**********************************************************************************************************************************************
Metodos de prueba
**********************************************************************************************************************************************/	
	@isTest (seeAllData=true)
	static void TestRecruiterDataServiceWrapper() {
		//Test.startTest();		
		//System.runAs(UserInfo) { 
		//}
		//Test.stopTest();
		RecruiterDataService.RecruiterDataServiceSoap rdss= RecruiterDataServiceWrapper.CreateConectionWebService();	
      	//Validacion de prospectos
      	Lead lead = new Lead();
		lead.FirstName='Nombre';
		lead.LastName='Apellido';
		lead.title='Posicion';
		lead.phone='0000000000';
		lead.email='email@emailSinUso.com';
		lead.Company='TestMethod';
		lead.Industry='Explotacion de Recursos Forestales';
		lead.Giro_o__c= 'Aprovechamiento forestal';
		lead.Calle_o__c= 'Calle'; 
		lead.No_de_Exterior_de_Facturacion__c= 'Ext';
		lead.No_de_interior_de_Facturacion__c= 'Int';
		lead.Colonia__c= 'Colonia';
		lead.Pais_o__c= 'Mexico';
		lead.Estado__c= 'Michoacan';
		lead.MobilePhone= '0000000000';
		lead.Producto_de_inter_s__c= 'Membresía OCC Premium';
		lead.MembresiaInteres_o__c= '1 Mes';
		lead.No_Empleados__c= '21 - 40 empleados';
		lead.RFC__c= 'NEFA000000STO';
		lead.N_mero_de_Vacantes__c= '11 a 20';
		lead.Tipo_deVacante__c= 'Ejecutivo';
		lead.C_mo_se_enter_de_OCCMundial_com__c= 'Radio';
		lead.OCCM_Cuenta_Administradora__c= '';
		lead.OCCM_Password_Cuenta_Administradora__c= '';
		lead.CodPostal_o__c='000000';
		lead.Website='http://NA.Com';	
		lead.DelegMunic_o__c = 'Querétaro';	
		lead.DelegMunic_o__c = 'Querétaro';
		lead.Ciudad_opcional_o__c = 'Querétaro';	
		lead.MobilePhone = '0000000000';	
		lead.LeadSource= 'Web';
		insert lead;
		
		OCCMClases.PersonalData personalDataInfo = new OCCMClases.PersonalData();
		personalDataInfo.Name = lead.FirstName;
		personalDataInfo.LastName= lead.LastName;
		personalDataInfo.JobPosition = lead.title;
		personalDataInfo.EmailAddress = lead.Email;
		personalDataInfo.ConfirmEmail = lead.Email;
		personalDataInfo.PhoneNumber = lead.Phone;
		personalDataInfo.MovilNumber  = lead.MobilePhone;
		personalDataInfo.FaxNumber = lead.Fax; 
		personalDataInfo.DescripcionProductoInteres = lead.Producto_de_inter_s__c;
		personalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;  
		personalDataInfo.CompanyName = lead.Company;
		personalDataInfo.DescripcionNumeroEmpleados = lead.No_Empleados__c; 
		personalDataInfo.DescripcionSector = lead.Industry;
		personalDataInfo.DescripcionGiro = lead.Giro_o__c;
		personalDataInfo.Country = lead.Pais_o__c;
		personalDataInfo.State = lead.Estado__c;
		personalDataInfo.City = lead.Ciudad_opcional_o__c;
		personalDataInfo.Municipal = lead.DelegMunic_o__c;
		personalDataInfo.StreetAddress = lead.Calle_o__c;
		personalDataInfo.ExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
		personalDataInfo.InternalNumber= lead.No_de_interior_de_Facturacion__c;
		personalDataInfo.Colony = lead.Colonia__c;
		personalDataInfo.PostalCode = lead.CodPostal_o__c;
		personalDataInfo.WebPage = lead.Website;
		personalDataInfo.DescripcionMedioEntero = lead.C_mo_se_enter_de_OCCMundial_com__c;   
		personalDataInfo.IsBill = true;
		personalDataInfo.BillRFC = lead.RFC__c;
		personalDataInfo.BillName = lead.Company;
		personalDataInfo.BillCountry = lead.Pais_o__c;
		personalDataInfo.BillState = lead.Estado__c;
		personalDataInfo.BillCity = lead.Ciudad_opcional_o__c;
		personalDataInfo.BillMunicipal = lead.DelegMunic_o__c;
		personalDataInfo.BillStreet = lead.Calle_o__c;
		personalDataInfo.BillExternalNumber=lead.No_de_Exterior_de_Facturacion__c;
		personalDataInfo.BillInternalNumber= lead.No_de_interior_de_Facturacion__c;
		personalDataInfo.BillColony = lead.Colonia__c;
		personalDataInfo.BillPostalCode = lead.CodPostal_o__c;
		personalDataInfo.LoginDisabled = 'false';
		personalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.ConfirmPassword = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.DescripcionVacantesACubrir = lead.N_mero_de_Vacantes__c;
		personalDataInfo.DescripcionTipoVacante = lead.Tipo_deVacante__c;
		personalDataInfo.DescripcionTipoProductoInteres = lead.MembresiaInteres_o__c;
		personalDataInfo.SalesforceId = lead.Id;
		personalDataInfo.LoginId = lead.OCCM_Cuenta_Administradora__c;
		personalDataInfo.ManagerAccount = lead.OCCM_Cuenta_Administradora__c;
		personalDataInfo.Password = lead.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.PasswordManagerAccount = lead.OCCM_Password_Cuenta_Administradora__c;
      	String personalDataInfoJSON = JSON.serialize(personalDataInfo);
      	OCCMClases.ExecutionResult createLeadOK=RecruiterDataServiceWrapper.CreateOccmLead(personalDataInfoJSON, lead.Id);
     	OCCMClases.ExecutionResult updateInvoiceLeadInformation = RecruiterDataServiceWrapper.UpdateInvoiceLeadInformation(personalDataInfoJSON, lead.Id);
     	
     	//Validacion de cuentas
     	Account account = new Account();
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
		account.RFC_o__c = 'RFCA000000AAA';
		account.Phone='0000000000';
		account.Website='NA';
		account.Name = 'OMicro';
		//account.OCCM_Password_Cuenta_Administradora__c = 'password';
		//account.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		//account.Cuenta_Virtual_Banamex__c='BAN000000';
		account.Type='Individual';
		account.Industry='Industria';
		account.Giro_o__c='Madera';
		account.No_Empleados__c = '501 - 600 empleados';
		account.Tipo_de_Vacante__c = 'Ejecutivo';
		account.N_mero_de_Vacantes__c = '4 a 10';
		account.MembresiaInteres_o__c = '5';
		account.Producto_de_inter_s__c = 'Paquetes de Ofertas Individuales';
		account.C_mo_se_enter_de_OCCMundial__c = 'Radio';
		account.OCCM_Cuenta_Administradora__c = 'xmxcuentax';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		insert account;
		Contact contact= new Contact();
		contact.LastName = 'Uno';
		contact.FirstName='Contact';
		contact.AccountId=account.Id;
		contact.Phone='0000000000';
		contact.Email='ContactUno@ContactUno.com';
		contact.LeadSource='Web';
		contact.Title= 'TituloPuesto';
		contact.Fecha__c= Date.today();
		insert contact;
		personalDataInfo = new OCCMClases.PersonalData();
		personalDataInfo.Name = contact.FirstName;
		personalDataInfo.LastName= contact.LastName;
		personalDataInfo.JobPosition = contact.Title;
		personalDataInfo.EmailAddress = contact.Email;
		personalDataInfo.ConfirmEmail = contact.Email;
		personalDataInfo.PhoneNumber = contact.Phone;
		personalDataInfo.MovilNumber = contact.Phone;
		personalDataInfo.FaxNumber = contact.Phone;
		personalDataInfo.DescripcionProductoInteres = account.Producto_de_inter_s__c;
		personalDataInfo.DescripcionTipoProductoInteres = '';
		personalDataInfo.CompanyName =  account.Name;
		personalDataInfo.DescripcionNumeroEmpleados = account.No_Empleados__c;  
		personalDataInfo.DescripcionSector =  account.Industry;
		personalDataInfo.DescripcionGiro = account.Giro_o__c;
		personalDataInfo.Country =  account.PaisFact_o__c;
		personalDataInfo.State = account.EstadoFact_o__c;
		personalDataInfo.City = account.CiudadFact_opcional_o__c;
		personalDataInfo.Municipal = account.DelegMunicFact_o__c;
		personalDataInfo.StreetAddress = account.CalleFact_o__c;
		personalDataInfo.ExternalNumber = account.No_de_Exterior__c;
		personalDataInfo.InternalNumber = account.No_de_interior__c;
		personalDataInfo.Colony = account.Colonia_de_Facturaci_n__c;
		personalDataInfo.PostalCode = account.CodigoPostalFact_o__c;
		personalDataInfo.WebPage = account.Website;
		personalDataInfo.DescripcionMedioEntero = account.C_mo_se_enter_de_OCCMundial__c;
		personalDataInfo.IsBill = true;
		personalDataInfo.BillRFC = account.RFC_o__c;
		personalDataInfo.BillName = account.Name;
		personalDataInfo.BillCountry = account.PaisFact_o__c;
		personalDataInfo.BillState = account.EstadoFact_o__c;
		personalDataInfo.BillCity = account.CiudadFact_opcional_o__c;
		personalDataInfo.BillMunicipal = account.DelegMunicFact_o__c;
		personalDataInfo.BillStreet = account.CalleFact_o__c;
		personalDataInfo.BillExternalNumber = account.No_de_Exterior__c;
		personalDataInfo.BillInternalNumber =  account.No_de_interior__c;
		personalDataInfo.BillColony = account.Colonia_de_Facturaci_n__c;
		personalDataInfo.BillPostalCode = account.CodigoPostalFact_o__c;
		personalDataInfo.LoginDisabled = 'false';
		personalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.ConfirmPassword = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.DescripcionVacantesACubrir = account.N_mero_de_Vacantes__c;
		personalDataInfo.DescripcionTipoVacante = account.Tipo_de_Vacante__c;
		personalDataInfo.DescripcionTipoProductoInteres = account.Type;
		personalDataInfo.SalesforceId = account.Id;
		personalDataInfo.LoginId = account.OCCM_Cuenta_Administradora__c;
		personalDataInfo.ManagerAccount = account.OCCM_Cuenta_Administradora__c;
		personalDataInfo.Password = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfo.PasswordManagerAccount = account.OCCM_Password_Cuenta_Administradora__c;
		personalDataInfoJSON = JSON.serialize(personalDataInfo);
		OCCMClases.ExecutionResult createOccmAccount= RecruiterDataServiceWrapper.CreateOccmAccount(personalDataInfoJSON, account.Id);
		OCCMClases.ExecutionResult updateAccountInformation= RecruiterDataServiceWrapper.UpdateAccountInformation(personalDataInfoJSON, account.Id);
		
		OCCMClases.AccountSummary accountSummaryerr=null;
		OCCMClases.ExecutionResult SendGetContractedPackagesErr= RecruiterDataServiceWrapper.SendGetContractedPackages(accountSummaryerr);
		accountSummaryerr=new OCCMClases.AccountSummary();
		SendGetContractedPackagesErr= RecruiterDataServiceWrapper.SendGetContractedPackages(accountSummaryerr);
		OCCMClases.AccountSummary accountSummary= new OCCMClases.AccountSummary();
		accountSummary.RecruiterId =account.OCCM_Cuenta_Administradora__c;
        accountSummary.Password =account.OCCM_Password_Cuenta_Administradora__c;
        accountSummary.Active = true;
        accountSummary.TokenActivation  ='';
        accountSummary.AccountType  ='';
        accountSummary.EmailAddress  =contact.Email;
        accountSummary.ValidEmailAddress  = true;
        accountSummary.ActiveJobs = 0;
        accountSummary.Agents  = 0;
        accountSummary.SalesForceId  =account.Id;
        accountSummary.CompanyId  =account.Name;
        accountSummary.Administrator  = true;
        accountSummary.IsWebSolutionAccount  = false;
        //accountSummary.ExecutiveId  = 'Ejecutivo de pruebas';
        accountSummary.Name  ='Pruebas';
        accountSummary.PhoneNumber  =account.Phone;
        accountSummary.MovilNumber  =account.Phone;
		
		OCCMClases.ExecutionResult SendGetContractedPackages= RecruiterDataServiceWrapper.SendGetContractedPackages(accountSummary);
		
		OCCMClases.ExecutionResult updateSalesforceIdLeadAccountOCCM=RecruiterDataServiceWrapper.UpdateSalesforceIdLeadAccountOCCM(lead.Id, account.Id);
		
		OCCMClases.ExecutionResult sendMigrationAccount = RecruiterDataServiceWrapper.SendMigrationAccount(accountSummary, account.Id);
		String Id15=String.valueOf(account.Id);
		Id15=Id15.substring(1,15);
		OCCMClases.ExecutionResult sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(Id15);
		Id15=String.valueOf(account.Id);
		Id15=Id15.substring(1,16);
		sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(Id15);
		sendBusinessModel = RecruiterDataServiceWrapper.SendsIsNewBusinessModelAccountRequest(account.Id);
		List<OpportunityLineItem> singleItems =  new List<OpportunityLineItem>();
		OCCMClases.OCCMPurchase occmPurchase = new OCCMClases.OCCMPurchase();
		List<OCCMClases.OCCMPackage> occmPackage =  new List<OCCMClases.OCCMPackage>();
    	String stringOccmPurchase='';
         Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
							
		//Creacion de Productos y listas de precios
		
		List<PricebookEntry> priceBookEntry = new List<PricebookEntry>();
		
		Pricebook2 standarPriceBook = [SELECT Id, Name, Description, CurrencyIsoCode, IsActive, CreatedById,   IsDeleted, IsStandard, CreatedDate, 
												LastModifiedDate,  SystemModstamp,  LastModifiedById 
											FROM Pricebook2 
											WHERE IsStandard=true LIMIT 1];
											
		Product2 product = new Product2();
			product.ProductCode = 'TEST000001';
            product.Family = 'Negocio Base';
			product.Name = 'Plan 1 Vacante Semanal';
            product.Tipo_de_Producto__c = 'Venta';
			product.NumLicencias_o__c = 1;
			product.Vigencia_de_Paquete_d_as__c = '30';
            product.Tiempo_de_Publicaci_n_de_Vacante__c = 30;
            product.Identidades_Incluidas__c = 10;
            product.PDA_s_Inclu_dos__c = 1;
            product.Description = 'Tipo de producto:Vacantes - Cantidad:  1 - dias de Vigencia: 7 - dias de publicacion: 7 - Datos de contacto incluidos: 30 - PDAs incluodos: 1';
            product.IsActive = true;
            product.No2__c = 'PRO-0001';
            product.CurrencyIsoCode='MXN';
		insert product;
		
		PricebookEntry pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = standarPriceBook.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		Pricebook2 listaPrecios=new Pricebook2();
			listaPrecios.Name='ListaMetodoPrueba'; 
			listaPrecios.Description='Lista de precios del metodo de pureba'; 
			listaPrecios.CurrencyIsoCode='MXN'; 
			listaPrecios.IsActive=true;
			//listaPrecios.IsStandard=true;
		insert listaPrecios;
		
		ID liPriceId = listaPrecios.Id;
		
		pbe = new PricebookEntry();
			pbe.CurrencyIsoCode='MXN'; 
			pbe.IsActive = true;
            pbe.Pricebook2Id = listaPrecios.Id;
            //pbe.Pricebook2 = standarPriceBook;
			pbe.Product2Id = product.Id;
            pbe.UnitPrice = 10.0;
            //pbe.UnitPriceSpecified = true;
            //pbe.UseStandardPrice = true;
		insert pbe;
		
		priceBookEntry.add(pbe);							
							
		/*					
		//Pricebook2 listaPrecio= new Pricebook2(Description='Lista Precios Prueba', Name='ListaPrecios', IsActive=true);
		//Se recupera la lista de precios y el producto, para no tener que realizar la carga de los 3 productos manuales, al igula con la generacion de la
		//list de precios.
		//ID liPriceId='01s50000000MVrDAAW'; //ProduccionAnterior
		//ID liPriceId='01s50000000Mah4'; //Produccion
		//ID liPriceId = '01s50000000MV5x';	//Sandbox anterior	
		ID liPriceId = '01sW00000004a0t'; //Sandbox
		//Pricebook2 listaPrecios = [SELECT Description, Id, Name 
		//								FROM Pricebook2 
		//								WHERE //IsActive = true 
											//Sandbox ID Id='01s50000000MV5x'
		//										Id = '01s50000000MVrDAAW'
		//								order by LastModifiedDate DESC ]; //01s50000000MV5xAAG
		//De sebe asegurar antes de correr que ell producto que se esta buscando existe en la base dde datos de productos debidamente configurado
		//al igual qe en productos de cortesias, descuentos, PDA's o sea los productos 'B', 'C', D para que pueda encotnrar producto y las partidas correspondientes a las cortesias, dewscuentos, etc.
		PricebookEntry[] priceBookEntry = [Select UnitPrice, ProductCode, Product2Id, Pricebook2Id, Name, Id, CurrencyIsoCode
												From PricebookEntry 
												WHERE Pricebook2Id =:liPriceId  AND ProductCode like 'NBE175%' AND IsActive =: true AND CurrencyIsoCode =: 'MXN'
												LIMIT 1];
		*/	
		Opportunity opp=new Opportunity();
		opp.Name='BZFAPEXTEST';
		opp.AccountId =	account.Id;
		opp.Description = 'Cuenta general';
		opp.OwnerId=userInfo.Id;
		opp.NunOfertafisica_o__c ='TestFact';
		opp.Tipo_de_vigencia__c='Automática';
		opp.StageName='Cierre';
		opp.CloseDate = Date.today();
		opp.E_mail_para_env_o_de_Factura_Elect_nica__c='bzavala@occ.com.mx';
		opp.Factura_Aprobada__c = false;
		opp.Factura_cobrada__c = false;
		opp.Paquete_de_venta__c = 3;
		//Campos requeridos factura
		opp.EstatusFactura__c='';
		opp.EjecutivoAsig_o__c=UserInfo.Id;
		opp.Tipo_de_Facturacion__c='No Credito';
		opp.FechaFactura_o__c=Date.today();
		opp.InicioVigencia_o__c = Date.today();
		opp.FinVigencia_o__c = Date.today();
		opp.FechaPago__c=Date.today();
		opp.CurrencyIsoCode='MXN';
		insert opp;
		
		Quote quote= new Quote();
		quote.Name='Presupuesto001';
		quote.Opportunity=opp;
		quote.ExpirationDate=Date.today();
		quote.Is_Future_Context__c=false;
		quote.OpportunityId= opp.Id;
		quote.Pricebook2Id=liPriceId;
		//quote.CurrencyIsoCode='MXN';
		insert quote;
		
		//Agregar la partida del presupuesto
		QuoteLineItem qli= new QuoteLineItem();
		for (PricebookEntry pe: priceBookEntry){
			qli= new QuoteLineItem();
			qli.QuoteId=quote.id;
			qli.Quantity=1;
			qli.UnitPrice=100;
			qli.PricebookEntryId=pe.Id;
			//qli.CurrencyIsoCode='MXN';
			insert qli;
		}
			
		opp.SyncedQuoteId = quote.Id;
		update opp;
		
		account.Cuenta_Virtual_Banamex__c='BAN000011';
		account.OCCM_Cuenta_Administradora__c = 'xmxomicrox';
		account.OCCM_Password_Cuenta_Administradora__c='Hola';
		update account;
		
		OpportunityLineItem oli= new OpportunityLineItem();
		for (PricebookEntry pe: priceBookEntry){
			oli= new OpportunityLineItem();
			oli.OpportunityId=opp.id;
			oli.Quantity=1;
			oli.UnitPrice=100;
			oli.PricebookEntryId=pe.Id;
			insert oli;
		}
		
		opp.StageName='Cierre';
		opp.NunOfertafisica_o__c='FACT00000000';
		//opp.EstatusFactura__c='Aprobada';
		opp.EstatusFactura__c='En Transito';
		opp.Tipo_de_vigencia__c ='Automática';
		opp.InicioVigencia_o__c=date.today();
		opp.FinVigencia_o__c=date.today();
		opp.Referencia_Bancaria__c='BANAMEX000';
		opp.Amount =100;
		opp.Fecha_de_envio_de_paquetes_OCCM__c=null;
		opp.StageName='Cierre';
		update opp; 
						
		String codigoB='';
		singleItems=[SELECT Id, OpportunityId, PricebookEntryId, PricebookEntry.Name, PricebookEntry.ProductCode, Quantity, UnitPrice
								FROM OpportunityLineItem 
								WHERE OpportunityId =: opp.Id];
		//system.debug('Entrando a construir el paquete de purchase');
		occmPurchase =  new OCCMClases.OCCMPurchase();
		for(OpportunityLineItem oppTemp : singleItems)
		{
			codigoB=oppTemp.PricebookEntry.ProductCode;
			if (!codigoB.endsWith('D') && !codigoB.endsWith('C')){
				OCCMClases.OCCMPackage occmPackageTmp = new OCCMClases.OCCMPackage();
		 		OCCMClases.OCCMService occmServiceTmp = new OCCMClases.OCCMService();
				List<OCCMClases.OCCMService> occmService = new List<OCCMClases.OCCMService>();
				occmServiceTmp.Elements = Integer.valueOf(oppTemp.Quantity);
				occmServiceTmp.TotalElements = Integer.valueOf(oppTemp.Quantity);
				occmServiceTmp.PriceU =  oppTemp.UnitPrice;
				occmServiceTmp.Description = oppTemp.PricebookEntry.Name;
				occmService.add(occmServiceTmp);
		 		occmPackageTmp.Name= oppTemp.PricebookEntry.Name;
		 		if (codigoB.endsWith('B'))
				{
					occmPackageTmp.Code = 'PACK-DESC-R11';
					occmPackageTmp.ClaveSAP = 'PACK-DESC-R11';	
				}
				else
				{
					occmPackageTmp.Code = oppTemp.PricebookEntry.ProductCode;
					occmPackageTmp.ClaveSAP = oppTemp.PricebookEntry.ProductCode;
				}
				occmPackageTmp.Services=occmService;
				occmPackageTmp.Price=oppTemp.UnitPrice;
				occmPackage.add(occmPackageTmp);
				//system.debug('Producto insertado:' + oppTemp.PricebookEntry.Name);
			}
			codigoB='';
		}
		occmPurchase.ClientId= account.OCCM_Cuenta_Administradora__c;
		occmPurchase.DocumentSAP = opp.NumFact__c;
		occmPurchase.Amount = opp.ImporteMXP__c;
		occmPurchase.PaymentMode = 'Crédito';
		occmPurchase.AutomaticValidity=true;
		//Todas las oportunidades requieren factura.
		occmPurchase.RequiresInvoice = true;
		occmPurchase.PurchasedDate = opp.InicioVigencia_o__c;
		occmPurchase.DateExpires = opp.FinVigencia_o__c;
		String UsuarioAutoriza=user.FirstName + ' ' + user.LastName;
		if (UsuarioAutoriza.length()>100)
		{
			UsuarioAutoriza= UsuarioAutoriza.substring(0,99);
		}
		occmPurchase.AuthorizedBy = UsuarioAutoriza;
		occmPurchase.ReferenceCode = 'Contratación por Salesforce.';
		occmPurchase.TransactionReference = opp.Referencia_Bancaria__c;
		occmPurchase.Packages = occmPackage;	
		
		OCCMClases.ExecutionResult ExecutedStatusResult = RecruiterDataServiceWrapper.CreateOccmPurchase(occmPurchase, account.Id);	

		opp.EstatusFactura__c='';
		update opp;	
		OCCMClases.ExecutionResult deleteListProductsInOpportunity = RecruiterDataServiceWrapper.DeleteListProductsInOpportunity(quote.id);	
		OCCMClases.ExecutionResult DeleteListProductsInQuote=RecruiterDataServiceWrapper.DeleteListProductsInQuote(quote.id);
		/*
		//Se manda llamar las partidas para actualizarles los produtos de cortesia
		QuoteLineItem[] qliList = [SELECT Id, QuoteId, Quantity, UnitPrice, PricebookEntryId,Vacante_de_Cortes_a__c,Descuento2__c,Pda_s_incluidos__c   
											FROM QuoteLineItem
											WHERE QuoteId =: quote.id];
		for(QuoteLineItem qlitmp: qliList){
			qlitmp.Vacante_de_Cortes_a__c= 10;
			qlitmp.Descuento2__c=5;
			qlitmp.Pda_s_incluidos__c =1;
			update qlitmp;
		}
		*/
		//OCCMClases.ExecutionResult CreateOccmPurchase(OCCMClases.OCCMPurchase inputPurchase, String inputOpportunityId)

	}

}