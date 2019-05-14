@isTest
public with sharing class testTriggerCaseComment {


    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
      Case caso = new Case();
        caso.OwnerId = [SELECT Id FROM User WHERE IsActive = true LIMIT 1].Id;
        caso.Status = 'Ingreso';
        caso.Origin = 'chat';
		caso.Description = 'TestDescription';
		caso.Status = 'New';
		caso.Subject = 'TestSubject';        
       insert caso;
       
       
       CaseComment cc = new CaseComment(ParentId = caso.Id,CommentBody = 'test');
	   insert cc;
	   
	   delete cc;
 
    }
    
    

}