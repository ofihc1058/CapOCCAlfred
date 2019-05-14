trigger LeadsTrigger on Lead (before insert, after insert, before update) {
    Set<String> accountsToUpdate = new Set<String>();
	if(trigger.isBefore)
	{
		if (trigger.isInsert){
            for(Lead a : trigger.new){
                //Primero verificar si existe previamente regstrado, en caso de que asi sea entonces dara error de asignacion previa
                //system.debug('Datos: ' + a.Id + ' - ' + a.Initial_educative_offer__c);
                if (a.LeadSource.toLowerCase() == 'occ_web' || a.LeadSource.toLowerCase() == 'campaña'){

                    LeadManagement leadManagement= new LeadManagement(a.Id, string.isNotBlank(a.Phone)?a.Phone:a.MobilePhone);
                    system.debug('LeadManagement');
                    if (LeadManagement.Success==true){
                        string result=LeadManagement.GetUserToAssign('Desc');
                        system.debug('result: ' + result);
                        if (String.isNotBlank(result)){
                            a.OwnerId=result;
                        }else{
                            system.debug('result: False: ' + result);
                            system.debug('a no actualizado');
                        } 
                    }else{
                        system.debug('Error');
                        a.Management_Errors__c += json.serialize(LeadManagement.Errors);
						system.debug('GetGeneralLeadAssigner: ' + LeadManagement.GetGeneralLeadAssigner);
						if (string.isNotBlank(LeadManagement.GetGeneralLeadAssigner)){
							a.OwnerId=LeadManagement.GetGeneralLeadAssigner;
							system.debug('a.OwnerId' + a.OwnerId);
						}
                        system.debug(LeadManagement.Errors);
                    }
               }
                
            }
        }
		if (trigger.isUpdate){
            for(Lead a : trigger.new){
                system.debug('a');
                system.debug(a);
                LeadScoringOcc ls= new LeadScoringOcc('Lead', a.Id, (Object)a);
                system.debug('ls.LeadScoringVal' +  string.valueOf(ls.LeadScoringVal));
                a.ls_lead_scoring__c = ls.LeadScoringVal;
                if (ls.Errors.size() == 0){
                    a.ls_lead_scoring_message__c = JSON.serialize(ls.Errors);
                }
            }    
        }  
	}
	if(trigger.isAfter)
    {
        if (trigger.isInsert){  
			for(Lead a : trigger.new){
                Lead leadAct = [select Id, OwnerId, Management_Errors__c, Phone, MobilePhone, LeadSource from Lead where Id=:a.Id];
                if (leadAct.LeadSource.toLowerCase() == 'occ_web' || leadAct.LeadSource.toLowerCase() == 'campaña' ){
                    string createLeadAssignation= AssignedLeadCreation.CreateLeadSignation(leadAct.OwnerId, leadAct.Id, string.isNotBlank(leadAct.Phone)?leadAct.Phone:leadAct.MobilePhone);
                    system.debug('createLeadAssignation');
                    system.debug(createLeadAssignation);
                    if (string.isNotBlank(createLeadAssignation)){
                        leadAct.Management_Errors__c +='Creacion en Assigned Leads con errores: ' + createLeadAssignation;
                    }  
                }
                update leadAct;
                //Agrega el contacto una vez que inserta la cuenta
            }
		}
	}
}

/*Trigger isBefore
if(trigger.isBefore)
	{
	if(trigger.isUpdate)
			{
				//Cuando actualiza la oprtunidad si se cambia alguno de los datos de facturacion reenvia esta informacion a OOCM para su actualizacion
				for(Lead a : trigger.new)
				{
					if(a.Is_Future_Context__c)
					{
						a.Is_Future_Context__c = false;
					}
					else
					{
						if (a.OCCM_Cuenta_Administradora__c!=null && a.OCCM_Cuenta_Administradora__c!=''){
							if(a.RFC__c != trigger.oldMap.get(a.Id).RFC__c)
							{
								//System.debug('Nuevo RFC: ' + a.RFC__c);
								//System.debug('Antiguo RFC: ' + trigger.oldMap.get(a.Id).RFC__c);
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}

							if(a.Calle_o__c != trigger.oldMap.get(a.Id).Calle_o__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}

							if(a.No_de_Exterior_de_Facturacion__c != trigger.oldMap.get(a.Id).No_de_Exterior_de_Facturacion__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.No_de_interior_de_Facturacion__c != trigger.oldMap.get(a.Id).No_de_interior_de_Facturacion__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.Colonia__c != trigger.oldMap.get(a.Id).Colonia__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.DelegMunic_o__c != trigger.oldMap.get(a.Id).DelegMunic_o__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.Estado__c != trigger.oldMap.get(a.Id).Estado__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.CodPostal_o__c != trigger.oldMap.get(a.Id).CodPostal_o__c)
							{
								if(!accountsToUpdate.contains(a.Id))
								{
									accountsToUpdate.add(a.Id);
								}
							}
							if(a.Pais_o__c != trigger.oldMap.get(a.Id).Pais_o__c)
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
							//if(a.Company != trigger.oldMap.get(a.Id).Company)
							//{
							//	if(!accountsToUpdate.contains(a.Id))
							//	{
							//		accountsToUpdate.add(a.Id);
							//	}
							//}
						}//else{
						//	a.addError('Guardado satisfactorio. Informacion no enviada a OCCM por no pertenecer al modelo de paquetes');
						//}
					}
				}
				if(!accountsToUpdate.isEmpty())
				{
					//System.debug('Invocando al WS Recruiter Data Service...');
					WSSalesforceRecluta.UpdateLeadInvoiceInformation(accountsToUpdate);
				}
			}
	}
	*/