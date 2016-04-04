/**
 * This class contains unit tests for API Service classes
 */
@isTest
private class APITest {

	/**
	 * Tests the successful fetch of accounts
	 */
	static testMethod void testFetchAccountsSuccess() {

		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse();
		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = GetAccountsService.get();

		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, true);
		System.assertEquals(apiResponse.errorMessage, null);
		System.assertEquals(apiResponse.start, 1);
	}

	/**
	 * Tests the successful query of accounts
	 */
	static testMethod void testQueryAccountsSuccess() {
		RestRequest req = new RestRequest(); 
		req.addParameter('name', 'Edge');
		RestResponse res = new RestResponse();
		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = QueryAccountsService.query();
		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, true);
		System.assertEquals(apiResponse.errorMessage, null);
		System.assertEquals(apiResponse.start, 1);
	}


	/**
	 * testFetchAccountsInvalidInput
	 */
	static testMethod void testFetchAccountsInvalidInput() {

		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse();
		req.addParameter('start', 'ABCD'); //invalid input

		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = GetAccountsService.get();

		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, false);
		System.assertNotEquals(apiResponse.errorMessage, null);
	}


	/**
	 * testFetchAccountsInvalidOffset
	 */
	static testMethod void testFetchAccountsInvalidOffset() {

		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse();
		req.addParameter('pageSize', 'ABCD'); //invalid input

		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = GetAccountsService.get();

		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, false);
		System.assertNotEquals(apiResponse.errorMessage, null);
	}

	/**
	 * testFetchAccountsInvalidOffset
	 */
	static testMethod void testFetchAccountsInvalidStart() {

		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse();
		req.addParameter('start', '-5'); //invalid input

		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = GetAccountsService.get();

		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, false);
		System.assertNotEquals(apiResponse.errorMessage, null);
	}

	/**
	 * Tests failure to query of accounts
	 */
	static testMethod void testQueryAccountsFailure() {
		RestRequest req = new RestRequest(); 
		RestResponse res = new RestResponse();
		RestContext.request = req;
		RestContext.response = res;

		AccountAPIResponse apiResponse = QueryAccountsService.query();
		System.assertNotEquals(apiResponse, null);
		System.assertEquals(apiResponse.success, false);
		System.assertNotEquals(apiResponse.errorMessage, null);

	}

	/**
	 * Tests failure to query of accounts
	 */
	static testMethod void testStdSetDAO() {
		AccountAPIRequest request = new AccountAPIRequest();
		request.apiType=AccountServiceHelper.API_TYPE_FETCH;
		request.start = 1;
		request.pageSize=1;

		StdSetAccDAOImpl dao = new StdSetAccDAOImpl(request);

		Integer tc = dao.getTotalCount();
		List<Account> accounts = dao.getAccounts();

		request.apiType=AccountServiceHelper.API_TYPE_QUERY;
		dao = new StdSetAccDAOImpl(request);

		tc = dao.getTotalCount();
		accounts = dao.getAccounts();		

		System.assert(tc == 0);

	}
}