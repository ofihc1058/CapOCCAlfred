public with sharing class TestChangeOwnerCase {


    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
      Case caso = new Case();
        
        
        caso.OwnerId = [SELECT Id FROM User WHERE IsActive = true LIMIT 1].Id;
        caso.Status = 'Ingreso';
        caso.Origin = 'chat';
        
       insert caso;
       
       
       caso.Status = 'Escalado';
       caso.Origin = 'Teléfono';
       
       update caso; 
    }

}