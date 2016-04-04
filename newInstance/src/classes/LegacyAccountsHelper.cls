/**
 * Helper class to make REST API call
 * to the older instance to fetch and query accounts.
 */
public with sharing class LegacyAccountsHelper {

	/**
	 * Invokes REST API on old instance to fetch paginated account list
	 */
	public static AccountAPIResponse fetchAccounts(Integer start, Integer maxPageSize) {

		//Invoke REST endpoint and return response
		return invokeApi('/services/apexrest/Accounts/fetchAll?start='+start+'&pageSize='+maxPageSize, 'GET');
	}

	/**
	 * Invokes REST API on old instance to query accounts by name
	 * This implementation returns the first
	 */
	public static Account getMatchingLegacyAccount(String name) {
		//Invoke REST endpoint and return first account.
		AccountAPIResponse apiResponse = invokeApi('/services/apexrest/Accounts/query?name='+EncodingUtil.urlEncode(name, 'UTF-8')+'&pageSize='+1, 'GET');

		List<Account> accounts = apiResponse.accounts;

		//Return first account
		if(accounts != null && accounts.size() > 0){
			return accounts.get(0);
		}

		return null;
	}

	/**
	 * Invokes the HTTP REST API and returns the response object.
	 * Note that this method uses NamedCredential to call the API in order
	 * to not store the username/password
	 */
	private static AccountAPIResponse invokeApi(String requestUri, String method){
		Http http = new Http();
		HttpRequest req = new HttpRequest();


		/**
		 * Using NamedCredential, we can avoid storing username, password, consumer key and secret in our instance.
		 * We can also skip authentication, because we don't need the token anymore.
		 * If we want to do it that way, we can create a "protected" CustomSettings with the following keys:
		 * URL=Endpoint URL of the Legacy SFDC instance
		 * Username
		 * Password
		 * Consumer Key
		 * Consumer Secret
		 * 
		 * We also have to invoke the authentication API to get the auth token and pass that in header
		 * for every REST API call.
		 * 
		 * NamedCredential allows you to confifure the App to App integration at the config level (one time)
		 * and lets you use it as "callout:<NamedCredentialName>/<URI>" in the apex code
		 *  
		 */
		String url = 'callout:LegacyInstance' + requestUri;

		req.setMethod(method);
		System.debug('Request URL: '+url);
		req.setEndpoint(url);
		HttpResponse res = http.send(req);
		System.debug('Response Body: '+res.getBody());

		AccountAPIResponse apiResponse = (AccountAPIResponse) JSON.deserialize(res.getbody(), AccountAPIResponse.class);

		return apiResponse;
	}

	/**
	 * Returns the legacy instance url from custom settings
	 */
	public static String getLegacyInstanceUrl(){
		LegacyInstanceSettings__c settings = LegacyInstanceSettings__c.getValues('Default');

		System.debug('getLegacyInstanceUrl '+settings.InstanceURL__c);

		return settings.InstanceURL__c;
	}
}