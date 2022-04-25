//
//  ConversionDataSourceMocked.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import Foundation

enum MockedResponseType {
    case success // Happy path =)
    case warning // Use case where something is supposed to be wrong due to a business rule
    case failed
    case failedWithError // Error from backend, maybe services are down
    case nilDTO // Returns a nil DTO object
}

class ConversionDataSourceMocked: ConversionDataSourceProtocol{
    
    var responseType: MockedResponseType
    
    init(responseType: MockedResponseType = .success) {
        self.responseType = responseType
    }
    
    func requestconvertMoney(parameters: DataConversion, success: @escaping (ConversionDTO?) -> Void, failure: @escaping (Bool) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { [weak self] in
            guard let self = self else { return }
            switch self.responseType {
            case .success:
                success(self.conversion_successfulDTO())
            case .nilDTO:
                success(nil)
            case .failedWithError:
                failure((self.conversion_failedDTO() != nil))
            case .failed: 
                 failure(false)
            default:
                failure(false)
            }
        }
    }
    
    var responseFailedJSON: String {
        """
        {
          "fecha": "2022/04/20 17:13:10",
          "compra": "0.0",
           "venta": "0.0"
        }
        """
    }

    var responseSuccessJSON: String {
        """
        {
            "fecha": "2022/04/20 17:13:10",
            "compra": "113.03",
            "venta": "119.03"
        }
        """
    }
    
    func conversion_successfulDTO() -> ConversionDTO? {
        mockConversion(withJSONString: responseSuccessJSON)
    }
    
    func conversion_failedDTO() -> ConversionDTO? {
        mockConversion(withJSONString: responseFailedJSON)
    }
    
    private func mockConversion(withJSONString json: String) -> ConversionDTO? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(ConversionDTO.self, from: json.data(using: .utf8)!)
    }
}

