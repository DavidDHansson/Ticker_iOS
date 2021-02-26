//
//  APIManager.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit

class APIManager: APIManagerProtocol {
    
    public static let shared = APIManager()
    
    public var driver: APIManagerProtocol
    
    init() {
        driver = AlamofireDriver()
    }
    
    var isConnectedListener: ((Bool) -> Void)? {
        get {
            return driver.isConnectedListener
        }
        set {
            driver.isConnectedListener = newValue
        }
    }
    
    func setup(withBaseURL URL: String) {
        driver.setup(withBaseURL: URL)
    }
    
    func callAPI<T>(of type: T.Type, withRequest request: APIRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        driver.callAPI(of: type, withRequest: request, completion: completion)
    }
    
}
