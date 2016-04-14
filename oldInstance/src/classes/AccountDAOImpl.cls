/**
 * DAO Class to query Account object. This uses LIMIT
 * and OFFSET to support paginatoin of upto 2000 records
 *  
 */
public with sharing class AccountDAOImpl implements AccountDAO {

	//Handle to the API request container object
	AccountAPIRequest request {get; set;}

	public AccountDAOImpl(AccountAPIRequest request){
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
			}else{
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
	 * Uses Limit and Offset to fetch page data.
	 * This has a limitation of 2000 records.
	 */
	public List<Account> getAccounts() {
		System.debug('Getting Accounts >> ');

		try{
			Integer startRecord = request.start;
			Integer batchSize = request.pageSize;
			Integer offset = startRecord - 1;

			System.debug(' Start Record: '+startRecord);
			System.debug(' Offset: '+offset);
			System.debug(' batchSize: '+batchSize);

			//Adding Checks using Limits class.
			//Limits class can be used to check if the total records requested (LIMIT) is more than the allowed limit

			if(batchSize + Limits.getQueryRows() > Limits.getLimitQueryRows()){
				System.debug('The sum of batch size: '+batchSize+' and total rows fetched so far: '+Limits.getQueryRows()+' is greater than Limits: '+Limits.getLimitQueryRows());
				throw new APIException('The request batch size is greater than allowed rows limit ');
			}

			if(AccountServiceHelper.API_TYPE_FETCH.equals(request.apiType)){
				return [select Id, Name, Phone from Account LIMIT :batchSize OFFSET :offset];
			}else {
				String queryName = '%' + request.name + '%';
				return [select Id, Name, Phone from Account where name like :queryName LIMIT :batchSize OFFSET :offset];
			}
		}catch(APIException e){
			System.debug('Error ocurred: '+e.getMessage());
			throw e; 
		}catch(Exception e){
			System.debug('Error ocurred: '+e.getMessage());
			throw new APIException('An Exception ocurred when trying to get the accounts. Please try again later.'); 
		}
	}
}