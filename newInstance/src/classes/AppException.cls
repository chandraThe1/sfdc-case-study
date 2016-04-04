public with sharing class AppException extends Exception {

	//Severity constants
	public static String SEVERITY_HIGH = 'HIGH';
	public static String SEVERITY_MEDUIM = 'MEDUIM';
	public static String SEVERITY_LOW = 'LOW';

	/**
	 * Creates a record in the custom error log which will use workflow to send emails.
	 */
	public static void insertError(String message, String severity){
		//Insert into custom error table and use workflow to send email
		CustomError__c customError = new CustomError__c();
		customError.Message__c = message;
		customError.Severity__c = severity;

		Database.insert(customError, false);
	}

}