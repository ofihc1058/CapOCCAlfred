trigger ChangeOwnerCase on Case (before update) {
	
	  
Case[] caso = Trigger.new;

	for(Case c:caso){
		
		if(c.Status =='Escalado' & c.Area_responsable__c == 'Ventas'){
			
			List <Account> listAcc = [select OwnerId from Account where Id =: c.AccountId];
			
				for(Account a:listAcc){
					
					c.OwnerId = a.OwnerId;
					
				}//for
			
		}
		
		
	}//fin de for 

}//fin de trigger