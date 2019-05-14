/*********************************************************
*Clase de librerias utilizadas como soporte al webservice*
*********************************************************/
public with sharing class Funciones {
    /// <summary>
    /// Obtiene la decena proxima dado un numero cualquiera
    /// Ejemplo Numero 15 la decena proxima es el 20
    /// </summary>
    /// <param name="inputNumber">Numero de entrada el cual se va a calcular la decena siguiente.</param>
    /// <returns>Numero entero con el valor de la decena siguiente .</returns>
    public static Integer GetNextTens(Integer inputNumber){
    	Integer resultNumber=inputNumber;
        Integer salir=0;
        Salir = math.mod(inputNumber, 10);
        while (salir<>0){
            resultNumber=resultNumber + 1;
            salir= math.mod(resultNumber, 10);
        }
        //system.Debug(String.valueOf(Salir);
        return resultNumber;
    }
    
    /// <summary>
    /// Metodo asincrono que salesforce administra el momento en el que debe de ejecutarse despues de havber desbloqueado el registro
    /// Utilizado en un trigger,
    /// Se genera metodo asincrono porque el before insert aun no genera el folio por ser autonumerico
	/// El after insert tiene bloqueado el registro y no lo libera, entonces se genera asincrono para que desbloquee
	/// ejecute la actualizacion, hay que esperar unos segundos para que se actualice el dato.
    /// Genera el valor 
    /// </summary>
    /// <param name="inputNumber">Numero de entrada el cual se va a calcular la decena siguiente.</param>
    /// <returns>Numero entero con el valor de la decena siguiente .</returns>
    //Metodo asincrono para llamar el CIE desde SF
	@future (callout=true)
	public static void CreateCieValue(String oppId, String oportunityId)
	{
		//system.debug('Entre a CreateCieValue. ');
		Opportunity opp;
		try
		{
			opp = [SELECT Id, Referencia_Bancaria__c FROM Opportunity WHERE Id =: oppId];
		}
		catch(Exception e)
		{
			//system.debug('Error al obtener la opp. ' + e.getMessage());
		}
		
		if(opp != null)
		{
			opp.Referencia_Bancaria__c = GenerateOpportunityCie(oportunityId);
			//system.debug('antes de actualizar referencia = ' + opp.Referencia_Bancaria__c);
			update opp;
			//system.debug('El guardado no dio problema');
			//system.debug('despues de actualizar referencia = ' + opp.Referencia_Bancaria__c);
		}
	}
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static String GenerateOpportunityCie(String OportunityId){
        String MyReference=String.valueOf(OportunityId);
        Integer Sumatoria=0;
        Integer ValorMultiplicar;
        Integer NumeroReferencia;
        Integer DigitoVerificador=0;
        Integer i=0;Integer j=0;
        Integer Valor=0;
        for (i=0;i<MyReference.length();i++){
           if (math.mod(i, 2)==0){ 
                Valor=2;
            }else{
                Valor=1;
            }
            String ValorCadena=MyReference.substring(i,i + 1);
            NumeroReferencia=Integer.ValueOf(ValorCadena);
            ValorMultiplicar=Numeroreferencia * Valor;
            if (ValorMultiplicar>9){
                Integer SumaMayor=0;
                String Mayor= String.valueOf(ValorMultiplicar);
                for (j=0;j<Mayor.length();j++){
                    String ValorCadena2=Mayor.substring(j,j + 1);
                    SumaMayor=SumaMayor + integer.ValueOf(ValorCadena2);
                }   
                ValorMultiplicar=SumaMayor;
            }
            //system.Debug('Numero Referencia:' + NumeroReferencia + ' Valor:' + Valor + ' Valor a multiplicar:' + ValorMultiplicar);
            Sumatoria=Sumatoria + ValorMultiplicar;
        }
        //System.debug('Decena proxima: ' + DecenaProxima(Sumatoria));
        DigitoVerificador=GetNextTens(Sumatoria) - Sumatoria;
        MyReference=Myreference + DigitoVerificador;
        return MyReference;
    }
	
	/// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static Boolean GeneraTarea(String Asignar, String Comentarios, String Asunto, String WhoID){
    	//create a task for the user
        //Task newTask = new Task(Subject='Complete Survey for Transaction');
        User tmpUser=null;
		//sObject  resultUser;
        Set<String> UsuarioIdEnvio = new Set<String>();
        Boolean result=false;
        try
        {
        	tmpUser= [Select Id, Name From User WHERE  Name=:Asignar LIMIT 1];
        	if(tmpUser != null){
                DateTime Hoy=DateTime.now();
				Task newTask = new Task(
        						Description = Comentarios,
                                Priority = 'Normal',
                                Status = 'Inbound Email',
                                Subject = Asunto,
                                IsReminderSet = true,
                                ReminderDateTime = System.now()+1,
                                ActivityDate=System.today(),
                                //WhoId = WhoID,
                                OwnerId=tmpUser.Id
                                );
               insert newTask;
               result=true;
			}
			else{
				result=false;
			}
        }
        catch(Exception e)
        {
        	result=false;
        	
        	//System.debug('Error query Ctc: ' + e);
        } 
        //System.debug('Resultado GeneraTarea:' + result );
       return result;
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static Map<Boolean, String> GeneraTareaGeneral(String Asignar, String Asunto, String Comentarios){
        User tmpUser=null;
        Map<Boolean, String> result=new Map<Boolean, String>();
        Set<String> UsuarioIdEnvio = new Set<String>();
        String MsgResult='';
        Boolean Bandera=false;
        try
        {
        	tmpUser= [Select Id, Name From User WHERE  Name like : Asignar LIMIT 5];
        }
        catch(Exception e)
        {
        	//MsgResult=e.getMessage();
        	MsgResult+='Exepcion GeneraTareaGeneral tmpUser error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
        } 
        try
        {
        	if(tmpUser != null){
        		//system.debug('tarea a: ' + tmpUser.Id);
                DateTime Hoy=DateTime.now();
				Task newTask = new Task(
        						Description = Comentarios,
                                Priority = 'Normal',
                                Status = 'No iniciada',
                                Subject = Asunto,
                                IsReminderSet = true,
                                ReminderDateTime = System.now()+1,
                                ActivityDate=System.today(),
                                OwnerId=tmpUser.Id
                                );
               insert newTask;
               Bandera=true;
               MsgResult='';
			}
			else{
				MsgResult = 'No se inserto la tarea: ' + MsgResult;
				//system.debug('No genero tarea a: ');
			}
        }
        catch(Exception e)
        {
        	//system.debug('Exepcion en tarea General');
        	//MsgResult=e.getMessage() + ' ' + MsgResult;
        	MsgResult += 'Exepcion DeleteListProductsInOpportunity presupuesto error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
        } 
        //system.debug('Estatus tarea: ' + Bandera + ' Resultado: ' + MsgResult);
        result.Put(Bandera, MsgResult);
       return result;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static Map<Boolean, String> GeneraTareaProspecto(String Asignar, String Asunto, String Comentarios, String Prospecto){
        User tmpUser=null;
        Map<Boolean, String> result=new Map<Boolean, String>();
        Set<String> UsuarioIdEnvio = new Set<String>();
        String MsgResult='';
        Boolean Bandera=false;
        //system.debug('GeneraTareaProspecto: ' + Asignar);
        try
        {
        	tmpUser= [Select Id, Name From User WHERE Name=: Asignar LIMIT 1];
        }
        catch(Exception e)
        {
        	MsgResult=e.getMessage();
        	Bandera=false;
        	MsgResult='Exepcion en busqueda de usuario: ' + MsgResult;
        } 
        try
        {
        	if(tmpUser != null){
        		//system.debug('Creando tarea a: ' + tmpUser.Id);
                DateTime Hoy=DateTime.now();
				Task newTask = new Task(
        						Description = Comentarios,
                                Priority = 'Normal',
                                Status = 'No iniciada',
                                Subject = Asunto,
                                IsReminderSet = true,
                                ReminderDateTime = System.now()+1,
                                ActivityDate=System.today(),
                                OwnerId=tmpUser.Id,
                                WhoId= Prospecto
                                );
               //system.debug('Tarea creada');
               insert newTask;
               //system.debug('Tarea Insertada');
               Bandera=true;
               MsgResult='';
			}
			else{
				Bandera=false;
				MsgResult='No se inserto la tarea: ' + MsgResult;
				//system.debug('No genero tarea a: ');
			}
        }
        catch(Exception e)
        {
        	//system.debug('Exepcion en tarea');
        	MsgResult=e.getMessage() + ' ' + MsgResult;
        	Bandera=false;
        } 
        result.Put(Bandera, MsgResult);
        //system.debug('Estatus tarea: ' + Bandera + ' Resultado: ' + MsgResult);
       return result;
    }
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static Map<Id, String> ObtieneAQuienAsignarTarea(String GrupoEnvio){
    	String resultText='';
    	Map<Id, String> result= new Map<Id, String>();
    	Cuenta_Envio__c ce;
        List<Relacion_Cuenta_Envio_Usuario__c> cuentasUsuario = new List<Relacion_Cuenta_Envio_Usuario__c>();
        try
        {
        	ce = [SELECT Id, Name FROM Cuenta_Envio__c WHERE Name =: GrupoEnvio  LIMIT 1];
        }
        catch (Exception e)
        {
        }
        if(ce != null)
        {
	    	try
	        {
	        	//cuentasUsuario = [SELECT Cuenta_Envio__c, Usuario__r.Name, Usuario__r.Id FROM Relacion_Cuenta_Usuario__c WHERE Cuenta_Envio__c =: ce.Id];
	        	cuentasUsuario = [SELECT r.Usuario__r.Name, r.Usuario__r.Id, r.Usuario__c, r.Name, r.Cuenta_Envio__c FROM Relacion_Cuenta_Envio_Usuario__c r WHERE Cuenta_Envio__c=:ce.Id]; 
	        }
	        catch (Exception e)
	        {
	        }
	        try{
	        	
	        	if(cuentasUsuario != null)
	        	{
	        		for(Relacion_Cuenta_Envio_Usuario__c cu : cuentasUsuario)
	            	{
	            		//System.debug(cu.Usuario__r.Id + ' -tag- ' + cu.Usuario__r.Name);
            			result.put(cu.Usuario__r.Id, cu.Usuario__r.Name);
		        	}
		 		}
	        }
	        catch (Exception e)
	        {
	        }
      	}
      	return result;
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static String ObtienePropietario(String Cadena){
    	String result='';
    	if (Cadena.indexOf(':')>0){
    		result=Cadena.substring(0,Cadena.indexOf(':'));
    	}else{
    		result='';
    	}
    	return result;
    }
    
    /// <summary>
    /// 
    /// </summary>
    /// <param name="">.</param>
    /// <returns>.</returns>
    public static String ObtieneIdRegistro(String Cadena){
    	String result='';
    	if (Cadena.indexOf(':')>0){
    		result=Cadena.substring(Cadena.indexOf(':') + 1);
    	}else{
    		result='';
    	}
    	return result;
    }
    
    /// <summary>
    /// Regresa el time satamp en formato de string
    /// Ejemplo Numero 15 la decena proxima es el 20
    /// </summary>
    /// <param name="inputDate">Fecha de la cual se va a obtener el timestamp.</param>
    /// <returns>Numero entero con el valor de la decena siguiente .</returns>
    public static String convertTimeStamp(DateTime inputDate){
    	return String.valueOf(inputDate.year()) + String.valueOf(inputDate.month()) + String.valueOf(inputDate.day()) + String.valueOf(inputDate.hour()) 
    		+ String.valueOf(inputDate.minute()) + String.valueOf(inputDate.second());
    }
    
    /// <summary> Función que ingresa el objeto result que puede ser una lista de errores y regresa el string que contiene el listado de errores  
    /// </summary>
    /// <param name="objectResultErrorList">Puede contener una lista de errores o null.</param>
    /// <returns>Cadena con mensaje de errores 
    /// </returns>
    public static String GetMessageErrorFromListErrors(String resultObject){
		String messageResult='';
		//system.debug('LstErrores:' + resultObject);
		//system.debug('resultObject:' + resultObject + ':Valor.');
		try
		{
			if (String.isBlank(resultObject)){
				messageResult += 'Err: Desconocido mensaje: Se genero un error desconocido';
			}else{
				List<OCCMClases.Error> listError = (List<OCCMClases.Error>) System.JSON.deserialize(resultObject, List<OCCMClases.Error>.class);
				for(OCCMClases.Error Err: listError){
					messageResult += 'Err: ' + Err.item + ' mensaje:' + Err.message + '\n';
				}
			}
		}
		catch(Exception e)
		{
			messageResult +='Exepcion GetMessageErrorFromListErrors error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		//system.debug('messageResult:' + messageResult);
		return messageResult;
    }
    
    /// <summary> Función que ingresa el objeto result que puede ser una lista de errores y regresa el string que contiene el listado de errores  
    /// </summary>
    /// <param name="objectResultErrorList">Puede contener una lista de errores o null.</param>
    /// <returns>Cadena con mensaje de errores 
    /// </returns>
    public static String GetMessageErrorFromDeleteDML(Database.DeleteResult[] DR_Dels){
		String message='';
		try
		{
			for(Integer i=0; i< DR_Dels.size(); i++){
				Database.DeleteResult dl= DR_Dels[i];
				if (!dl.isSuccess())
				{
					for(Database.Error err : dl.getErrors())
				   	{
				   		message = message + 'Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage();
				   		//system.debug('Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage());
					}
			    }
			}
		}
		catch(Exception e)
		{
			message +='Exepcion GetMessageErrorFromListErrors error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		return message;
    }
    
    /// <summary> Función que ingresa el objeto result que puede ser una lista de errores y regresa el string que contiene el listado de errores  
    /// </summary>
    /// <param name="objectResultErrorList">Puede contener una lista de errores o null.</param>
    /// <returns>Cadena con mensaje de errores 
    /// </returns>
    public static String GetMessageErrorFromSaveDML(Database.SaveResult[] accUpdateResult){
		String message='';
		try
		{
			for(Integer i=0; i< accUpdateResult.size(); i++)
			{
				Database.SaveResult sr = accUpdateResult[i];
			    if (!sr.isSuccess())
			    {
			    	for(Database.Error err : sr.getErrors())
			    	{
			    		message = message + 'Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage();
			    		//system.debug('Error code: ' + err.getStatusCode() + ' message: ' +  err.getMessage());
			   		}
			    }
			}
		}
		catch(Exception e)
		{
			message +='Exepcion GetMessageErrorFromSaveDML error, causa: ' + e.getCause() + ' Linea:' +  e.getLineNumber() + ' Mensaje:' + e.getMessage() + ' Stack Trace: ' + e.getStackTraceString() + '.';
		}
		return message;
    }
    /// <summary> Función que Valida en base a una expresion regular si el campo es una cadena de correo electronico  
    /// </summary>
    /// <param name="email">Cadena a validar en string.</param>
    /// <returns>verdadero si es una cadena con formato de correo electronico 
    /// </returns>
    public static Boolean IsValidEmail(String email) {
		Boolean res = true;
		if (email==null)
		{
			res = false;
		}
		else{
			//String emailRegex = '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-​]+\\.[a-zA-Z]{2,4}$'; // source: http://www.regular-expressions.info/email.html
			String emailRegex = '([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}​\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z​]{2,4}|[0-9]{1,3})';
			Pattern MyPattern = Pattern.compile(emailRegex);
			Matcher MyMatcher = MyPattern.matcher(email);	
			if (!MyMatcher.matches()) 
		    	res = false;
		}
		return res;	
	}
    
    
    /****************
    Metodos de prueba
    *****************/
    static testMethod void TestGetMessageErrorFromListErrors() {
		String result=Funciones.GetMessageErrorFromListErrors(null);
		result=Funciones.GetMessageErrorFromListErrors('[]');
		result=Funciones.GetMessageErrorFromListErrors('{"item":"ErrCode","message":"Error valido en pruebas"}');
		result=Funciones.GetMessageErrorFromListErrors('ErrorEnCodigoDeEnvio');
		result=Funciones.GetMessageErrorFromListErrors('[{"item":"ErrCode","message":"Error valido en pruebas"},{"item":"ErrCodeNvo","message":"Error GeneradoManual"}]');
		result=Funciones.GetMessageErrorFromListErrors('[{"item":"ErrCode","message":"Error valido en pruebas"}]');
	}
	static testMethod void TestFunciones() {
		Profile profileUser = [SELECT Id, Name FROM Profile WHERE Name='Administrador del sistema'];  
		User userInfo = [SELECT Id, Name, FirstName, Username, AccountId, LastName, Alias, ProfileId 
							FROM User 
							WHERE ProfileId =: profileUser.Id AND // '00e50000000mxTvAAI' AND
								Alias =: 'bzava'
							LIMIT 1];
		Cuenta_Envio__c ce=new Cuenta_Envio__c();
		ce.Name='Atención a Clientes';
		//ce.Owner= Userinfo.Id;
		insert ce;
		Relacion_Cuenta_Envio_Usuario__c rce=new Relacion_Cuenta_Envio_Usuario__c();
		//rce.Name='CuentaEnviar';
		rce.Cuenta_Envio__c=ce.Id;
		rce.Usuario__c=userInfo.Id;
		
		ce=new Cuenta_Envio__c();
		ce.Name='Grupo sin usuarios';
		//ce.Owner= Userinfo.Id;
		insert ce;
				
    	Integer Valor=17;
    	Integer SigDecena=Funciones.GetNextTens(Valor);
    	Opportunity o = new Opportunity(AccountId=null, Name='opportunityName', 
                                        StageName='Prospecting', CloseDate=Date.today());
			Funciones.CreateCieValue('0000000000','00000000000');
			insert o;
			//Funciones.CreateCieValue(o.Id, o.NumFact__c.substring(6, o.NumFact__c.length()));
			Boolean ResBool= GeneraTarea('Benjamin Zavala Floran', 'Comentarios de la tarea', 'Creacion de tarea', '00QW0000001WFJM');
			Boolean ResBool1=GeneraTarea('Nadie', 'Comentarios de la tarea', 'Creacion de tarea', '00QW0000001WFJM');
			Map<Boolean, String> GeneraTarea=GeneraTareaGeneral('Benjamin Zavala Floran', 'Comentarios de la tarea', 'Creacion de tarea');
			Map<Boolean, String> GeneraTareaError=GeneraTareaGeneral('NadieExiste', 'Comentarios de la tarea', 'Creacion de tarea');
			//Map<Boolean, String> GeneraTareaExepcion=Funciones.GeneraTareaGeneral('Benjamin Zavala Floran', 
			//												'Comentaarios de la tarea', 
			//												'Creacion' );
			Map<Boolean, String> gtp=GeneraTareaProspecto('Benjamin Zavala Floran', 'Comentarios de la tarea', 'Creacion de tarea', '00QW0000001AM4h');
			Map<Boolean, String> gtpErr=GeneraTareaProspecto('Nadie', 'Comentarios de la tarea', 'Creacion de tarea', '00QW0000001AM4h');
			Map<Boolean, String> gtpErr2=GeneraTareaProspecto('Benjamin Zavala Floran', 'Comentarios de la tarea', 'Creacion de tarea', '');
			
			Map<Id, String> Aquien= ObtieneAQuienAsignarTarea('Atención a Clientes');
			Aquien= ObtieneAQuienAsignarTarea('Grupo sin usuarios');
			Aquien= ObtieneAQuienAsignarTarea('Grupo Desconocido');
			String Buscar='Benjamin Zavala Floran:00550000001vRL7';
			String Cadena=ObtienePropietario(Buscar);
			String Cadena1=ObtieneIdRegistro(Buscar);
			String BuscarErr='Benjamin Zavala Floran_00550000001vRL7';
			String CadenaErr=ObtienePropietario(BuscarErr);
			CadenaErr=ObtieneIdRegistro(BuscarErr);
			String BuscarErr2='Jose Cardenad:00550554000001RDRL7';
			CadenaErr=ObtienePropietario(BuscarErr2);
			CadenaErr=ObtieneIdRegistro(BuscarErr2);
			String Timestampe=convertTimeStamp(Datetime.now());
		
		Lead[] leadsDelete;
		List<Lead> leadToUpdate = new List<Lead>();
		 		
		Lead lead = new Lead();
		lead.FirstName='Nombre';
		lead.LastName='Apellido';
		lead.title='Posicion';
		lead.phone='0000000000';
		lead.email='email@email.com';
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
		lead.FirstName='NombreModificado';
		leadToUpdate.add(lead);
		GetMessageErrorFromSaveDML(Database.update(leadToUpdate, false));
		
		lead = new Lead();
		lead.FirstName='Nombre1';
		lead.LastName='Apellido1';
		lead.title='Posicion1';
		lead.phone='0000000001';
		lead.email='email1@email1.com';
		lead.Company='TestMethod1';
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
		lead.RFC__c= 'NEFA000000ABC';
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
		leadsDelete =  [SELECT Id, lead.FirstName,lead.LastName,lead.title,lead.phone,lead.email,lead.Company
								FROM Lead 
								Limit 2];
		Funciones.GetMessageErrorFromDeleteDML(Database.delete(leadsDelete));								
    }
    static testMethod void TestIsValidEmail() {
    	Boolean result=IsValidEmail('Esta No es una cuenta Valida');
    	result=IsValidEmail('CuentaValida@CuentaValida.com');
    	result=IsValidEmail(null);
    }
    //Libreria sacada de
    //http://apex-lang.googlecode.com/svn/trunk/eclipse-project/src/classes/SystemUtils.cls
    //public static String to18(String the15charID){
        ////a0BA0000000L2ZC  => a0BA0000000L2ZCMA0
        ////the15charID = 'a0BA0000000L2ZC'
        //final String BASE ='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456';

        //the15charID = the15charID.trim();
        //if(the15charID.length() == 18){
        //    return the15charID;
        //}
        //String result = '';
        //List<String> chars = null;
        //for(integer i = 0; i < 3; i++){
        //    chars = String.toCharArray(StringUtils.reverse(the15charID.substring(i*5,i*5+5)));
        //    String binary = '';
        //    for(String ch : chars){
        //        binary += Character.isUpperCase(ch) ? '1' : '0';
        //    }
        //    result += String.charAt(BASE,NumberUtils.parseInt(binary,2));
        //}
        //return the15charID + result;
        //return '';
    //}
    
    	
}