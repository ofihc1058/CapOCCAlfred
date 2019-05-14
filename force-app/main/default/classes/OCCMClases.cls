/// <summary>
/// Definicion de objetos de soporte 
/// </summary>
global with sharing class OCCMClases {
    /************************************************************************************************
    *Clase utilizada para devolver registros a .NET resultado general                               *
    ************************************************************************************************/
    global class ExecutionResult
	{
        public Boolean success { get; set; }
        public String message { get; set; }
        public Object objectResult { get; set; }
        public ExecutionResult(){
        
        }
        public ExecutionResult(Boolean Estatus, String Mensaje, Object ObjetoResulta){
        	success=Estatus;
        	message=Mensaje;
        	objectResult=ObjetoResulta;
        }
	}
	/************************************************************************************************
    *Clase utilizada para devolver registros a .NET resultado general, regresando un string en      *
    *objectResult, no se regresa como objeto ya que al deserealizar el tipo de dato fecha lo        *
    *deserealiza como Date(xxxxxxxxxxxxxx) entonces se hace paso intermedeio por los tipos fecha    *
    ************************************************************************************************/
    public class WsExecutionResult
	{
        public Boolean success { get; set; }
        public String message { get; set; }
        public String objectResult { get; set; }
        public WsExecutionResult(){
        
        }
        public WsExecutionResult(Boolean Estatus, String Mensaje, String ObjetoResulta){
        	success=Estatus;
        	message=Mensaje;
        	objectResult=ObjetoResulta;
        }
	}
	/************************************************************************************************
    *Clase donde se lamacenara la informacion del prospecto, igual a                                *
    * la clase de OCCM, para mantener la consistencia de informacion                                *
    ************************************************************************************************/
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public class PersonalData{
	    public String LoginId { get; set; }
	    public String Name { get; set; }
	    public String LastName { get; set; }
	    public String JobPosition { get; set; }
	    public String EmailAddress { get; set; }
	    public String ConfirmEmail { get; set; }
	    public String PhoneNumber { get; set; }
	    public String MovilNumber { get; set; } 
	    public String FaxNumber { get; set; }
	    public Integer IdProductoInteres { get; set; }
	    public String DescripcionProductoInteres { get; set; } 
	    public Integer IdTipoProductoInteres { get; set; }
	    public String DescripcionTipoProductoInteres { get; set; }
	    public String CompanyName { get; set; }
	    public Integer IdNumeroEmpleados { get; set; }
	    public String DescripcionNumeroEmpleados { get; set; }
	    public Integer IdSector { get; set; }
	    public String DescripcionSector { get; set; }
	    public Integer IdGiro { get; set; }
	    public String DescripcionGiro { get; set; }
	    public Integer IdCountry { get; set; }
	    public String Country { get; set; }
	    public Integer IdState { get; set; }
	    public String State { get; set; }
	    public Integer IdCity { get; set; }
	    public String City { get; set; }
	    public String Municipal { get; set; }
	    public String StreetAddress { get; set; }
	    public String ExternalNumber { get; set; }
	    public String InternalNumber { get; set; }
	    public String Colony { get; set; }
	    public String PostalCode { get; set; }
	    public String WebPage { get; set; }
	    public String ImageLogo { get; set; }
	    public Integer IdMedioEntero { get; set; }
	    public String DescripcionMedioEntero { get; set; } 
	    public Boolean IsBill { get; set; }
	    public String BillRFC { get; set; }
	    public String BillName { get; set; }
	    public Integer BillIdCountry { get; set; }
	    public String BillCountry { get; set; }
	    public Integer BillIdState { get; set; }
	    public String BillState { get; set; }
	    public Integer BillIdCity { get; set; }
	    public String BillCity { get; set; }
	    public String BillMunicipal { get; set; }
	    public String BillStreet { get; set; }
	    public String BillExternalNumber { get; set; }
	    public String BillInternalNumber { get; set; }
	    public String BillColony { get; set; }
	    public String BillPostalCode { get; set; }
	    public String LoginDisabled { get; set; }
	    public String Membership { get; set; }
	    public String MembershipType { get; set; }
	    public String Password { get; set; }
	    public String ConfirmPassword { get; set; }
	    public Integer VacantesACubrir { get; set; }
	    public String DescripcionVacantesACubrir { get; set; }
	    public Integer TipoVacante { get; set; }
	    public String DescripcionTipoVacante { get; set; }
	    public Integer ExecutiveAccountId { get; set; }
	    public Boolean IsAdministrator { get; set; }
	    public String UserToken { get; set; }
	    public String ErrorMessage { get; set; }
	    public ID SalesforceId { get; set; }
	    public String ManagerAccount { get; set; }
	    public String PasswordManagerAccount { get; set; }
        public String FechaMigracionPaquetes { get; set; }
        public String CuentaVirtual { get; set; }
        public String MensajeExistenciaPrevia { get; set; }
        public String ExecutiveSalesforceId { get; set; }
        public String LeadSource { get; set; }
        public String Detalle_origen  { get; set; }
        public PersonalData(){
        	LoginId = '';
			Name = '';
			LastName = '';
			JobPosition = '';
			EmailAddress = '';
			ConfirmEmail = '';
			PhoneNumber = '';
			MovilNumber = '';
			FaxNumber = '';
			IdProductoInteres = -1;
			DescripcionProductoInteres = '';
			IdTipoProductoInteres = -1;
			DescripcionTipoProductoInteres = '';
			CompanyName = '';
			IdNumeroEmpleados = -1;
			DescripcionNumeroEmpleados = '';
			IdSector = 0;
			DescripcionSector = '';
			IdGiro = 0;
			DescripcionGiro = '';
			IdCountry = -1;
			Country = '';
			IdState = -1;
			State = '';
			IdCity = -1;
			City = '';
			Municipal = '';
			StreetAddress = '';
			ExternalNumber = '';
			InternalNumber = '';
			Colony = '';
			PostalCode = '';
			WebPage = '';
			ImageLogo = '';
			IdMedioEntero = -1;
			DescripcionMedioEntero  = '';
			IsBill = false;
			BillRFC = '';
			BillName = '';
			BillIdCountry = -1;
			BillCountry = '';
			BillIdState = -1;
			BillState = '';
			BillIdCity = -1;
			BillCity = '';
			BillMunicipal = '';
			BillStreet = '';
			BillExternalNumber = '';
			BillInternalNumber = '';
			BillColony = '';
			BillPostalCode = '';
			LoginDisabled = '';
			Membership = '';
			MembershipType = '';
			Password = '';
			ConfirmPassword = '';
			VacantesACubrir = -1;
			DescripcionVacantesACubrir = '';
			TipoVacante = 0;
			DescripcionTipoVacante = '';
			ExecutiveAccountId = -1;
			IsAdministrator = false;
			UserToken = '';
			ErrorMessage = '';
			SalesforceId = null;
			ManagerAccount = '';
			PasswordManagerAccount = '';
			FechaMigracionPaquetes =''; 
			CuentaVirtual='';
			MensajeExistenciaPrevia='';
			ExecutiveSalesforceId = '';
			LeadSource = '';
        	Detalle_origen = '';
        }
	}
	/************************************************************************************************
	* Clase de librerias utilizadas para listado de errores regresados de WS                        *
	* nos permite devolver y recuperar los registros de error en NET                                *
	************************************************************************************************/
	public with sharing class Error {
	    public String item { get; set; }
	    public String message { get; set; }
	    public Error (){
	        
	    }
	
	}
	/************************************************************************************************
	* Clase de librerias utilizadas para informacion de la compra que se enviara y regresara del WS *
	* sera la clase que se utilizara para en envio de informacion de oportunidad hacia OCCM         *
	************************************************************************************************/
	public with sharing class OCCMPurchase {
		public Integer Id { set; get; }
        public String ClientId { set; get; }
        public Datetime PurchasedDate { set; get; }
        public Decimal Amount { set; get; }
        public Boolean RequiresInvoice { set; get; }
        public Integer IdPaymentMode { set; get; }
        public String PaymentMode { set; get; }
        public String AuthorizationCode { set; get; }
        public Integer IdPurchaseState { set; get; }
        public String AuthorizedBy { set; get; }
        public Datetime AuthorizationDate { set; get; }
        public Boolean IsAuthorized { set; get; }
        public String ReferenceCode { set; get; }
        public Integer CardId { set; get; }
        public String DocumentSAP { set; get; }
        public List<OCCMPackage> Packages { set; get; }
        public Boolean AutomaticValidity { set; get; }
        public Datetime DateExpires { set; get; }
        public String ErrorMessage { get; set; }
        public Integer PercentageToActivate { get; set; }
        public String TransactionReference  { get; set; }
        public string PurchaseState { set; get; }
        public DateTime ActivationDate { set; get; }
        public string Comments { set; get; }
		
		public OCCMPurchase (){
			Id = -1;
			ClientId='';
			PurchasedDate=date.today();
			Amount = -1;
	        RequiresInvoice=false;
	        IdPaymentMode=-1;
	        PaymentMode='';
	        AuthorizationCode='';
	    	IdPurchaseState =-1;
	        AuthorizedBy='';
	        AuthorizationDate = date.today();
	        AuthorizationDate=AuthorizationDate.addDays(1);
	        IsAuthorized = false;
	        ReferenceCode ='Contratación por Salesforce.';
	        CardId = -1;
	        DocumentSAP =''; 
	        Packages = null;
	        AutomaticValidity =false;
	        DateExpires = date.today();
	        DateExpires=DateExpires.addDays(1);
	        ErrorMessage = '';
	        PercentageToActivate =-1; 
	        TransactionReference = '0';
	        PurchaseState='';
            ActivationDate = date.today();
            Comments='';
	    }
	}
	
	/************************************************************************************************
	* Clase de librerias utilizadas para informacion de la compra que se enviara y regresara del WS *
	* sera la clase que se utilizara para en envio de informacion de oportunidad hacia OCCM         *
	************************************************************************************************/
	public with sharing class OCCMPurchaseString {
		public Integer Id { set; get; }
        public String ClientId { set; get; }
        public String PurchasedDate { set; get; }
        public Decimal Amount { set; get; }
        public Boolean RequiresInvoice { set; get; }
        public Integer IdPaymentMode { set; get; }
        public String PaymentMode { set; get; }
        public String AuthorizationCode { set; get; }
        public Integer IdPurchaseState { set; get; }
        public String AuthorizedBy { set; get; }
        public String AuthorizationDate { set; get; }
        public Boolean IsAuthorized { set; get; }
        public String ReferenceCode { set; get; }
        public Integer CardId { set; get; }
        public String DocumentSAP { set; get; }
        public String Packages { set; get; }
        public Boolean AutomaticValidity { set; get; }
        public String DateExpires { set; get; }
        public String ErrorMessage { get; set; }
        public Integer PercentageToActivate { get; set; }
        public String TransactionReference  { get; set; }
        public String PurchaseState { set; get; }
        public String ActivationDate { set; get; }
        public String Comments { set; get; }

		public OCCMPurchaseString (){
			Id = -1;
			ClientId='';
			PurchasedDate='';
			Amount = -1;
	        RequiresInvoice=false;
	        IdPaymentMode=-1;
	        PaymentMode='';
	        AuthorizationCode='';
	    	IdPurchaseState =-1;
	        AuthorizedBy='';
	        AuthorizationDate = '';
	        IsAuthorized = false;
	        ReferenceCode ='Contratación por Salesforce.';
	        CardId = -1;
	        DocumentSAP =''; 
	        Packages = '';
	        AutomaticValidity =false;
	        DateExpires = '';
	        ErrorMessage = '';
	        PercentageToActivate =-1; 
	        TransactionReference = '0';
	        PurchaseState='';
            ActivationDate ='';
            Comments='';
	    }
	}
	
	/*********************************************************************************************
	* Clase de librerias utilizadas para listado de paquetes que se contrataran regresados de WS *
	* nos permite devolver y recuperar los registros de error en NET                             *
	*********************************************************************************************/
	public with sharing class OCCMPackage {
		public Integer Id { set; get; }
        public String Name { set; get; }
        public String Description { set; get; }
        public String Code { set; get; }
        public Decimal Price { set; get; }
        public Boolean IsActive { set; get; }
        public Boolean ShowInShoppingCart { set; get; }
        public String TypeDescription { set; get; }
        public List<OCCMService> Services { set; get; }
        public String ClaveSAP { set; get; }
        
		public OCCMPackage (){
	    	Id = -1;
        	Name = '';
        	Description = '';
        	Code = '';
        	Price =-1.0;
        	IsActive = false;
        	ShowInShoppingCart =   false;
        	TypeDescription = '';
        	Services = null;
        	ClaveSAP = '';
	    }
		public OCCMPackage (Integer id, String name,String description,String code,Decimal price,Boolean isActive,Boolean showInShoppingCart,String typeDescription,List<OCCMService> services, String claveSAP){
			Id = id;
        	Name = name;
        	Description = description;
        	Code = code;
        	Price = price;
        	IsActive = isActive;
        	ShowInShoppingCart =  showInShoppingCart;
        	TypeDescription = typeDescription;
        	Services = services;
        	ClaveSAP = claveSAP;			
		}
	}
	/*********************************************************************************************
	* Clase de librerias utilizadas para listado de paquetes que se contrataran regresados de WS *
	* nos permite devolver y recuperar los registros de error en NET                             *
	*********************************************************************************************/
	public with sharing class OCCMPackageString {
		public Integer Id { set; get; }
        public String Name { set; get; }
        public String Description { set; get; }
        public String Code { set; get; }
        public Decimal Price { set; get; }
        public Boolean IsActive { set; get; }
        public Boolean ShowInShoppingCart { set; get; }
        public String TypeDescription { set; get; }
        public String Services { set; get; }
        public String ClaveSAP { set; get; }
        
		public OCCMPackageString (){
	    	Id = -1;
        	Name = '';
        	Description = '';
        	Code = '';
        	Price =-1.0;
        	IsActive = false;
        	ShowInShoppingCart =   false;
        	TypeDescription = '';
        	Services = '';
        	ClaveSAP = '';
	    }
	}
	
	/****************************************************************************************************
	* Clase de librerias utilizadas para listado de servicios solo se crea para compatibilidad con OCCM *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	public with sharing class OCCMService {
		public Integer Id { set; get; }
       	public String Description { set; get; }
        public Integer Type{ set; get; }
        public Integer ExpirationPeriod { set; get; }
        public Boolean IsActive { set; get; }
        public Integer IdServiceGroup { set; get; }
        public String ServiceGroup { set; get; }
        public Integer Elements { set; get; }
        public Integer ElementExpirationPeriod { set; get; }
        public Decimal PriceU { set; get; }
        public Integer Operation { set; get; }
        public Boolean MainService { set; get; }
        public Integer TotalElements { set; get; }
        
		public OCCMService (){
	    	Id = -1;
       		Description = '';
        	Type = -1;
        	ExpirationPeriod = -1;
        	IsActive = false;
        	IdServiceGroup = -1;
        	ServiceGroup = '';
        	Elements = -1;
        	ElementExpirationPeriod = -1;
        	PriceU = -1;
        	Operation = -1;
        	MainService = true;
        	TotalElements = -1;
	    }
	}
	
	/****************************************************************************************************
	* Clase de librerias utilizadas para AccountSummary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	public with sharing class AccountSummary {
		public String RecruiterId { set; get; }
        public String Password { set; get; }
        public Boolean Active { set; get; }
        public String TokenActivation { set; get; }
        public String AccountType { set; get; }
        public String EmailAddress { set; get; }
        public Boolean ValidEmailAddress { set; get; }
        public Integer ActiveJobs { set; get; }
        public Integer Agents { set; get; }
        public String SalesForceId { set; get; }
        public String CompanyId { set; get; }
        public Boolean Administrator { set; get; }
        public Boolean IsWebSolutionAccount { set; get; }
        public Integer ExecutiveId { set; get; }
        public String Name { set; get; }
        public String PhoneNumber { set; get; }
        public String MovilNumber { set; get; }
        
        public AccountSummary(){
        	RecruiterId ='';
        	Password ='';
        	Active = true;
        	TokenActivation  ='';
        	AccountType  ='';
        	EmailAddress  ='';
        	ValidEmailAddress  = true;
        	ActiveJobs = 0;
        	Agents  = 0;
        	SalesForceId  ='';
        	CompanyId  ='';
        	Administrator  = true;
        	IsWebSolutionAccount  = false;
        	ExecutiveId  = 0;
        	Name  ='';
        	PhoneNumber  ='';
        	MovilNumber  ='';
        }
	}
	
	/****************************************************************************************************
	* Clase de librerias utilizadas para company summary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	public with sharing class CompanySummary {
		public String SalesForceId { set; get; }
        public String CompanyId { set; get; }
        public String RazonSocial { set; get; }
        public String CompanyName { set; get; }
        public String CompanyRFC { set; get; }
        public String SAPID { set; get; }
        public Integer ExecutiveId { set; get; }
        public String ExecutiveDescription { set; get; }
        public String ExecutiveEmail { set; get; }          
        public Boolean AccountMigrated { set; get; }
        public String ManagerAccountId { set; get; }
        public String Password { set; get; }
        public String DateExpires { set; get; }
        public String ContactName { set; get; }
        public String ContactEmail { set; get; }
        public Boolean RedirectUrl { set; get; }
        public Boolean PrivateDataBase { set; get; }
        public String PrivateDataBaseId { set; get;  }
        public Boolean HeadHunter { set; get; }
        public Boolean ValidEmail { set; get; }
        public Integer TotalAccounts { set; get; }           
        public List<AccountSummary> RelatedAccounts { set; get; }
        
        public CompanySummary(){
        	SalesForceId = '';
        	CompanyId  = '';
        	RazonSocial  = '';
        	CompanyName  = '';
        	CompanyRFC  = '';
        	SAPID  = '';
        	ExecutiveId = 0;
        	ExecutiveDescription = '';
        	ExecutiveEmail  = '';    
        	AccountMigrated = false;
        	ManagerAccountId  = '';
        	Password  = '';
        	DateExpires = String.valueOf(datetime.now());
        	ContactName  = '';
        	ContactEmail  = '';
        	RedirectUrl = false;
        	PrivateDataBase = false;
        	PrivateDataBaseId  = '';
       		HeadHunter = false;
        	ValidEmail = true;
        	TotalAccounts = 0;           
        	RelatedAccounts =  null;
        }
	}
	/****************************************************************************************************
	* Clase de librerias utilizadas para company summary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	public with sharing class CompanySummaryString {
		public String SalesForceId { set; get; }
        public String CompanyId { set; get; }
        public String RazonSocial { set; get; }
        public String CompanyName { set; get; }
        public String CompanyRFC { set; get; }
        public String SAPID { set; get; }
        public Integer ExecutiveId { set; get; }
        public String ExecutiveDescription { set; get; }
        public String ExecutiveEmail { set; get; }          
        public Boolean AccountMigrated { set; get; }
        public String ManagerAccountId { set; get; }
        public String Password { set; get; }
        public String DateExpires { set; get; }
        public String ContactName { set; get; }
        public String ContactEmail { set; get; }
        public Boolean RedirectUrl { set; get; }
        public Boolean PrivateDataBase { set; get; }
        public String PrivateDataBaseId { set; get;  }
        public Boolean HeadHunter { set; get; }
        public Boolean ValidEmail { set; get; }
        public Integer TotalAccounts { set; get; }           
        public List<String> RelatedAccounts { set; get; }
        
        public CompanySummaryString(){
        	SalesForceId = '';
        	CompanyId  = '';
        	RazonSocial  = '';
        	CompanyName  = '';
        	CompanyRFC  = '';
        	SAPID  = '';
        	ExecutiveId = 0;
        	ExecutiveDescription = '';
        	ExecutiveEmail  = '';    
        	AccountMigrated = false;
        	ManagerAccountId  = '';
        	Password  = '';
        	DateExpires = String.valueOf(datetime.now());
        	ContactName  = '';
        	ContactEmail  = '';
        	RedirectUrl = false;
        	PrivateDataBase = false;
        	PrivateDataBaseId  = '';
       		HeadHunter = false;
        	ValidEmail = true;
        	TotalAccounts = 0;           
        	RelatedAccounts =  null;
        }
	}
	/****************************************************************************************************
	* Clase de librerias utilizadas para company summary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	/*
	public class Statement
    {
    	public Integer Id { get; set; }
        public DateTime EntryDate { get; set; }           //Fecha de Pago bancario
        public Decimal Amount { get; set; }               //Importe
        public String ReferenceNumber { get; set; }       //Referencia Numérica
        public String VirtualAccountId { get; set; }      //Cuenta Virtual del Cliente
        public String ReferenceAlpha { get; set; }        //Concepto de Cobro
        public String ReferenceBank { get; set; }         //Referencia Bancaria
        public DateTime ModifiedDate { get; set; }
        public String Status { get; set; }
        public Integer StatusID { get; set; }
        public Statement(){
        	Id = 0;
        	EntryDate = DateTime.now();
        	Amount = 0;
        	ReferenceNumber = '';
        	VirtualAccountId = '';
        	ReferenceAlpha = '';
        	ReferenceBank = '';
        	ModifiedDate =DateTime.now();
        	Status ='';
        	StatusId = -1;
        }
    }*/
    /****************************************************************************************************
	* Clase de librerias utilizadas para company summary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                     *
	*****************************************************************************************************/
	public class StatementString
    {
    	public Integer Id { get; set; }
    	public Date EntryDateToString { get; set; }              //Fecha de pago en formato fecha
        public String EntryDate { get; set; }                    //Fecha de Pago bancario
        public Decimal Amount { get; set; }                      //Importe
        public String ReferenceNumber { get; set; }       		 //Referencia Numérica
        public String VirtualAccountId { get; set; }             //Cuenta Virtual del pago
        public String VirtualAccountIdCompany { get; set; }      //Cuenta Virtual del cliente
        public String ReferenceAlpha { get; set; }               //Concepto de Cobro
        public String ReferenceBank { get; set; }                //Referencia Bancaria
        public String ModifiedDate { get; set; }          
        public String Status { get; set; }
        public Integer StatusID { get; set; }
        public String AuthorizationNumber { get; set; }
        public Integer BankId { get; set; }
        public String Bank { get; set; }
        public Integer PaymentFormId { get; set; }
        public String PaymentForm { get; set; }

        public StatementString(){
        	//Id = 0;
        	//EntryDate = '';
        	//Amount = -0.0;
        	//ReferenceNumber = '';
        	//VirtualAccountId = '';
        	//ReferenceAlpha = '';
        	//ReferenceBank = '';
        	//ModifiedDate = '';
        	//Status ='';
        	//StatusId = -1;
        	//AuthorizationNumber=-1;
        	//BankId = -1;
        	//Bank = '';
        }
    }
    /*****************************************************************************************************
	* Clase de librerias utilizadas para contract summary solo se crea para compatibilidad con OCCM      *
	* ya que no existen los servicios en salesforce                                                      *
	*****************************************************************************************************/
    public class ContractSummary
    {
        public String ActivationDate { get; set; }
        public Integer AvailableItems { get; set; }
        public Integer ContractServiceId { get; set; }
        public String ExpirationDate { get; set; }
        public Integer ExpirationPeriod { get; set; }
        public Integer IdValidityType { get; set; }
        public String LastUpdatedDate { get; set; }
        public string PackageCode { get; set; }
        public Integer PackageId { get; set; }
        public String PackageName { get; set; }
        public Integer PaymentMethodId { get; set; }
        public String PaymentMethodName { get; set; }
        public Integer PurchasedItems { get; set; }
        public Integer PurchaseId { get; set; }
        public String PurchaseStateDescription { get; set; }
        public Integer PurchaseStateId { get; set; }
        public String RecruiterId { get; set; }
        public String SalesforceDocument { get; set; }
        public Integer ServiceId { get; set; }
        public String ServiceName { get; set; }
        public Integer ServiceType { get; set; }
        public Integer UsedItems { get; set; }
        public String ValidityType { get; set; }

        public ContractSummary()
        {
        
        }
    }
    public class Sales
    {
    	public DocumentsSAP Documents { get; set; }
    	public BusinessPartnersSap BusinessPartners  { get; set; }
    	public PaymentsSap Payments  { get; set; }
    }
    public class DocumentsSAP
    {
    	public String DocDate { get; set; }
    	public String DocDueDate { get; set; }
    	public String CardCode { get; set; }
    	public String U_InicioVigencia { get; set; }
    	public String U_FinVigencia { get; set; }
    	public String U_ComentarioVig { get; set; }
    	public String U_TipoFactura { get; set; }
    	public String U_Pagada { get; set; }
    	public String U_CorreoAlterno { get; set; }
    	public String U_Origen { get; set; }
    	public String U_HoraCreacion { get; set; }
    	public String U_NombreEjecutivo { get; set; }
    	public String Series { get; set; }
    	public String SalesPersonCode { get; set; }
    	public String U_OrdenCompra { get; set; }
    	public String U_IdVentaCarrito { get; set; }
    	public String DocCurrency { get; set; }
    	//public String TipoCambio { get; set; }
    	public String U_FolioSalesForce { get; set; }
    	public String U_ReferenciaCIE { get; set; }
    	public String U_TipoFacturacion { get; set; }
    	public String U_OrdenCompra2 { get; set; }
    	public String U_NumProveedor { get; set; }
    	public String U_ClasificacionFactura { get; set; }
    	public String U_EstatusFactura { get; set; }
    	public String U_CuentaVirtual { get; set; }
    	public String U_Leyenda { get; set; }
    	public String U_MetodoPago { get; set; }
    	public String U_NumeroCuenta { get; set; }
        public String U_VL_TipoRelacion { get; set; }
        public String U_VL_UUIDRelacionado { get; set; }
    	public List<OCCMClases.DocumentLineSap> DocumentLines  { get; set; }
    	public DocumentsSAP(String Fecha,String Cliente,String InicioVigencia,String FinVigencia,String ComentarioVigencia,String TipoFactura,String Pagada,
    					String CorreoAlterno,String Origen,String HoraCreacion,String NombreEjecutivo,String SerieDocumento,String EmpleadoVentas,
    					String OrdenCompra,String idVentaCarrito,String Moneda, String TipoCambio,String FolioSalesForce,String ReferenciaCIE,String TipoFacturacion,
    					String OrdenCompra2,String NumProveedor,String ClasificacionFactura,String EstatusFactura, String ObservacionesSAP, String CuentaVirtual,
    					List<OCCMClases.DocumentLineSap> DocumentLines, String FechaPago, String U_MetodoPago, String U_NumeroCuenta, String TipoRelacion, String UUIDRelacionado)
    	{
    		this.DocDate=Fecha;
			this.DocDueDate=FechaPago;
			this.CardCode=Cliente;
			this.U_InicioVigencia=InicioVigencia;
			this.U_FinVigencia=FinVigencia;
			this.U_ComentarioVig=ComentarioVigencia;
			this.U_TipoFactura=TipoFactura;
			this.U_Pagada=Pagada;
			this.U_CorreoAlterno=CorreoAlterno;
			this.U_Origen=Origen;
			this.U_HoraCreacion=HoraCreacion;
			this.U_NombreEjecutivo=NombreEjecutivo;
			this.Series=SerieDocumento;
			this.SalesPersonCode=EmpleadoVentas;
			this.U_OrdenCompra=OrdenCompra;
			this.U_IdVentaCarrito=idVentaCarrito;
			this.DocCurrency=Moneda;
			//this.TipoCambio=TipoCambio; 
			this.U_FolioSalesForce=FolioSalesForce;
			this.U_ReferenciaCIE=ReferenciaCIE;
			this.U_TipoFacturacion=TipoFacturacion;
			this.U_OrdenCompra2=OrdenCompra2;
			this.U_NumProveedor=NumProveedor;
			this.U_ClasificacionFactura=ClasificacionFactura;
			this.U_EstatusFactura=EstatusFactura;
			this.U_Leyenda=ObservacionesSAP;
			this.U_CuentaVirtual=CuentaVirtual;
			this.DocumentLines=DocumentLines;
			this.U_MetodoPago = U_MetodoPago;
			this.U_NumeroCuenta= '';
			if (U_NumeroCuenta!=null){
				this.U_NumeroCuenta= U_NumeroCuenta;
			}
            this.U_VL_TipoRelacion= TipoRelacion;
        	this.U_VL_UUIDRelacionado= UUIDRelacionado;
    	}
    }
    public class DocumentLineSap{
    	public String ItemCode { get; set; }
		public String Quantity { get; set; }
		public String UnitPrice { get; set; }
		public String DiscountPercent { get; set; }
		public DocumentLineSap(String Articulo,String Cantidad,String Precio,String Descuento)
		{
			this.ItemCode=Articulo;
			this.Quantity=Cantidad;
			this.UnitPrice=Precio;
			this.DiscountPercent=Descuento;
		}
    }
    public class BusinessPartnersSap
	{
		public String CardCode { get; set; }
		public String CardName { get; set; }
		public String CardType { get; set; }
		public String GroupCode { get; set; }
		public String CompanyPrivate { get; set; }
		public String Phone1 { get; set; }
		public String Phone2 { get; set; }
		public String Fax { get; set; }
		public String ContactPerson { get; set; }
		public String PayTermsGrpCode { get; set; }
		public String VatLiable { get; set; }
		public String FederalTaxID { get; set; }
		public String SalesPersonCode { get; set; }
		public String JsonCurrency { get; set; }
		public String Cellular { get; set; }
		public String AdditionalID { get; set; }
		public String CardForeignName { get; set; }
		public String ShipToDefault { get; set; }
		public String Territory { get; set; }
		public String BilltoDefault { get; set; }
		public String Website { get; set; }
		public String U_IDSAE { get; set; }
		public String U_IDSalesForce { get; set; }
		public String U_IDContactoSF { get; set; }
		public String U_Genero { get; set; }
		public String U_Edad { get; set; }
		public String U_AreasInteres { get; set; }
		public String U_AreasExperiencia { get; set; }
		public String U_PrepAcademica { get; set; }
		public String U_OtrosEstudios { get; set; }
		public String U_OtrosConocimientos { get; set; }
		public String U_Idiomas { get; set; }
		public String U_UltimasVacantes { get; set; }
		public String U_FechaUltPost1 { get; set; }
		public String U_FechaUltPost2 { get; set; }
		public String U_FechaUltPost3 { get; set; }
		public String U_EstatusCV { get; set; }
		public String U_CodOfertaInt { get; set; }
		public String U_DesOfertaInt { get; set; }
		public String U_CursoInteres { get; set; }
		public String U_FechaContacto { get; set; }
		public String U_HorarioContacto { get; set; }
		public String U_Comentarios { get; set; }
		public String U_RecibirInfo { get; set; }
		public String AddressName { get; set; }
		public String Street { get; set; }
		public String Block { get; set; }
		public String ZipCode { get; set; }
		public String City { get; set; }
		public String County { get; set; }
		public String Country { get; set; }
		public String State { get; set; }
		public String BPFederalTaxID { get; set; }
		public String TaxCode { get; set; }
		public String AddressType { get; set; }
		public String StreetNo { get; set; }
		public String U_NoInt { get; set; }
		public String JsonName { get; set; }
		public String Position { get; set; }
		public String Address { get; set; }
		public String CEPhone1 { get; set; }
		public String CEPhone2 { get; set; }		
		public String MobilePhone { get; set; }
		public String CEFax { get; set; }		
		public String E_Mail { get; set; }
		public String Pager { get; set; }
		public String Remarks1 { get; set; }
		public String Remarks2 { get; set; }
		public String PlaceOfBirth { get; set; }
		public String DateOfBirth { get; set; }
		public String actualizaSN { get; set; }
		public BusinessPartnersSap(String CodigoSN,String NombreSN,String Telefono1,String Telefono2,String Fax,String PersonaContacto,String DefinicionImpuesto,
								String RFC,String EmpleadoVentas,String TelefonoCelular,String CURP,String NombreExtranjero,String Territorio,String WebSite,
								String IDSAE,String IDSalesForce,String IDContactoSalesForce,String Calle,String Colonia,String CodigoPostal,String Municipio,
								String Pais,String Estado,String NoExterior,String NoInterior,String ContactoPuesto,String ContactoDireccion,String ContactoTelefono1,
								String ContactoTelefono2,String ContactoCelular,String ContactoFax,String ContactoEmail)
		{
			this.CardCode=CodigoSN;
			this.CardName= NombreSN;
			this.CardType='C';
			this.GroupCode='100';
			this.CompanyPrivate='C';	
			this.Phone1=Telefono1;	
			this.Phone2=Telefono2;
			this.Fax=Fax;
			this.ContactPerson=PersonaContacto;
			this.PayTermsGrpCode='2';
			this.VatLiable= 'Y';	
			this.FederalTaxID=RFC;	
			this.SalesPersonCode=EmpleadoVentas;
			this.JsonCurrency='##';
			this.Cellular=TelefonoCelular;
			this.AdditionalID=CURP;
			this.CardForeignName=NombreExtranjero;
			this.ShipToDefault='FACTURAR A';	
			this.Territory=Territorio;
			this.BilltoDefault='FACTURAR A';
			this.Website=WebSite;	
			this.U_IDSAE=IDSAE;	
			this.U_IDSalesForce=IDSalesForce;
			this.U_IDContactoSF=IDContactoSalesForce;
			this.U_Genero='NS';	
			this.U_Edad='';	
			this.U_AreasInteres='';
			this.U_AreasExperiencia='';
			this.U_PrepAcademica='';
			this.U_OtrosEstudios='';
			this.U_OTROSCONOCIMIENTOS='';
			this.U_Idiomas='';
			this.U_UltimasVacantes='';
			this.U_FechaUltPost1= '';	
			this.U_FechaUltPost2='';
			this.U_FechaUltPost3='';
			this.U_EstatusCV='ND';	
			this.U_CodOfertaInt='';	
			this.U_DesOfertaInt='';
			this.U_CursoInteres='';
			this.U_FechaContacto='';
			this.U_HorarioContacto='';
			this.U_Comentarios='';
			this.U_RecibirInfo='';
			this.AddressName='FACTURAR A';
			this.Street=Calle;
			this.Block=Colonia;
			this.ZipCode=CodigoPostal;
			this.City='';
			this.County=Municipio;
			this.Country=Pais;
			this.State=Estado;
			this.BPFederalTaxID='';
			this.TaxCode=DefinicionImpuesto;
			this.AddressType='S';
			this.StreetNo=NoExterior;	
			this.U_NoInt=NoInterior;
			this.JsonName=PersonaContacto;
			this.Position=ContactoPuesto;
			this.Address=ContactoDireccion;
			this.CEPhone1=ContactoTelefono1;
			this.CEPhone2=ContactoTelefono2;
			this.MobilePhone=ContactoCelular;
			this.CEFax=ContactoFax;
			this.E_Mail=ContactoEmail;
			this.Pager='';
			this.Remarks1='';
			this.Remarks2='';
			this.PlaceOfBirth='';
			this.DateOfBirth='';
			this.ActualizaSN=ActualizaSN;
		}
	}
    public class PaymentsSap{
    	public String CardCode { get; set; }
		public String Banco { get; set; }
		public String ImportePago { get; set; }
		public String TransferReference { get; set; }
		public String DocEntry { get; set; }
		public String U_EstatusdePago { get; set; }
		public String U_FechaPagoBancario { get; set; }
		public String U_ConceptodeCobro { get; set; }
        public String U_VL_TipoRelacion { get; set; }
        public String U_VL_UUIDRelacionado { get; set; }
		public PaymentsSap(String CardCodeI,String BancoI,String ImportePagoI,String TransferenceReferenceI,String DocEntryI,String U_EstatusdePagoI,
                           String U_FechaPagoBancarioI,String U_ConceptodeCobroI, String TipoRelacion, String UUIDRelacionado)
		{
			this.CardCode=CardCodeI;
			this.Banco=BancoI;
			this.ImportePago=ImportePagoI;
			this.TransferReference=TransferenceReferenceI;
			this.DocEntry=DocEntryI;
			this.U_EstatusdePago=U_EstatusdePagoI;
			this.U_FechaPagoBancario=U_FechaPagoBancarioI;
			this.U_ConceptodeCobro=U_ConceptodeCobroI;
            this.U_VL_TipoRelacion= TipoRelacion;
        	this.U_VL_UUIDRelacionado= UUIDRelacionado;
		}
    }

    public class SapPaymentResult{
    	public Boolean success { get; set; }
    	public String error { get; set; }
    	public List<String> DocList { get; set; } 
    	public SapPaymentResult(){
    		success=false;
    		error='';
    	   	DocList= new List<String>();
    	}
    	
    }
    
	static testMethod void TestOCCMClases() {
    		OCCMClases.ExecutionResult executionResult= new OCCMClases.ExecutionResult(true, 'Mensaje', null);
    		executionResult.success=true;
        	executionResult.message='Mensaje';
        	executionResult.objectResult=null;
    		OCCMClases.WsExecutionResult WsExecutionResult= new OCCMClases.WsExecutionResult(true, 'Mensaje', '');
    		WsExecutionResult.success=true;
        	WsExecutionResult.message='Mensaje';
        	WsExecutionResult.objectResult='';
    		OCCMClases.ExecutionResult executionResult1= new OCCMClases.ExecutionResult();
    		OCCMClases.WsExecutionResult WsExecutionResult1= new OCCMClases.WsExecutionResult();
    		OCCMClases.PersonalData PersonalData= new OCCMClases.PersonalData();
    		OCCMClases.Error error= new OCCMClases.Error();
    		error.item='';
    		error.message='';
    		OCCMClases.StatementString st= new OCCMClases.StatementString();
	    	st.Id=1;
	    	st.EntryDateToString= Date.today();
	        st.EntryDate='';
	        st.Amount=0.0;
	        st.ReferenceNumber='';
	        st.VirtualAccountId='';
	        st.VirtualAccountIdCompany='';
	        st.ReferenceAlpha='';
	        st.ReferenceBank='';
	        st.ModifiedDate='';          
	        st.Status='';
	        st.StatusID=0;
	        st.AuthorizationNumber='';
	        st.BankId=0;
	        st.Bank='';
        	st.PaymentFormId = 0;
        	st.PaymentForm = '';
    		OCCMClases.OCCMPurchase OCCMPurchase= new OCCMClases.OCCMPurchase();
    		OCCMClases.OCCMPurchaseString OCCMPurchaseString= new OCCMClases.OCCMPurchaseString();
    		OCCMClases.OCCMPackage OCCMPackage= new OCCMClases.OCCMPackage();
    		OCCMClases.OCCMPackage occpackage= new OCCMClases.OCCMPackage(-1, '', '','',-1.0,false,false,'',null,'');
    		OCCMClases.OCCMPackageString OCCMPackageString= new OCCMClases.OCCMPackageString();
    		OCCMClases.OCCMService OCCMService= new OCCMClases.OCCMService();
    		OCCMClases.AccountSummary AccountSummary= new OCCMClases.AccountSummary();
    		OCCMClases.CompanySummary CompanySummary= new OCCMClases.CompanySummary();
    		OCCMClases.CompanySummaryString CompanySummaryString= new OCCMClases.CompanySummaryString();
    		OCCMClases.StatementString Statement= new OCCMClases.StatementString();
    		OCCMClases.ContractSummary ContractSummary= new OCCMClases.ContractSummary();
    		OCCMClases.DocumentsSAP documentSAP = new OCCMClases.DocumentsSAP('01/01/2014','Cliente','InicioVigencia','FinVigencia','ComentarioVigencia','TipoFactura','Pagada',
														    					'CorreoAlterno','Origen','HoraCreacion','NombreEjecutivo','SerieDocumento','EmpleadoVentas',
														    					'OrdenCompra','idVentaCarrito','Moneda', 'TipoCambio','FolioSalesForce','ReferenciaCIE','TipoFacturacion',
														    					'OrdenCompra2','NumProveedor','ClasificacionFactura','EstatusFactura','ObservacionesSAP','CuentaVirtual',
														    					null,'FechaPago', '01', '1234', '04','');
			OCCMClases.DocumentLineSap documentlineSap= new OCCMClases.DocumentLineSap('xxxxxxxxxxx','10','10','0'); 														    					
			OCCMClases.BusinessPartnersSap bp=new OCCMClases.BusinessPartnersSap('CodigoSN','NombreSN','Telefono1','Telefono2','Fax','PersonaContacto','DefinicionImpuesto',
								'RFC','EmpleadoVentas','TelefonoCelular','CURP','NombreExtranjero','Territorio','WebSite',
								'IDSAE','IDSalesForce','IDContactoSalesForce','Calle','Colonia','CodigoPostal','Municipio',
								'Pais','Estado','NoExterior','NoInterior','ContactoPuesto','ContactoDireccion','ContactoTelefono1',
								'ContactoTelefono2','ContactoCelular','ContactoFax','ContactoEmail');
			OCCMClases.PaymentsSap paymentsSap = new OCCMClases.PaymentsSap('CardCodeI','BancoI','ImportePagoI','TransferenceReferenceI','DocEntryI','U_EstatusdePagoI','U_FechaPagoBancarioI','U_ConceptodeCobroI', '04','');	
						    					
			OCCMClases.Sales saleDef= new OCCMClases.Sales();
			
			OCCMClases.SapPaymentResult sapPaymentResult= new OCCMClases.SapPaymentResult();
			 
    		//OCCMClases.BusinessPartners bp= new BusinessPartners();
    		//OCCMClases.BusinessPartners bp= new OCCMClases.BusinessPartners(CodigoSN: CL0026250,NombreSN: AUTOX, S.A. de C.V.Telefono1: 333333333Telefono2: 333333331Fax: 333333332PersonaContacto: nullDefinicionImpuesto: IVAP16RFC: BTT991006VB6EmpleadoVentas: 0004TelefonoCelular: CURP: NombreExtranjero: AUTOXTerritorio: 1WebSite: www.autox.mxIDSAE: SAE0000001IDSalesForce: 001W000000G7JvcIAFIDContactoSalesForce: nullCalle: cigüeñasColonia: alamedaasCodigoPostal: 52970Municipio: AcambayPais: MéxicoEstado: Estado de MéxicoNoExterior: 29NoInterior: nullContactoPuesto: nullContactoDireccion: ContactoTelefono1: nullContactoTelefono2: nullContactoCelular: nullContactoFax: nullContactoEmail: null
    		
    		//'{'success":'true','error':'','doclist':[{'DocNumPago':'273952'},{'DocNumPago':'273953'}]}"
    		
    		OCCMClases.ContractSummary cs= new OCCMClases.ContractSummary();
		    cs.ActivationDate= '';
	        cs.AvailableItems= 0;
	        cs.ContractServiceId=0;
	        cs.ExpirationDate= '';
	        cs.ExpirationPeriod=0;
	        cs.IdValidityType=0;
	        cs.LastUpdatedDate= '';
	        cs.PackageCode= '';
	        cs.PackageId=0;
	        cs.PackageName= '';
	        cs.PaymentMethodId =0;
	        cs.PaymentMethodName= '';
	        cs.PurchasedItems =0;
	        cs.PurchaseId =0;
	        cs.PurchaseStateDescription= '';
	        cs.PurchaseStateId =0;
	        cs.RecruiterId= '';
	        cs.SalesforceDocument= '';
	        cs.ServiceId =0;
	        cs.ServiceName= '';
	        cs.ServiceType=0;
	        cs.UsedItems =0;
	        cs.ValidityType= '';

			OCCMClases.Sales sale=new OCCMClases.Sales();
    		sale.Documents= documentSAP;
    		sale.BusinessPartners= bp;
    		//sales.Payments= paymentsSap;
    	
    }
    static testMethod void TestSapPaymentResponse(){
    	List<String> lista= new List<String>(); 
    	lista.add('1234567');
    	OCCMClases.SapPaymentResult sapPaymentResult= new OCCMClases.SapPaymentResult();
    	sapPaymentResult.success=true;
    	sapPaymentResult.error= '';
    	sapPaymentResult.DocList= lista;
    
    }
	
}