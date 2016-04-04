/**
 * REST API endpoint to query accounts by Name in a paginated set
 */
@RestResource(urlMapping='/Accounts/query')
global class QueryAccountsService {

	/**
	 * Handles the get request
	 */
	@HttpGet
	global static AccountAPIResponse query(){
		return AccountServiceHelper.process(AccountServiceHelper.API_TYPE_QUERY);
	}

}