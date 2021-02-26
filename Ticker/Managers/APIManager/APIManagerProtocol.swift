//
//  APIManagerProtocol.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit

struct APIRequest {
    let endpoint: String
    let method: APIMethod
    let parameters: [String: Any]?
}

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIEndPoint: String {
    case home = "home"
}

struct APIResponse {
    let error: Error?
    let data: Data?
}

protocol APIManagerProtocol {
    
    func setup(withBaseURL URL: String)
    
    var isConnectedListener: ((_ isConnected: Bool) -> Void)? { get set}
    
    func callAPI<T: Decodable>(of type: T.Type, withRequest request: APIRequest, completion: @escaping (Result<T, Error>) -> Void)
    
}
