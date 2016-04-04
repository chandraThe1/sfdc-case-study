/**
 * REST API Endpoint for Accounts
 */
public class AccountServiceHelper {
	public static final Integer BATCH_SIZE = 50;
	public static final String API_TYPE_FETCH = 'fetch';
	public static final String API_TYPE_QUERY = 'query';

	/**
	 * Gets the accounts in the database. Supports pagination and 
	 * returns only a subset of accounts at a time.
	 * Type: Fetch or Query
	 */
	public static AccountAPIResponse process(String type){
		System.debug('Inside process() ');

		AccountAPIResponse accountApiResponse = new AccountAPIResponse();

		try{
			//Parse the input and set values
			AccountAPIRequest request = validateInput(type);
			System.debug('Input validated ');

			/**
			 * ========================================= READ ME =======================================
			 * The default version of implementation to demonstrate this case study is AccountDAOImpl. It uses 
			 * LIMIT and OFFSET on SOQL to support pagination. Works only for 2000 records as SOQL cannot OFFSET 
			 * more than 2000 records.
			 * 
			 * A better version would be to use StandardSetController with a Query Locator to get the paginated Accounts
			 * This works for only 10,000 records as it the maximum that StandardSetController can hold
			 * 
			 * The best implementation (though not in this case) is for the client to directly invoke standard HTTP REST
			 * Query API E.g "/services/data/v28.0/query?q=SELECT Id, Name FROM Account" and control the batch size using 
			 * "Sforce-Query-Options: batchSize=200" HEADER parameter. This API returns "nextRecordsUrl" which will point
			 * to the URL to fetch the next set of options.
			 * 
			 */
			AccountDAO accountDAO = new AccountDAOImpl(request);

			//Get total count
			accountApiResponse.totalCount = accountDAO.getTotalCount();
			System.debug('Got total Count ');

			//Get the paginated accounts
			List<Account> accounts = accountDAO.getAccounts();
			System.debug('Got list of accounts '+accounts.size());

			//Update the accounts in response
			accountApiResponse.accounts = accounts;

			//Update other values in response
			accountApiResponse.start = request.start;
			accountApiResponse.actualPageSize = accounts == null? 0 : accounts.size();
			accountApiResponse.maxPageSize = request.pageSize;

			System.debug('Setting success ');
			//Set Status success
			accountApiResponse.success = true;
		}catch(Exception e){
			//Send error response
			System.debug('API Exception ocurred '+e.getMessage());

			accountApiResponse.success = false;
			accountApiResponse.errorMessage = e.getMessage();

			RestContext.response.statuscode=500;
		}

		return accountApiResponse;
	}

	/**
	 * Parses the input and validates if they are fine.
	 * If they are fine, it stores it in AccountAPIRequest
	 * and returns it
	 */
	private static AccountAPIRequest validateInput(String type){
		//Check if the inputs are fine and populate the request object.
		System.debug('Validating input for type: '+type);

		AccountAPIRequest request = new AccountAPIRequest();		
		request.apiType = type;

		RestRequest req = RestContext.request;

		//Check if name is being passed for query 
		if(API_TYPE_QUERY.equals(type)) {
			String nameParam = req.params.get('name');

			//Name is mandatory and cannot be missing.
			if(String.isEmpty(nameParam) || String.isEmpty(nameParam.trim())){
				throw new APIException(APIException.MISSING_INPUT);
			}

			System.debug('Name '+nameParam +' is valid');

			request.name = nameParam;
		}

		//Check if start is passed and has correct values
		try{
			String startParam = req.params.get('start');
			String pageSizeParam = req.params.get('pageSize');
			Integer startVal = startParam==null || startParam=='0'? 1 : Integer.valueOf(startParam);
			Integer pageSizeVal = pageSizeParam==null || pageSizeParam=='0'? BATCH_SIZE : Integer.valueOf(pageSizeParam);

			System.debug('Start Value '+startVal +' is valid');
			System.debug('pageSizeVal Value '+pageSizeVal +' is valid');
			//Set the start value in response.
			request.start = startVal;
			request.pageSize = pageSizeVal;
		} catch(Exception e){
			//Input was invalid
			throw new APIException(APIException.INVALID_INPUT);
		}

		return request;
	}
}