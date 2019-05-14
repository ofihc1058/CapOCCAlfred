@isTest
private class ContactTriggersTest {
    static testMethod void TestClassOK(){
    	Account account= new Account();
        account.Name = 'Nombre Apellido';
        account.phone='0000000000';
        account.Website='http://www.pruebas.com';  
        insert account;
        
        Contact cte= new Contact();
        cte.AccountId = account.Id;
        cte.FirstName='Juan';
        cte.LastName = 'Perez';
        cte.Email = 'test@test.com';
        insert cte;
    }
}