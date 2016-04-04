/**
 * Account DAO Imple which uses Std Set controller to return 
 * less than 10000 rows.
 */
public with sharing class StdSetAccDAOImpl implements AccountDAO {

	//Handle to the API request container object
	AccountAPIRequest request {get; set;}

	public StdSetAccDAOImpl(AccountAPIRequest request){
		this.request = request;
	}

	/**
	 * Get the count of all accounts.
	 */
	public Integer getTotalCount() {
		System.debug('Getting Total Count >> ');
		try{
			if(AccountServiceHelper.API_TYPE_FETCH.equals(request.apiType)){
				return [select count() from Account];
			}else {
				String queryName = '%' + request.name + '%';
				return [select count() from Account where name like :queryName];
			}
		}catch(Exception e){
			System.debug('Error ocurred: '+e.getMessage());
			throw new APIException('An Exception ocurred when trying to get the total count. Please try again later.'); 
		}
	}

	/**
	 * Get the accounts between the start and end records.
	 */
	public List<Account> getAccounts() {
		System.debug('Getting Accounts >> ');
		Integer startRecord = request.start;
		Integer batchSize = request.pageSize;

		try{
			if(AccountServiceHelper.API_TYPE_FETCH.equals(request.apiType)){
				ApexPages.StandardSetController controller = new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Name, Phone from Account limit 10000]));
				controller.setPageSize(AccountServiceHelper.BATCH_SIZE);
				controller.setPageNumber( (startRecord/AccountServiceHelper.BATCH_SIZE) + 1);

				System.debug('controller getPageSize() '+controller.getPageSize());
				System.debug('controller getPageNumber() '+controller.getPageNumber());
				System.debug('controller getResultSize() '+controller.getResultSize());
				System.debug('controller getCompleteResult() '+controller.getCompleteResult());

				return controller.getRecords();
			}else {
				String queryName = '%' + request.name + '%';
				return new ApexPages.StandardSetController(Database.getQueryLocator([select Id, Name, Phone from Account where name like :queryName limit 10000])).getRecords();
			}
		}catch(Exception e){
			System.debug('Error ocurred: '+e.getMessage());
			throw new APIException('An Exception ocurred when trying to get the accounts. Please try again later.'); 
		}
	}
}