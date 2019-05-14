public with sharing class LeadScoringOcc {
	public double LeadScoringVal {get; private set;}
    private string ObjectToProcess {get; set;}
    private string IdObject {get; set;}
    private Map<string, OCCMClasesV2.ScoreLeadProperties> scoreLeadPropertiesMap {get; set;}
    private Map<string, Rule__c> rulesList {get; set;}
    public Map<string, string> Errors {get; set;}
    public LeadScoringOcc(){
        
    }

	private void  FillInitialData(string objectProcess, string idObject){
        this.Errors = new Map<string, string>();
    	this.LeadScoringVal =0.0;
        this.ObjectToProcess = objectProcess;
        this.IdObject=idObject;
        //system.debug('Id');
        //system.debug(this.IdObject);
        this.scoreLeadPropertiesMap = new Map<string, OCCMClasesV2.ScoreLeadProperties>();
        this.rulesList = new Map<string, Rule__c>();
        FillRules();
        FillObjectFields();
    }
    public LeadScoringOcc(string objectProcess, string idObject ){
        FillInitialData(objectProcess, idObject);
        FillScoreLeadPropertiesValues();
        CalculateLeadScore();
    }
    public LeadScoringOcc(string objectProcess, string idObject, object objProcess){
        FillInitialData(objectProcess, idObject);
        FillScoreLeadPropertiesValuesFromObject(objProcess);
        CalculateLeadScore();
    }
    private void FillRules(){
        List<Rule__c> ruleList= new List<Rule__c>();
        string query= 'SELECT Active__c, Field__c, Messure__c, Name, Operation__c, Id, Object__c,Default_Weighing__c  FROM Rule__c WHERE Active__c = true and Object__c =\''+ 
                        String.escapeSingleQuotes(ObjectToProcess)+'\'';
        //system.debug('query:' + query); 
        try{
            System.debug(query);
            ruleList = Database.query(query);
            System.debug(ruleList);
            for(Rule__c rul: ruleList){
                System.debug('Field__c');
                System.debug(rul.get('Field__c'));
                rulesList.put(rul.Field__c, rul);
            }
            //system.debug('ruleList');
            //system.debug(ruleList);
        }
        catch (Exception e) {
			system.debug(e);
            Errors.put('FillRules', e.getCause() + '---' + e.getMessage());
        }
        
        //Comentado solo se utiliza para ver el listado de reglas que se tiene 
        Set<String> fieldSet = rulesList.keySet();
        for(string rul: fieldSet){
        	System.debug('Field__c: ');
            System.debug(rul);
        } 
		
    }
    private void FillObjectFields(){
        OCCMClasesV2.ScoreLeadProperties lc= new OCCMClasesV2.ScoreLeadProperties();
        SObjectType objToken = Schema.getGlobalDescribe().get(ObjectToProcess);
        DescribeSObjectResult objDef = objToken.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
        Set<String> fieldSet = fields.keySet();
        for(String s: fieldSet)
        {
            SObjectField fieldToken = fields.get(s);
            DescribeFieldResult selectedField = fieldToken.getDescribe();
            system.debug('FieldSet');
            system.debug(s);
            string dataType=ConvertType(selectedField.getType());
            if (dataType=='NotSupported'){
            	Errors.put('convert-' + selectedField.getName(), 'Could not convert data type');    
            }else{
            	lc= new OCCMClasesV2.ScoreLeadProperties(selectedField.getName(), dataType, null,  selectedField.getType());
            	scoreLeadPropertiesMap.put(selectedField.getName(), lc);    
            }
        }
        
    }
    private string ConvertType(Schema.DisplayType dataType){
        string typeString='NotSupported';
        if (dataType == Schema.DisplayType.REFERENCE){typeString='string';}
        if (dataType == Schema.DisplayType.address){typeString='address';}
        if (dataType == Schema.DisplayType.Boolean){typeString='boolean';}
        if (dataType == Schema.DisplayType.Combobox){typeString='combobox';}
        if (dataType == Schema.DisplayType.Currency){typeString='currency';}
        if (dataType == Schema.DisplayType.Date){typeString='date';}
        if (dataType == Schema.DisplayType.DateTime){typeString='datetime';}
        if (dataType == Schema.DisplayType.Double){typeString='double';}
        if (dataType == Schema.DisplayType.Email){typeString='email';}
        if (dataType == Schema.DisplayType.ID){typeString='id';}
        if (dataType == Schema.DisplayType.Integer){typeString='integer';}
        //if (dataType == Schema.DisplayType.Long){typeString='Long';}
        if (dataType == Schema.DisplayType.Percent){typeString='percent';}
        if (dataType == Schema.DisplayType.Phone){typeString='phone';}
        if (dataType == Schema.DisplayType.Picklist){typeString='picklist';}
        if (dataType == Schema.DisplayType.String){typeString='string';}
        if (dataType == Schema.DisplayType.TextArea){typeString='textarea';}
        if (dataType == Schema.DisplayType.Time){typeString='time';}
        if (dataType == Schema.DisplayType.URL){typeString='url';}
        return typeString;
    } 
    private void FillScoreLeadPropertiesValues(){
        string fields='';
        for(OCCMClasesV2.ScoreLeadProperties scprop: this.scoreLeadPropertiesMap.values()){
            fields = fields + scprop.Name + ',';
        }
        fields = fields.substring(0,fields.lastIndexOf(','));
        //system.debug(fields);
        //system.debug(ObjectToProcess);
        //system.debug(IdObject);
        string queryProp= 'SELECT ' + fields + ' FROM ' + ObjectToProcess + ' WHERE Id = \''+ String.escapeSingleQuotes(IdObject.trim())+'\'';
        system.debug(queryProp);
        
        try{
            sObject sobjList = Database.query(queryProp);
            //system.debug('sObjectList');
            //system.debug(sobjList);
            //system.debug('Props a eval');
            for(OCCMClasesV2.ScoreLeadProperties scprop: this.scoreLeadPropertiesMap.values()){
                scprop.Value=sobjList.get(scprop.Name);
                // system.debug(sobjList.get(scprop.Name));
            }
        }
        catch (Exception e) {
            system.debug('Exception: ');
			system.debug(e);
            Errors.put('fillscorelead', e.getCause() + '---' + e.getMessage());
        } 
        
        for(OCCMClasesV2.ScoreLeadProperties scprop: this.scoreLeadPropertiesMap.values()){
                system.debug(scprop.Name + ', ' + scprop.Type + ', ' + scprop.DataType + ', '+  scprop.Value);
        }
        //for(string er: Errors.values()){
        //    system.debug('err' + er);
        //}
    }
    private void FillScoreLeadPropertiesValuesFromObject(object objProcess ){
        try{
            string json_text= JSON.serialize(objProcess);
            Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(json_text);
            //system.debug('jsonMap : ');
            //system.debug( meta.get('Id') );
            for(OCCMClasesV2.ScoreLeadProperties scprop: this.scoreLeadPropertiesMap.values()){
                scprop.Value=meta.get(scprop.Name);
            }
        }
        catch (Exception e) {
            system.debug('Exception: ');
			system.debug(e);
            Errors.put('fillscoreleadFromObject', e.getCause() + '---' + e.getMessage());
        } 
        /*
        system.debug('PropertiesValues');
        for(EduClasses.ScoreLeadProperties scprop: this.scoreLeadPropertiesMap.values()){
            if (string.valueOf(scprop.Value) <> '' )
                system.debug(scprop.Name + ', ' + scprop.Type + ', ' + scprop.DataType + ', '+  scprop.Value);
        } 
		*/
        //for(string er: Errors.values()){
        //    system.debug('err' + er);
        //}
    }
    private void CalculateLeadScore(){
        OCCMClasesV2.ScoreLeadProperties obj= new OCCMClasesV2.ScoreLeadProperties();
        double leadscore=0.0;
        system.debug('Entro a calcular');
        for (Rule__c rul : rulesList.values()){
            system.debug('rulNew: ' + rul.Field__c);
            if (scoreLeadPropertiesMap.containsKey(rul.Field__c)){
                system.debug('containrule: ' + rul.Field__c);
                obj= scoreLeadPropertiesMap.get(rul.Field__c);
                system.debug('obj:' + obj );
                system.debug('objType:' + obj.Type );
            	List<RulesDetails__c> rd= [SELECT Name, Id, Rule__c, value1__c,	value2__c, weighing__c, LastActivityDate, LastModifiedById, IsDeleted
                                          FROM RulesDetails__c
                                          WHERE Rule__c =: rul.Id];
                if ( obj.Type == 'string' || obj.Type == 'textarea' || obj.Type == 'id' || obj.Type == 'email' || obj.Type == 'phone' || obj.Type == 'picklist' || obj.Type == 'url'  ){
                	leadscore = leadscore + GetScore(String.valueOf(obj.Value), rul.Operation__c, rd, rul.Default_Weighing__c, 'string', rul.Field__c);
                }
                else
	                if ( obj.Type == 'double' || obj.Type == 'decimal' || obj.Type == 'integer' || obj.Type == 'percent' || obj.Type == 'currency' ){
                        system.debug('GetScore(String.valueOf('+ obj.Value + '), ' + rul.Operation__c + ', ' + rd + ', ' + rul.Default_Weighing__c + ',' + 'number'+ ', ' + rul.Field__c +')');
	                	leadscore = leadscore + GetScore(String.valueOf(obj.Value), rul.Operation__c, rd, rul.Default_Weighing__c, 'number', rul.Field__c);
	                }
	                else{
                        if ( obj.Type == 'date' || obj.Type == 'datetime' || obj.Type == 'time' ){
                        	system.debug('GetScore(String.valueOf('+ obj.Value + '), ' + rul.Operation__c + ', ' + rd + ', ' + rul.Default_Weighing__c + ',' + 'number'+ ', ' + rul.Field__c +')');
	                		leadscore = leadscore + GetScore(String.valueOf(obj.Value), rul.Operation__c, rd, rul.Default_Weighing__c, 'date', rul.Field__c);
	                    }
                        else{ 
                            if ( obj.Type == 'boolean'  || obj.Type == 'combobox'){
                                system.debug('GetScore(String.valueOf('+ obj.Value + '), ' + rul.Operation__c + ', ' + rd + ', ' + rul.Default_Weighing__c + ',' + 'number'+ ', ' + rul.Field__c +')');
                                leadscore = leadscore + GetScore(String.valueOf(obj.Value), rul.Operation__c, rd, rul.Default_Weighing__c, 'hour', rul.Field__c);
                            }
                            else{
                                Errors.put(rul.Field__c, 'The propertie value was not applied to lead scoring');
                            }
                        }
	                }
            }
            else
            {
                Errors.put(rul.Field__c, 'The field not exist in list fields');
            }
        }
        this.LeadScoringVal=leadscore;
        //system.debug('Salgo a calcular');
    }
    private Decimal GetScore(string value, string operation, List<RulesDetails__c> rd, Decimal default_value, string type, string ruleName) { 
        Decimal result=0.0;
        Boolean found=false;
        if (operation == '='){
        	for(RulesDetails__c rulDet: rd){
                if (string.valueOf(rulDet.value1__c) == string.valueOf(value)){
        			result = result + rulDet.weighing__c;
                    found = true;
                	system.debug('string' + ',' + rulename +', ' + ', = , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
            	}
            } 
        }
        if (operation == '<>'){
        	for(RulesDetails__c rulDet: rd){
                if (string.valueOf(rulDet.value1__c) != string.valueOf(value)){
    				result = result + rulDet.weighing__c;
                    found = true;
                    system.debug('string' + ',' + rulename +', ' + ',<> , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                }
            }
        }       
        if (operation == '>'){
            system.debug('operation ' +  string.valueOf(operation));
        	if ( type == 'number'){
                    system.debug('number ' +  double.valueOf(value));
                	for(RulesDetails__c rulDet: rd){
                        system.debug('rulValue ' +  double.valueOf(rulDet.value1__c));
                        if (double.valueOf(value) > double.valueOf(rulDet.value1__c)){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('number' + ',' + rulename +', ' + ',> , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }
                    }    
            }
            else{
                Errors.put(ruleName, 'The rule apply only to numeric values ');
            }
        }
        if (operation == '<'){
        	if ( type == 'number'){
                	 for(RulesDetails__c rulDet: rd){
                        if (double.valueOf(value) < double.valueOf(rulDet.value1__c) ){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('number' + ',' + rulename +', ' + ', < , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }
                    }   
            }
            else{
                Errors.put(ruleName, 'The rule apply only to numeric values ');
            }
        }
        if (operation == 'IN' ){
        	if ( type == 'string'){
                	for(RulesDetails__c rulDet: rd){
                        system.debug('regla a evaluar');
                        system.debug('rulDet:');
                        system.debug(string.valueOf(rulDet.value1__c));
                        system.debug('value:');
                        system.debug(value);
                        
                        //if (string.valueOf(rulDet.value1__c).contains(value)){
                        if (string.valueOf(value).contains(rulDet.value1__c)){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('string' + ',' + rulename +', ' + ',IN , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }
                    }	    
                }
                else{
                    Errors.put(ruleName, 'The rule was not applied to IN rule value: ' + value);
                }
        }
        if (operation == 'NOTIN'){
        	if ( type == 'string'){
                	for(RulesDetails__c rulDet: rd){
                        if (!string.valueOf(value).contains(rulDet.value1__c)){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('string' + ',' + rulename +', ' + ',NotIn , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }  
                    }	    
                }
                else{
                    Errors.put(ruleName, 'The rule was not applied to NOTIN rule value: ' + value);
                }
        }
        if (operation == 'Start'){
        	if ( type == 'string'){
                	for(RulesDetails__c rulDet: rd){
                        if (string.valueOf(value).StartsWith(rulDet.value1__c)){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('string' + ',' + rulename +', ' + ',stat , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }
                    }	    
                }
                else{
                    Errors.put(ruleName, 'The rule was not applied to Start rule value: ' + value);
                }
        }
        if (operation == 'Between'){
            system.debug('operation ' +  string.valueOf(operation));
        	if ( type == 'number'){
                    system.debug('number ' +  double.valueOf(value));
                	for(RulesDetails__c rulDet: rd){
                        system.debug('regla a evaluar');
                        system.debug('rulDet1:');
                        system.debug(string.valueOf(rulDet.value1__c));
                        system.debug('rulDet2:');
                        system.debug(string.valueOf(rulDet.value2__c));
                        system.debug('value:');
                        system.debug(value);
                        system.debug('double.valueOf(value) >= double.valueOf(rulDet.value1__c) && double.valueOf(value) <= double.valueOf(rulDet.value1__c)');
                        system.debug(string.valueOf(double.valueOf(value)) + '>=' + string.valueOf(double.valueOf(rulDet.value1__c)) + ' && ' + string.valueOf(double.valueOf(value)) + '<=' + string.valueOf(double.valueOf(rulDet.value1__c)) );
                        
                        if (double.valueOf(value) >= double.valueOf(rulDet.value1__c) && double.valueOf(value) <= double.valueOf(rulDet.value2__c)){
                            result = result + rulDet.weighing__c;
                            found = true;
                            system.debug('number' + ',' + rulename +', ' + ',> , ' +string.valueOf(value) +', value: ' + rulDet.weighing__c);
                        }
                    }    
            }
            else{
                Errors.put(ruleName, 'The rule apply only to numeric values ');
            }
        }

        if (found == false){
            result = default_value;
        }
        return result;
    }   

}