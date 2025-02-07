//
//  CoreBrillSDK.swift
//
//  Created by iMac on 07/02/2025.
//

import Alamofire
import Foundation

extension CoreBrillSDK {
    
    public func checkDataWith(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters = [paramName: code]
        session.request(lock, method: .get, parameters: parameters)
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let base64String):
                    
                    guard let jsonData = Data(base64Encoded: base64String) else {
                        let error = NSError(domain: "SkylineSDK", code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Invalid base64 data"])
                        completion(.failure(error))
                        return
                    }
                    
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseData.self, from: jsonData)
                        
                        self.statusFlag = decodedData.first_link
                        
                        if self.initialStart == nil {
                            self.initialStart = decodedData.link
                            completion(.success(decodedData.link))
                        } else if decodedData.link == self.initialStart {
                            if self.finalData != nil {
                                completion(.success(self.finalData!))
                            } else {
                                completion(.success(decodedData.link))
                            }
                        } else if self.statusFlag {
                            self.finalData = nil
                            self.initialStart = decodedData.link
                            completion(.success(decodedData.link))
                        } else {
                            self.initialStart = decodedData.link
                            if self.finalData != nil {
                                completion(.success(self.finalData!))
                            } else {
                                completion(.success(decodedData.link))
                            }
                        }
                        
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure:
                    completion(.failure(NSError(domain: "SkylineSDK", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error occurred"])))
                }
            }
    }
    
    struct ResponseData: Codable {
        var link: String
        var naming: String
        var first_link: Bool
    }
}
