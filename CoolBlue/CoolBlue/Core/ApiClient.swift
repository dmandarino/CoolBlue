//
//  ApiClient.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 27/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Alamofire

protocol ApiClientProtocol {
    func fetch(endpoint: String, completion: @escaping ([String: Any]?) -> ())
}

class ApiClient: ApiClientProtocol {
    
    static let sharedInstance = ApiClient()
    
    private var requestURL: String = ""
    private let hostiOSAssignmentURL = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment"
    
    private init() {}
    
    func fetch(endpoint: String, completion: @escaping ([String: Any]?) -> ()) {
        setRequestURL(forEndpoint: endpoint)
        Alamofire.request(requestURL).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching in \(self.requestURL). Error Message: \(String(describing: response.result.error))")
                return
            }            
            guard let value = response.result.value as? [String: Any] else {
                return
            }
            completion(value)
        }
    }
    
    private func setRequestURL(forEndpoint endpoint: String) {
        requestURL = hostiOSAssignmentURL + endpoint
    }
}
