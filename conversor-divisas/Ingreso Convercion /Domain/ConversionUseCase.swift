//
//  ConversationUseCase.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation

class ConversionUseCase: ConversionUseCaseProtocol {

    private let conversionRepository: ConversionRepositoryProtocol
    private let modelMapping: ConversionDTOToMapper

    init(conversionRepository: ConversionRepositoryProtocol, modelMapping: ConversionDTOToMapper) {
        self.conversionRepository = conversionRepository
        self.modelMapping = modelMapping
    }

    func convertMoneyUseCase(parameters: DataConversion, success: @escaping (ConversionDTOMapping) -> Void, failure: @escaping (Bool) -> Void) {
        conversionRepository.convertMoney(parameters: parameters) { [weak self] conversionDTO in
            guard let self = self else { return }
            let mappingDto = self.modelMapping.map(from: conversionDTO)
            success(mappingDto)
        } failure: { _ in
            failure(false)
            print("error ")
        }
    }
}
