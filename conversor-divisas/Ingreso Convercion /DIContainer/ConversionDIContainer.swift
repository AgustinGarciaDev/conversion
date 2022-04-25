//
//  ConversationDIContainer.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation
import UIKit

protocol DIContainer {
    func makeViewController() -> ConversionViewController 
}

protocol Dependencies {
    func makeConversationUseCase() -> ConversionUseCase
    func makeMappingDTO() -> ConversionDTOToMapper
    func makeConversationRepository() -> ConversionRepository 
    func makeConversationViewModel() -> ConversionViewModel
}

//Protocolo separado de dependencias

//class  MockConversionDIContainer: DIContainer{
//    func makeViewController() -> UIViewController {
//        return ConversionViewController.create(with: makeConversationViewModel())
//    }
//}

class ConversionDIContainer: DIContainer, Dependencies  {

    // Crear un protocolo .. dejar makeConversionViewController
    //MARK:  - UseCase
    
    func makeConversationUseCase() -> ConversionUseCase {
        return ConversionUseCase(conversionRepository: makeConversationRepository(), modelMapping: makeMappingDTO())
    }

    func makeMappingDTO() -> ConversionDTOToMapper {
        return ConversionDTOToMapper()
    }

    // MARK: - Repositories

    func makeConversationRepository() -> ConversionRepository {
       
        return ConversionRepository(dataSource: ConversionDataSource())
    }

    // MARK: - Conversion

    func makeViewController() -> ConversionViewController {
        return ConversionViewController.create(with: makeConversationViewModel())
    }

    func makeConversationViewModel() -> ConversionViewModel {
        return ConversionViewModel(conversationUseCase: makeConversationUseCase())
    }
    
}
