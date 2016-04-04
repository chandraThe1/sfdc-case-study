
/**
 * Test class for AccountsTest
 */
@isTest(SeeAllData=true)
private class AccountsTest {

	/**
	 * Method that tests the successful account creation and updation with matching legacy
	 */
	static testMethod void fetchAccountsSuccess() {
		AccountsPaginationController controller = new AccountsPaginationController();

		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":1,"start":1,"maxPageSize":1,"actualPageSize":1,"accounts":[{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjjAAH"},"Id":"0013600000EGGjjAAH","Name":"Edge Communications","Phone":"(512) 757-6000"}]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		//Call Controller 
		controller.fetchAccounts();

		//Check if accounts was fetched
		System.assertEquals(controller.accounts.size(), 1, 'Should have at least one account');
	}

	/**
	 * Method that tests the failure of account 
	 */
	static testMethod void fetchAccountsAPIFailure() {
		AccountsPaginationController controller = new AccountsPaginationController();

		String expectedResponseBody = '{"success":false,"errorMessage":"Some Error","totalCount":0,"start":0,"maxPageSize":1,"actualPageSize":1,"accounts":[]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		//Call Controller 
		controller.fetchAccounts();

		//Check if accounts was fetched
		System.assertEquals(controller.accounts, null, 'Should have no accounts');
	}

	/**
	 * Method that tests the failure of account 
	 */
	static testMethod void fetchAccountsNavigation() {
		AccountsPaginationController controller = new AccountsPaginationController();

		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":1819,"start":1,"maxPageSize":20,"actualPageSize":20,"accounts":[{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjjAAH"},"Id":"0013600000EGGjjAAH","Name":"Edge Communications","Phone":"(512) 757-6000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjkAAH"},"Id":"0013600000EGGjkAAH","Name":"Burlington Textiles Corp of America","Phone":"(336) 222-7000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjlAAH"},"Id":"0013600000EGGjlAAH","Name":"Pyramid Construction Inc.","Phone":"(014) 427-4427"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjmAAH"},"Id":"0013600000EGGjmAAH","Name":"Dickenson plc","Phone":"(785) 241-6200"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjnAAH"},"Id":"0013600000EGGjnAAH","Name":"Grand Hotels & Resorts Ltd","Phone":"(312) 596-1000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjoAAH"},"Id":"0013600000EGGjoAAH","Name":"United Oil & Gas Corp.","Phone":"(212) 842-5500"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjpAAH"},"Id":"0013600000EGGjpAAH","Name":"Express Logistics and Transport","Phone":"(503) 421-7800"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjqAAH"},"Id":"0013600000EGGjqAAH","Name":"University of Arizona","Phone":"(520) 773-9050"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjrAAH"},"Id":"0013600000EGGjrAAH","Name":"United Oil & Gas, UK","Phone":"+44 191 4956203"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjsAAH"},"Id":"0013600000EGGjsAAH","Name":"United Oil & Gas, Singapore","Phone":"(650) 450-8810"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjtAAH"},"Id":"0013600000EGGjtAAH","Name":"GenePoint","Phone":"(650) 867-3450"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjuAAH"},"Id":"0013600000EGGjuAAH","Name":"sForce","Phone":"(415) 901-7000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNZAA5"},"Id":"0013600000ENDNZAA5","Name":"New Instance"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNjAAP"},"Id":"0013600000ENDNjAAP","Name":"Dickenson plc"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNkAAP"},"Id":"0013600000ENDNkAAP","Name":"Edge Communications"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNoAAP"},"Id":"0013600000ENDNoAAP","Name":"Express Logistics and Transport"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNpAAP"},"Id":"0013600000ENDNpAAP","Name":"Burlington Textiles Corp of America"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENMtDAAX"},"Id":"0013600000ENMtDAAX","Name":"Orielly"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENMtIAAX"},"Id":"0013600000ENMtIAAX","Name":"V%ENKY"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENP1zAAH"},"Id":"0013600000ENP1zAAH","Name":"Q:0"}]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		Integer currentStart = controller.start;
		controller.fetchAccounts();

		controller.next();
		System.assertEquals(controller.start, currentStart + controller.maxPageSize);

		controller.previous();
		System.assertEquals(controller.start, 1);

		controller.last();
		System.assert(controller.start > 0);

		controller.first();
		System.assertEquals(controller.start, 1);

		controller.refreshPageSize();
		System.assertEquals(controller.start, 1);

		//Check if accounts was fetched
		System.assertEquals(controller.accounts.size(), 20, 'Should have 20 accounts');

	}

	/**
	 * Method that tests the failure of account 
	 */
	static testMethod void fetchAccountsNavigationNextPage() {
		AccountsPaginationController controller = new AccountsPaginationController();

		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":1819,"start":21,"maxPageSize":20,"actualPageSize":20,"accounts":[{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjjAAH"},"Id":"0013600000EGGjjAAH","Name":"Edge Communications","Phone":"(512) 757-6000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjkAAH"},"Id":"0013600000EGGjkAAH","Name":"Burlington Textiles Corp of America","Phone":"(336) 222-7000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjlAAH"},"Id":"0013600000EGGjlAAH","Name":"Pyramid Construction Inc.","Phone":"(014) 427-4427"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjmAAH"},"Id":"0013600000EGGjmAAH","Name":"Dickenson plc","Phone":"(785) 241-6200"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjnAAH"},"Id":"0013600000EGGjnAAH","Name":"Grand Hotels & Resorts Ltd","Phone":"(312) 596-1000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjoAAH"},"Id":"0013600000EGGjoAAH","Name":"United Oil & Gas Corp.","Phone":"(212) 842-5500"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjpAAH"},"Id":"0013600000EGGjpAAH","Name":"Express Logistics and Transport","Phone":"(503) 421-7800"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjqAAH"},"Id":"0013600000EGGjqAAH","Name":"University of Arizona","Phone":"(520) 773-9050"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjrAAH"},"Id":"0013600000EGGjrAAH","Name":"United Oil & Gas, UK","Phone":"+44 191 4956203"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjsAAH"},"Id":"0013600000EGGjsAAH","Name":"United Oil & Gas, Singapore","Phone":"(650) 450-8810"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjtAAH"},"Id":"0013600000EGGjtAAH","Name":"GenePoint","Phone":"(650) 867-3450"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjuAAH"},"Id":"0013600000EGGjuAAH","Name":"sForce","Phone":"(415) 901-7000"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNZAA5"},"Id":"0013600000ENDNZAA5","Name":"New Instance"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNjAAP"},"Id":"0013600000ENDNjAAP","Name":"Dickenson plc"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNkAAP"},"Id":"0013600000ENDNkAAP","Name":"Edge Communications"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNoAAP"},"Id":"0013600000ENDNoAAP","Name":"Express Logistics and Transport"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENDNpAAP"},"Id":"0013600000ENDNpAAP","Name":"Burlington Textiles Corp of America"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENMtDAAX"},"Id":"0013600000ENMtDAAX","Name":"Orielly"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENMtIAAX"},"Id":"0013600000ENMtIAAX","Name":"V%ENKY"},{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000ENP1zAAH"},"Id":"0013600000ENP1zAAH","Name":"Q:0"}]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		Integer currentStart = controller.start;
		controller.fetchAccounts();

		controller.next();
		System.assertEquals(controller.start, 41);

		controller.fetchAccounts();

		controller.previous();
		System.assertEquals(controller.start, 1);

		controller.last();
		System.assert(controller.start > 1 && controller.pageNumber > 1);
		controller.fetchAccounts();

		controller.first();
		System.assertEquals(controller.start, 1);

		controller.refreshPageSize();
		System.assertEquals(controller.start, 1);

		//Check if accounts was fetched
		System.assertEquals(controller.accounts.size(), 20, 'Should have 20 accounts');

	}


	/**
	 * Method that tests the failure of account 
	 */
	static testMethod void fetchAccountsNoResults() {
		AccountsPaginationController controller = new AccountsPaginationController();

		//No results
		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":0,"start":1,"maxPageSize":20,"actualPageSize":0,"accounts":[]}';

		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		Integer currentStart = controller.start;
		controller.fetchAccounts();

		controller.next();
		System.assertEquals(controller.start, currentStart + controller.maxPageSize);

		controller.previous();
		System.assertEquals(controller.start, 1);

		controller.last();
		System.assert(controller.start > 0);

		controller.first();
		System.assertEquals(controller.start, 1);

		controller.refreshPageSize();
		System.assertEquals(controller.start, 1);

		//Check if accounts was fetched
		System.assertEquals(controller.accounts.size(), 0, 'Should have 0 accounts');

	}

	/**
	 * Method that tests the successful account creation and updation with matching legacy
	 */
	static testMethod void createAccountMatchingLegacy() {
		LegacyAccountsController controller = new LegacyAccountsController();
		controller.newAccount = new Account(Name='TestName');

		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":1,"start":1,"maxPageSize":1,"actualPageSize":1,"accounts":[{"attributes":{"type":"Account","url":"/services/data/v31.0/sobjects/Account/0013600000EGGjjAAH"},"Id":"0013600000EGGjjAAH","Name":"Edge Communications","Phone":"(512) 757-6000"}]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		Test.startTest();

		//Call Controller 
		controller.createNewAccount();

		Test.stopTest();

		//Check if new account was created
		System.assertNotEquals(controller.newAccountId, null, 'New account id should not be null'); // Always not null.

		//Check if the controller eventually set the newaccount variable to null
		System.assertEquals(controller.newAccount.name, null, 'Controller did not set the newAccount to null in the end'); //Controller always sets it to null in the end.

		//Check to see account was updated with a matching legacy acc id
		Account account = [select Id, LegacyAccountId__c from Account where Id = :controller.newAccountId ];
		System.assertEquals(account.LegacyAccountId__c, '0013600000EGGjjAAH', 'Controller did not set the correct Legacy Account Id');
	}

	/**
	 * No matching legacy account
	 */
	static testMethod void createAccountNoMatchingLegacy() {
		LegacyAccountsController controller = new LegacyAccountsController();
		controller.newAccount = new Account(Name='AnotherTestName');

		String expectedResponseBody = '{"success":true,"errorMessage":null,"totalCount":0,"start":3,"maxPageSize":1,"actualPageSize":0,"accounts":[]}';
		// Set mock callout class 
		Test.setMock(HttpCalloutMock.class, new MockGetHttpCallout(expectedResponseBody, 'callout:LegacyInstance', 'GET', 200));

		Test.startTest();

		//Call Controller 
		controller.createNewAccount();

		Test.stopTest();

		//Check if new account was created
		System.assertNotEquals(controller.newAccountId, null, 'New account id should not be null'); // Always not null.

		//Check if the controller eventually set the newaccount variable to null
		System.assertEquals(controller.newAccount.name, null, 'Controller did not set the newAccount to null in the end'); //Controller always sets it to null in the end.

		//Check to see account was updated with a matching legacy acc id
		Account account = [select Id, LegacyAccountId__c from Account where Id = :controller.newAccountId ];
		System.assertEquals(account.LegacyAccountId__c, null, 'Controller should not have any Legacy Account Id');
	}

	/**
	 * Account creation failed
	 */
	static testMethod void createAccountFailed() {
		LegacyAccountsController controller = new LegacyAccountsController();
		controller.newAccount = new Account(Name=null);

		//Call Controller 
		controller.createNewAccount();

		//Check if new account was created
		System.assertEquals(controller.newAccountId, null, 'New account id should be null');

		//Check if the controller eventually set the newaccount variable to null
		System.assertEquals(controller.newAccount.name, null, 'Controller did not set the newAccount to null in the end'); //Controller always sets it to null in the end.
	}

	/**
	 * Account creation failed
	 */
	static testMethod void appException() {
		String message = 'Error Ocurred';
		AppException.insertError(message, AppException.SEVERITY_HIGH);

		List<CustomError__c> errors = [select Id from CustomError__c where Message__c = :message];

		//Check if new account was created
		System.assert(errors.size() > 0, 'New account id should be null');
	}

}