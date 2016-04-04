/**
 * REST API endpoint to get all accounts in a paginated set
 */
@RestResource(urlMapping='/Accounts/fetchAll')
global class GetAccountsService {

	/**
	 * Handles the get request
	 */
	@HttpGet
	global static AccountAPIResponse get(){
		return AccountServiceHelper.process(AccountServiceHelper.API_TYPE_FETCH);
	}

}