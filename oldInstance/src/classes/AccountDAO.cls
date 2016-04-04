/**
 * Interface for Account DAO. The implementation can be switched in the factory
 * to use SOQL LIMIT/OFFSET or to use REST API with nextPageURL
 */
public interface AccountDAO {
	// Returns the total number of records for the query
	Integer getTotalCount();

	// Returns the list of accounts for the query + pagination size.
	List<Account> getAccounts();
}