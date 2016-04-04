/**
 * Test class to mock outbound http callouts
 */
@isTest
global class MockGetHttpCallout implements HttpCalloutMock {

	String fakeResponse {get; set;}
	String fakeEndpoint {get; set;}
	String fakeMethod {get; set;}
	Integer fakeStatusCode {get; set;}

	public MockGetHttpCallout(String fakeResponse, String fakeEndpoint, String fakeMethod, Integer fakeStatusCode){
		this.fakeResponse = fakeResponse;
		this.fakeEndpoint = fakeEndpoint;
		this.fakeStatusCode = fakeStatusCode;
		this.fakeMethod = fakeMethod;
	}

	global HTTPResponse respond(HTTPRequest req) {
		System.debug('Inside the mock get http callout');

		System.assert(req.getEndpoint().contains(fakeEndpoint), 'Endpoints not the same');
		System.assertEquals(fakeMethod, req.getMethod(), 'Method not the same');

		// Create a fake response
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');
		res.setBody(fakeResponse);
		res.setStatusCode(fakeStatusCode);
		return res;
	}
}