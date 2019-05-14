@isTest
private class OCCMClasesV2Test {
    @isTest static void test_method_one() {
    	OCCMClasesV2.ScoreLeadProperties scoreLeadPropertiesMap= new OCCMClasesV2.ScoreLeadProperties();
    	scoreLeadPropertiesMap.Name='';
    	scoreLeadPropertiesMap.Type='';
    	scoreLeadPropertiesMap.DataType= Schema.DisplayType.Currency;
    	scoreLeadPropertiesMap.Value= 'String';
    	scoreLeadPropertiesMap= new OCCMClasesV2.ScoreLeadProperties('','', 'string', Schema.DisplayType.Currency);
    	
    	OCCMClasesV2.ExecutionResult executionResult = new OCCMClasesV2.ExecutionResult(); 
    	executionResult.success=true;
    	executionResult.message='';
    	executionResult.objectResult = 'String';
    	executionResult = new OCCMClasesV2.ExecutionResult(true, '','string');
    	
    	OCCMClasesV2.Assignation ass= new OCCMClasesV2.Assignation();
        
        OCCMClasesV2.AccountDto adto= new OCCMClasesV2.AccountDto();
        adto.Id = '';
        adto.LastName = '';
        adto.FirstName = '';
        adto.Email = '';
        adto.Phone = '';
        adto.Rfc = '';
        adto.OccAdministrativeAccount = '';
        adto.Company = '';
        adto.LeadSource = '';
        adto.OriginDetail = '';
        adto.CampaignTracking = '';
        adto.EmployeesNumber = '';
        adto.Industry = '';
        adto.BusinessActivity = '';
        adto.PostalCode = '';
        adto.State = '';
        adto.City = '';
        adto.Country = '';
        adto.Website = '';
        adto.Description = '';
        adto.CommercialName = '';
        adto.Logo = '';
        adto.WhyJoinUs = '';
        adto.NoLeads = 0.0;
        adto.OwnerId = '';
          
        OCCMClasesV2.LeadDto ldto= new OCCMClasesV2.LeadDto();
        ldto.Id = '';
        ldto.LastName = ''; 
        ldto.FirstName = '';
        ldto.Email = '';
        ldto.Phone = '';
        ldto.Rfc = '';
        ldto.OccAdministrativeAccount = '';
        ldto.Company = '';
        ldto.LeadSource = '';
        ldto.OriginDetail = '';
        ldto.CampaignTracking = '';
        ldto.EmployeesNumber = '';
        ldto.Industry = '';
        ldto.BusinessActivity = '';
        ldto.PostalCode = '';
        ldto.State = '';
        ldto.City = '';
        ldto.Country = '';
        ldto.Website = '';
        ldto.Description = '';
        ldto.CommercialName = '';
        ldto.Logo = '';
        ldto.WhyJoinUs = '';
        ldto.ConvertedAccountId = '';
        ldto.NoLeads = 0.0;
        ldto.IsConverted =true;
        
        
        OCCMClasesV2.ResponseLead rl = new OCCMClasesV2.ResponseLead();
        rl.Message = '';
        rl.Lead = new OCCMClasesV2.LeadDto();
    }
    @isTest static void testAssignationWrapper() {
        List<OCCMClasesV2.AssignationWrapper> assList= new List<OCCMClasesV2.AssignationWrapper>();
        OCCMClasesV2.Assignation ass= new OCCMClasesV2.Assignation();
        ass.AssigmentName ='Ass1';
        ass.AssigmentId='id1';
		ass.UserId='id1';
		ass.UserName='Name1';
		ass.Percentage= 10.0;
		ass.HowMany=1;
        ass.TotalPercentage=10.0;
        assList.add( new OCCMClasesV2.AssignationWrapper(ass));
        
        ass= new OCCMClasesV2.Assignation();
        ass.AssigmentName ='Ass3';
        ass.AssigmentId='id3';
		ass.UserId='id3';
		ass.UserName='Name3';
		ass.Percentage= 60.0;
		ass.HowMany=4;
        ass.TotalPercentage=60.0;
        assList.add( new OCCMClasesV2.AssignationWrapper(ass));
        
        ass= new OCCMClasesV2.Assignation();
        ass.AssigmentName ='Ass2';
        ass.AssigmentId='id2';
		ass.UserId='id2';
		ass.UserName='Name2';
		ass.Percentage= 30.0;
		ass.HowMany=2;
        ass.TotalPercentage=30.0;
        assList.add( new OCCMClasesV2.AssignationWrapper(ass));
        
        // Sort the wrapper objects using the implementation of the
        // compareTo method.
        assList.sort();
        // Verify the sort order
        System.assertEquals('Name1', assList[0].assig.UserName);
        System.assertEquals(10.0, assList[0].assig.TotalPercentage);
        System.assertEquals('Name2', assList[1].assig.UserName);
        System.assertEquals(30.0, assList[1].assig.TotalPercentage);
        System.assertEquals('Name3', assList[2].assig.UserName);
        System.assertEquals(60.0, assList[2].assig.TotalPercentage);
        // Write the sorted list contents to the debug log.
        System.debug(assList);
    }
}