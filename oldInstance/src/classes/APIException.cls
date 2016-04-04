public with sharing class APIException extends Exception{

	public static String INVALID_INPUT = 'One or more of the inputs was not valid. Please check and try again later.';
	public static String MISSING_INPUT = 'One or more of the input parameter was missing. Please check and try again later.';
	public static String QUERY_EXCEPTION = 'There was an error fetching records from the database. Please try again later.';
	public static String GENERAL_EXCEPTION = 'An error occured while processing the request. Please try again later.';
}