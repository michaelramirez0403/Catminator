//
//  HttpClient.swift
//  Catminator
//
//  Created by Macky Ramirez on 10/2/24.
//
import Foundation
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
protocol URLSessionDataTaskProtocol {
    func resume()
}
class HttpClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }
    func get( url: URL,
              callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}
//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request,
                        completionHandler: completionHandler) as URLSessionDataTask
    }
}
extension URLSessionDataTask: URLSessionDataTaskProtocol { }
//
// MARK: - MOCK URL SESSION FOR TESTING
class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    private(set) var lastURL: URL?
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!,
                               statusCode: 200,
                               httpVersion: "HTTP/1.1",
                               headerFields: nil)!
    }
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        completionHandler(nextData,
                          successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
}
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private(set) var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
}
