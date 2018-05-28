//
//  ApiClient.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 27/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Alamofire


class ApiClient {
    
    static let sharedInstance = ApiClient()
    
    private let hostiOSAssignmentURL = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment"
    
    private init() {}
    
    func fetch(endpoint: String, completion: @escaping ([String: Any]?) -> ()) {
        let requestURL = hostiOSAssignmentURL + endpoint
        Alamofire.request(requestURL).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("Error while fetching in \(requestURL). Error Message: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                completion(nil)
                return
            }
            completion(value)
        }
    }
}
