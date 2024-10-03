//
//  HttpClientTest.swift
//  CatminatorTests
//
//  Created by Macky Ramirez on 10/3/24.
//
import XCTest
@testable import Catminator
final class HttpClientTest: XCTestCase {
    var httpClient: HttpClient!
    let session = MockURLSession()
    let mockUrl = "https://meowfacts.herokuapp.com/"
//    let mockUrl = ""
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    override func tearDown() {
        super.tearDown()
    }
    // MARK: test_get_request_with_URL
    // We test if the url exist or accidentally deleted is
    func test_get_request_with_URL() {
        guard let url = URL(string: mockUrl) else {
            fatalError("URL can't be empty")
        }
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        print(url)
        XCTAssert(session.lastURL == url)
    }
    // MARK:We want to know if the URLSessionDataTask.resume() is called.
    // If the resume() in the MockURLSessionDataTask gets called, the resumeWasCalled would become ‘true’!
    func test_get_resume_called() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: mockUrl) else {
            fatalError("URL can't be empty")
        }
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        XCTAssert(dataTask.resumeWasCalled)
    }
    // MARK:We want to know if the session should return data.
    // if data is not nil then it passed.
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        session.nextData = expectedData
        var actualData: Data?
        httpClient.get(url: URL(string: mockUrl)!) { (data, error) in
            actualData = data
            print(data!)
        }
        XCTAssertNotNil(actualData)
    }
}
