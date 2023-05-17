//
//  APIManager.swift
//  LoremPicsum
//
//  Created by Ravindran on 17/05/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class APIManager {
    static let shared: APIManager = APIManager()
    
    private var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    private func getRequest(serviceURL: String, httpMethod: HttpMethod = .get, tokenEnabled: Bool = true) -> URLRequest? {
        var requestURL: String = ""
        if !serviceURL.contains("http") {
            requestURL = getFullEndpointUrl(serviceUrl: serviceURL)
        } else {
            requestURL = serviceURL.urlEncoded ?? serviceURL
        }
        guard let url: URL = URL(string: "\(requestURL)") else {
            return nil
        }
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if tokenEnabled {
            request = setToken(request: request)
        } else {
            debugPrint("Token Disabled for this request!!!")
        }
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    func setToken(request: URLRequest) -> URLRequest {
        var request: URLRequest = request
        if let token: String = KeychainManager.shared.jwt, !token.isEmpty {
            debugPrint("Token Found!!!")
            debugPrint("\(token)")
            request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        } else {
            debugPrint("Token Missing!!!")
        }
        return request
    }
    
    func request(serviceURL: String, httpMethod: HttpMethod = .get, tokenEnabled: Bool = true) async throws -> (Data, URLResponse) {
        var request: URLRequest? = getRequest(serviceURL: serviceURL, httpMethod: httpMethod, tokenEnabled: tokenEnabled)
        return try await makeApiCall(request: request)
    }
    
    func request<T: Encodable>(serviceURL: String, httpMethod: HttpMethod = .get, parameters: T? = nil, tokenEnabled: Bool = true) async throws -> (Data, URLResponse) {
        var request: URLRequest? = getRequest(serviceURL: serviceURL, httpMethod: httpMethod, tokenEnabled: tokenEnabled)
        if parameters != nil {
            do {
                request?.httpBody = try JSONEncoder().encode(parameters)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        return try await makeApiCall(request: request)
    }
    
    private func makeApiCall(request: URLRequest?) async throws -> (Data, URLResponse) {
        guard let confirmedRequest = request else {
            throw APIError.runtimeError("Failed to create request")
        }
        return try await withCheckedThrowingContinuation { continuation in
            let sessionTask: URLSessionDataTask = self.session.dataTask(with: confirmedRequest) { (data, response, error) in
                DispatchQueue.main.async {
                    if let error: Error = error {
                        continuation.resume(throwing: error)
                    } else {
                        guard let confirmedData = data, let confirmedResponse = response else {
                            continuation.resume(throwing: APIError.runtimeError("Failed to receive API response"))
                            return
                        }
                        continuation.resume(returning: (confirmedData, confirmedResponse))
                    }
                }
            }
            sessionTask.resume()
        }
    }
    
    private func getFullEndpointUrl(serviceUrl: String) -> String {
        return (APIEndPoints.ApiBaseUrl + serviceUrl).urlEncoded ?? (APIEndPoints.ApiBaseUrl + serviceUrl)
    }
}
