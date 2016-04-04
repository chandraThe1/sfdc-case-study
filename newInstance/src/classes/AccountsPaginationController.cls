/**
 * pagination controller for accounts
 */
public class AccountsPaginationController extends PaginationController {
	
	public static String legacyInstanceBaseUrl {get; set;}

	/**
	 * List of accounts
	 */
	public List<Account> accounts {
		get {
			if(fetchData){
				accounts = fetchAccounts();
				fetchData = false;
			}
			return accounts;
		}	
		set;
	}
	
	/**
	 * Constructor. Setting defaults
	 */
	public AccountsPaginationController(){
		super();
		legacyInstanceBaseUrl = LegacyAccountsHelper.getLegacyInstanceUrl();
	}

	/**
	 * Returns the accounts returned by the REST API (paginated) 
	 */
	public List<Account> fetchAccounts(){

		//Invoke API
		AccountAPIResponse response = LegacyAccountsHelper.fetchAccounts(start, maxPageSize);

		//If it was not a success, throw an error.
		if(!response.success || response.errorMessage!=null){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An Error occured while invoking REST API on Legacy Instance. Please contact your administrator'));
			return null;
		}

		//Set total count, size, pageNumber and lastStart
		totalCount = response.totalCount;
		size = response.actualPageSize;
		maxPageSize = response.maxPageSize;
		start = response.start;

		//update values based on totalCount and page numbers
		updateValues();

		//Return the list of accounts with a similar name.
		return response.accounts;
	}
}