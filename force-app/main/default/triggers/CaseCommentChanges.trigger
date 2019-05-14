trigger CaseCommentChanges on CaseComment (after insert, after delete) {
	if(trigger.isInsert){
        //system.debug('isinsert');
        if(trigger.isAfter)
        {
            system.debug('isAfter');
            //Despues de insertar la oportunidad actaliza el CIE que es de lectura
            for(CaseComment cc : trigger.new)
            {
            	//Integer cuantos= [SELECT count(Id) FROM CaseComment];
            	//Integer cuantos = [select count() from CaseComment WHERE ParentId =: cc.ParentId];	
            	//system.debug('Cuantos: ' + cuantos);
            	//if (cuantos>1){
            		//system.debug('Caso cambiado: ' + cc.Id);
            		Case caso;
            		caso = [SELECT Id, Sin_Comentario__c FROM Case WHERE Id =: cc.ParentId];
					caso.Sin_Comentario__c=true;
					update caso;
            	//}
            }
        }
	}
	
	if(trigger.IsDelete){
        system.debug('IsDelete');
        if(trigger.isAfter)
        {
            system.debug('isAfter');
            //Despues de insertar la oportunidad actaliza el CIE que es de lectura
            for(CaseComment cc : trigger.old)
            {
            	Integer cuantosDel = [select count() from CaseComment WHERE ParentId =: cc.ParentId];	
            	system.debug('Cuantos: ' + cuantosDel);
            	if (cuantosDel==0){
            		Case caso;
		            caso = [SELECT Id, Sin_Comentario__c FROM Case WHERE Id =: cc.ParentId];
					caso.Sin_Comentario__c=false;
					update caso;
            	}
            }
        }
	}
	
}