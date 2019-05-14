//after delete, after insert, after undelete, after update, before delete, before insert,
//Todos los triggers de Account se almacenaran aqui
trigger AccountTriggers on Account (before update) {
     
    Set<String> accountsToUpdate = new Set<String>();
    if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            //Cuando actualiza la oprtunidad si se cambia alguno de los datos de facturacion reenvia esta informacion a OOCM para su actualizacion
            //System.debug('Entro a buscar cambios');
            for(Account a : trigger.new)
            {
                //System.debug('For Busco que cambio...');
                if (a.OCCM_Cuenta_Administradora__c!= null &&  a.OCCM_Cuenta_Administradora__c!='' && a.OCCM_Password_Cuenta_Administradora__c!= null &&  a.OCCM_Password_Cuenta_Administradora__c!=''){
                    //System.debug('Esquema de nuevo modelo ...');
                    if(a.Is_Future_Context__c)
                    {
                        a.Is_Future_Context__c = false;
                    }
                    else
                    {
                        a.Is_Future_Context__c = true;
                        //Alfredo comenta que 
                        //El RFC no es modificable, al igual que cliente SAE y cliente SAP
                        //En caso de requerir cambio se creara una cuenta nueva
                        // Se va a restringir el acceso a nivel layout
                        if(a.RFC_o__c != trigger.oldMap.get(a.Id).RFC_o__c)
                        {
                            //System.debug('Nuevo RFC: ' + a.RFC_o__c);
                            //System.debug('Antiguo RFC: ' + trigger.oldMap.get(a.Id).RFC_o__c);
                            
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
    
                        if(a.Name != trigger.oldMap.get(a.Id).Name)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
    
                        if(a.CalleFact_o__c != trigger.oldMap.get(a.Id).CalleFact_o__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        
                        if(a.No_de_Exterior__c != trigger.oldMap.get(a.Id).No_de_Exterior__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.No_de_interior__c != trigger.oldMap.get(a.Id).No_de_interior__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.Colonia_de_Facturaci_n__c != trigger.oldMap.get(a.Id).Colonia_de_Facturaci_n__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.DelegMunicFact_o__c != trigger.oldMap.get(a.Id).DelegMunicFact_o__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.EstadoFact_o__c != trigger.oldMap.get(a.Id).EstadoFact_o__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.CodigoPostalFact_o__c != trigger.oldMap.get(a.Id).CodigoPostalFact_o__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.PaisFact_o__c != trigger.oldMap.get(a.Id).PaisFact_o__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.Cuenta_Virtual_Banamex__c != trigger.oldMap.get(a.Id).Cuenta_Virtual_Banamex__c)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                        if(a.OwnerId != trigger.oldMap.get(a.Id).OwnerId)
                        {
                            if(!accountsToUpdate.contains(a.Id))
                            {
                                accountsToUpdate.add(a.Id);
                            }
                        }
                    }
                }
                
            }
            
            if(!accountsToUpdate.isEmpty())
            {
                //System.debug('Invocando al WS Recruiter Data Service...');
                
                WSSalesforceRecluta.UpdateAccountInvoiceInformation(accountsToUpdate);
            }
            
        }
    }
}