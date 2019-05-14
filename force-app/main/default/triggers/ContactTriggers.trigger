trigger ContactTriggers on Contact (after insert) {
    if(trigger.isAfter)
    {
        if(trigger.isInsert)
        {
            for(Contact a : trigger.new)
            {
           		Account accAct = [select Id, Correo_Electronico_Prospecto__c from Account where Id=:a.AccountId];
                accAct.Correo_Electronico_Prospecto__c = a.Email;
                update accAct;
            }
        }
    }
}