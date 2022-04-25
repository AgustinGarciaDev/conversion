//
//  ConversionViewModel.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation


class ConversionViewModel: ConversionViewModelProtocol {
    

    private let conversationUseCase: ConversionUseCaseProtocol

    // MARK: - OUTPUT

    let totalConversion: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let total: Observable <DataConversion> = Observable(DataConversion(typeDolar: .dolarblue, value: 0.0))
    let typeDolarConversion: Observable<ConversionValues> = Observable(ConversionValues(typeDolar: .dolarblue, value: 0.0))

    // MARK: - Init
    init(conversationUseCase: ConversionUseCaseProtocol) {
        self.conversationUseCase = conversationUseCase
    }

    func convertMoney(_ infoConversion: DataConversion) {
        conversationUseCase.convertMoneyUseCase(parameters: infoConversion) { mappingDto in
            print(mappingDto)
            let conversion = Double(mappingDto.venta)! * Double(infoConversion.value)
            //self.totalConversion.value = String(conversion)
            self.total.value.value =  conversion
            self.typeDolarConversion.value.value = conversion
        } failure: { _ in
            print("error")
            self.error.value = NSLocalizedString("Error de conexion", comment: "")
        }
    }
}
