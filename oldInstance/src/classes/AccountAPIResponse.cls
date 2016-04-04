/**
 * Class which holds the response for Account API
 */
global class AccountAPIResponse extends APIResponse {

	// List of account objects in this batch
	public List<Account> accounts {get; set;}

	// Total number of account objects returned for this query
	public Integer totalCount {get; set;}

	// Pagination start count for this batch
	public Integer start {get; set;}

	// Number of results returned in this batch
	public Integer actualPageSize {get; set;}
	
	//Max records that can be returned in a page
	public Integer maxPageSize {get; set;}
}