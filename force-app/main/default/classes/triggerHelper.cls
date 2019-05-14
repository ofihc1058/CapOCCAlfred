public with sharing class triggerHelper {
	public static boolean b=false;
	//A boolean that is set and then checked at the beginning of update triggers to be sure they only execute once
	public static  void  recursiveHelper (Boolean tempBool){
		b=tempBool;
	}
	//if(!triggerhelper.b){ triggerhelper.recursiveHelper(true);
	static testMethod void TestTriggerHelperClases() {
		triggerHelper helperTrigger= new triggerHelper();
		if(!triggerhelper.b){
			triggerhelper.recursiveHelper(true);
		}
	}
}