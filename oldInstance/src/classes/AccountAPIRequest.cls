/**
 * Place holder that contains the request params for API
 */
public with sharing class AccountAPIRequest {

	//Start record number for pagination
	public Integer start {get; set;}

	//Start pageSize for pagination
	public Integer pageSize {get; set;}

	//Account Name to match
	public String name {get; set;}

	//Fetch or Query
	public String apiType {get; set;}
}