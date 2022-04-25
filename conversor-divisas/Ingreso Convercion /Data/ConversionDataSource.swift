//
//  ConversationDataSource.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation
import Alamofire

class ConversionDataSource: ConversionDataSourceProtocol{
    static let shared = ConversionDataSource()
    
    let url = "https://api-dolar-argentina.herokuapp.com/api/"

    func requestconvertMoney(parameters: DataConversion, success: @escaping (ConversionDTO?) -> Void, failure: @escaping (Bool) -> Void) {
        
        Alamofire.Session.default.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        var request = URLRequest(url: URL(string: "\(self.url)\(parameters.typeDolar)")!)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseData { response in
        
                    switch response.result {
                    case .success(let value):
                        do{
                            let dto = try JSONDecoder().decode(ConversionDTO.self, from: value)
                          success(dto)
                        }catch{
                            print(error.localizedDescription)
                        }
                        break
                    case .failure(let error):
                        print(error)
                        failure(false)
                        break
                    }
            }
    }

}
