//
//  AlamofireDriver.swift
//  Ticker
//
//  Created by David Hansson on 26/02/2021.
//

import UIKit
import Alamofire

class AlamofireDriver: APIManagerProtocol {
    
    var isConnectedListener: ((Bool) -> Void)?
    
    fileprivate var baseURL: String = ""
    
    func setup(withBaseURL URL: String) {
        self.baseURL = URL
    }
    
    func callAPI<T>(of type: T.Type, withRequest request: APIRequest, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let parameters = request.parameters == nil ? nil : (request.parameters! as Parameters)
        
        let decoder = JSONDecoder()
        
        AF.request(baseURL + request.endpoint, method: HTTPMethod(rawValue: request.method.rawValue), parameters: parameters, encoding: JSONEncoding.default, headers: nil, interceptor: nil).validate().responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
    
    
}
