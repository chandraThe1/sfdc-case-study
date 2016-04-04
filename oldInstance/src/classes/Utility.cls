/**
 * 
 */
@RestResource(urlMapping='/util/*')
global with sharing class Utility {
	@HttpPost
	global static String addRecs(){
		List<Account> accs = new List<Account>();

		for(Integer i=0; i< 1800; i++){
			accs.add(new Account(Name='Q:'+i));
		}

		insert accs;

		return 'Ok';
	}

	@HttpDelete
	global static String deleteRecs(){
		List<Account> accs = [select Id from Account where Name like 'Q:%'];

		delete accs;

		return 'Ok';
	}

}