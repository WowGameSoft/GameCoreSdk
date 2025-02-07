//
//  CoreBrillSDK.swift
//
//  Created by iMac on 07/02/2025.
//

import Alamofire
import Foundation

extension CoreBrillSDK {
    
    func delayExecution(seconds: Double, completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            print("Delayed execution by \(seconds) seconds")
            completion()
        }
    }
    
    public func checkDataWith(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let parameters = [paramName: code]
        
        print("erthetr")

        session.request(loock, method: .get, parameters: parameters)
            .validate()
            .responseString { respponse in
                switch respponse.result {
                    case .success(let base64Sstring):
                        
                        guard let jsonnnData = Data(base64Encoded: base64Sstring) else {
                            let errror = NSError(domain: "SkylineSDK", code: -1,
                                                userInfo: [NSLocalizedDescriptionKey: "Invalid base64 data"])
                            completion(.failure(errror))
                            return
                        }
                        
                        do {
                            let decodeddData = try JSONDecoder().decode(ResponseData.self, from: jsonnnData)
                            
                            self.statusFlag = decodeddData.first_link
                            print("sfthdf")

                            if self.initialStart == nil {
                                self.initialStart = decodeddData.link
                                print("fgyjy")

                                completion(.success(decodeddData.link))
                            } else if decodeddData.link == self.initialStart {
                                if self.finalData != nil {
                                    print("drfhdt")

                                    completion(.success(self.finalData!))
                                } else {
                                    print("sthd")

                                    completion(.success(decodeddData.link))
                                }
                            } else if self.statusFlag {
                                self.finalData = nil
                                self.initialStart = decodeddData.link
                                print("sdfbds")

                                completion(.success(decodeddData.link))
                            } else {
                                self.initialStart = decodeddData.link
                                if self.finalData != nil {
                                    print("yukili")

                                    completion(.success(self.finalData!))
                                } else {
                                    print(".hiol")

                                    completion(.success(decodeddData.link))
                                }
                            }
                            print("dnddh")

                        } catch {
                            completion(.failure(error))
                        }
                        
                    case .failure:
                        completion(.failure(NSError(domain: "SkylineSDK", code: -1, userInfo: [NSLocalizedDescriptionKey: "Error occurred"])))
                }
            }
        
        func countOccurrences(of character: Character, in string: String) -> Int {
            let count = string.filter { $0 == character }.count
            print("Character '\(character)' appears \(count) times")
            return count
        }
    }
    
    struct ResponseData: Codable {
        var link: String
        var naming: String
        var first_link: Bool
    }
}
