/**
 * Controller to render legacy accounts on the screen
 */
public with sharing class LegacyAccountsController {
	//New Account Info
	public Account newAccount { get; set; }

	//Constructor
	public LegacyAccountsController(){
		newAccount = new Account();
		newAccountId = null;
	}

	//newly created account id
	public String newAccountId {get; set;}

	/**
	 * Create New Account
	 */
	public void createNewAccount() {
		try{
			System.debug('Inserting New Account');
			Database.insert(newAccount);
			System.debug('NewAccount inserted: '+ newAccount);

			//String to show the link
			newAccountId = newAccount.Id;

			//Associate legacy account id
			/**
			 * ========================================= READ ME =======================================
			 * Association of Legacy Account is being done in the create account flow. The other alternative
			 * considered was to do this in an "after insert trigger" on Account. But it would mean that 
			 * any account created from anywhere will result in this "matching", which might not be desired.
			 * The assumption is that we only want to match legacy accounts in this use case.
			 * 
			 */
			associateLegacyAccount(newAccountId, newAccount.name);

			//Reset to create a new account
			newAccount = new Account();
		} catch(DmlException ex){
			System.debug('Error while inserting account: '+ex.getMessage());
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: '+ex.getMessage()));
		}
	}


	/**
	 * Sets the legacy account id in new account
	 */
	@future(callout = true)
	public static void associateLegacyAccount(String accountId, String accountName) {
		System.debug('Current Account Id '+accountId);
		System.debug('Finding matching legacy Accounts with name like '+accountName);

		try{

			//Get matching legacy account from old instance via REST API
			Account legacyAccount = LegacyAccountsHelper.getMatchingLegacyAccount(accountName);

			System.debug('Legacy Account '+legacyAccount);

			if(legacyAccount!=null) {
				//Query current Account object by id
				Account currentAccount = [select Id from Account where Id = :accountId];
				System.debug('Current Account '+currentAccount);

				//Set Legacy account id
				currentAccount.LegacyAccountId__c = legacyAccount.Id;

				//Update current account.
				update currentAccount;
			}
		}catch(Exception e){
			//Catch exception and log it in the DB
			System.debug('Error occured while trying to update account '+ e);
			AppException.insertError('Update account '+accountId+' failed. Error: '+ e, AppException.SEVERITY_HIGH);
		}
	}
}