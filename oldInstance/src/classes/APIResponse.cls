/**
 * Base class for returning API response.
 * Contains common properties
 */
public virtual class APIResponse {

	//Status = success or not
	public Boolean success {get; set;}

	//Error message if any
	public String errorMessage {get; set;}
}