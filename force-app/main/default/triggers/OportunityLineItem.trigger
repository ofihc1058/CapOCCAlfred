trigger OportunityLineItem on OpportunityLineItem (before insert, before update, before delete) {
	if (trigger.isBefore){
		if (trigger.isInsert){
			System.debug('Entro a cambiar precio de descuento');
            System.debug('trigger' + Json.serialize(trigger.new));
            for(OpportunityLineItem opli: trigger.new){
                Opportunity opp= [Select Id, Producto_NGB__c, Producto_Empleo_Listo__c, Producto_OCCEjecutivo__c From  Opportunity Where Id=: opli.OpportunityId];
                system.debug('ObjetoTrigger: ' + Json.serialize(opli));
                Product2 prod= [select Id, ProductCode, Family from Product2 where Id=: opli.Product2Id];   
                system.debug('ProductCode: ' + prod.ProductCode);
                if (prod.ProductCode.endsWith('F')){
                    if (opli.Subtotal>0){
                		//opli.Descuento__c=opli.Subtotal - 0.01;
                        opli.Discount=100;
                        //opli.Discount=99.90;
                    }
                }
                if (prod.Family=='Negocio base' || prod.Family=='Empleolisto' || prod.Family=='OCCEjecutivo'){
                    if (prod.Family=='Negocio base'){
                        opp.Producto_NGB__c= true;
                    }
                    if (prod.Family=='Empleolisto'){
                        opp.Producto_Empleo_Listo__c= true;                   
                    }
                    if (prod.Family=='OCCEjecutivo'){
                        opp.Producto_OCCEjecutivo__c= true;
                    }
                    update opp;
                }
            }
            
		}
		if (trigger.isUpdate){
			System.debug('Entro a cambiar precio de descuento');
            for(OpportunityLineItem opli: trigger.new){
                Product2 prod= [select Id, ProductCode, Family from Product2 where Id=: opli.Product2Id];   
                system.debug('ProductCode: ' + prod.ProductCode);
                if (prod.ProductCode.endsWith('F')){
                    if (opli.Subtotal>0){
                		//opli.Descuento__c=opli.Subtotal - 0.01;
                        opli.Discount=100;
                        //opli.Discount=99.90;
                    }
                }
				system.debug('Objeto: ' + Json.serialize(opli));                
            }  
		} 
        if (trigger.isDelete){
            system.debug('Entro');
			for(OpportunityLineItem opli: trigger.old){
                Opportunity opp= [Select Id, Producto_NGB__c, Producto_Empleo_Listo__c, Producto_OCCEjecutivo__c From  Opportunity Where Id=: opli.OpportunityId];
                system.debug(opp);
                Product2 prod= [select Id, ProductCode, Family from Product2 where Id=: opli.Product2Id]; 
                system.debug(prod);
                system.debug('ProductCode: ' + prod.ProductCode);
                if (prod.Family=='Negocio base' || prod.Family=='Empleolisto' || prod.Family=='OCCEjecutivo'){
                    if (prod.Family=='Negocio base'){
                        opp.Producto_NGB__c= false;
                    }
                    if (prod.Family=='Empleolisto'){
                        opp.Producto_Empleo_Listo__c= false;                   
                    }
                    if (prod.Family=='OCCEjecutivo'){
                        opp.Producto_OCCEjecutivo__c= false;
                    }
                    update opp;
                }
            }
            
        }
	}   
}