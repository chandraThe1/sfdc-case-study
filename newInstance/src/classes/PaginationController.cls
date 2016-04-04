/**
 * Base Controller class which support pagination.
 * A boolean flag 'fetchData' will have to be set to true to 
 * re-render the page with the new values. This value will be reset to true
 * everytime there is a change in the pagination parameters
 */
public virtual class PaginationController {
	//Total number of accounts
	public Integer totalCount{get; set;}

	//Has Next results?
	public boolean hasNext {get; set;}

	//Has Previous results?
	public boolean hasPrevious {get; set;}

	//Current Page number
	public Integer pageNumber {get; set;}

	//Last Page number
	public Integer lastPageNumber {get; set;}

	//Current Page size
	public Integer size {get; set;}

	//Max page size
	public Integer maxPageSize {get; set;}

	//Start value to be sent to the API
	public Integer start {get; set;}

	//Start value of the last page to be sent to the API
	public Integer lastPageStart {get; set;}

	//Boolean whether the page needs to be refreshed or not
	public boolean fetchData {get; set;}

	//List of dropdown options for user to change
	public List<SelectOption> paginationSizeOptions{get;set;}

	//Constructor - set defaults
	public PaginationController(){
		pageNumber = 1;
		start = 1;
		size = 0;
		maxPageSize = 10;
		totalCount = 0;
		lastPageStart = 1;
		lastPageNumber = 1;
		hasNext = false;
		hasPrevious = false;
		fetchData = true;
		
		paginationSizeOptions = new List<SelectOption>();
        paginationSizeOptions.add(new SelectOption('10','10'));
        paginationSizeOptions.add(new SelectOption('50','50'));
        paginationSizeOptions.add(new SelectOption('100','100'));
        paginationSizeOptions.add(new SelectOption('200','200'));
	}


	/**
	 * Increment start by batch size 
	 */
	public void next(){
		start = start + maxPageSize;
		pageNumber++;
		fetchData = true;
	}

	/**
	 * Decrement start by batch size 
	 */
	public void previous(){
		start = start - maxPageSize; 
		pageNumber--;
		fetchData = true;
	}

	/**
	 * Start = 1 
	 */
	public void first(){
		start = 1;
		pageNumber = 1;
		fetchData = true;
	}

	/**
	 * Calculate and set start based on the totalCount
	 */
	public void last(){
		start = lastPageStart;
		pageNumber = lastPageNumber;
		fetchData = true;
	}
	
	/**
	 * 	Go back to the first set and refresh the page with
	 * 	new size values
	 */
	public void refreshPageSize() {
        first();
    }


	/**
	 * Calculates and sets hasNext, hasPrevious, lastPageNumber and lastPageStart
	 */
	public void updateValues(){
		System.debug('Updating values...');

		//Set lastPageStart and lastPageNumber
		if(totalCount > 0){
			if(Math.mod(totalCount, maxPageSize) == 0){
				lastPageNumber =  (totalCount/maxPageSize);
			}else{
				lastPageNumber =  (totalCount/maxPageSize) + 1 ;
			}

			lastPageStart = ((lastPageNumber-1) * maxPageSize) + 1;
		}else{
			lastPageStart = 1;
		}

		//Set hasNext and hasPrevious
		if(pageNumber > 1 && pageNumber < lastPageNumber) {
			hasNext = true;
			hasPrevious = true;
		} else {
			if(pageNumber == 1){
				hasPrevious = false;
			}else{
				hasPrevious = true;
			}

			if(pageNumber == lastPageNumber){
				hasNext = false;
			}else{
				hasNext = true;
			}
		}


		System.debug(' start: '+start);
		System.debug(' totalCount: '+totalCount);
		System.debug(' lastPageStart: '+lastPageStart);
		System.debug(' size: '+size);
		System.debug(' maxPageSize: '+maxPageSize);
		System.debug(' pageNumber: '+pageNumber);
		System.debug(' lastPageNumber: '+lastPageNumber);
		System.debug(' hasNext: '+hasNext);
		System.debug(' hasPrevious: '+hasPrevious);
		System.debug(' fetchData: '+fetchData);
	}
}