//
//  ConversationRepository.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation

class ConversionRepository: ConversionRepositoryProtocol {

    private let dataSource: ConversionDataSourceProtocol

    init(dataSource: ConversionDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func convertMoney(parameters: DataConversion, success: @escaping (ConversionDTO) -> Void, failure: @escaping (Bool) -> Void) {
        dataSource.requestconvertMoney(parameters: parameters) { [weak self] dto in
            guard let _ = self else { return }
            guard let conversionDTO = dto else {
                failure(false)
                return
            }
            success(conversionDTO)
        } failure: { _ in
            failure(false)
            print("Caimos en un error del repository")
        }
    }
}
