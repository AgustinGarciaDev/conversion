//
//  ConversionViewProtocols.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation

struct DataConversion {
    let typeDolar: type_dolar
    var value: Double
}

class ConversionValues {
    var typeDolar : type_dolar
    var value: Double 
    
    init(typeDolar:type_dolar , value:Double){
        self.value = value 
        self.typeDolar = typeDolar
    }
}


protocol ConversionViewModelProtocol: ConversionViewModelOutputProtocol {
    func convertMoney(_ infoConversion: DataConversion)
}

protocol ConversionViewModelOutputProtocol {
    var totalConversion: Observable<String> { get }
    var error: Observable<String> { get }
    var errorTitle: String { get }
    var total: Observable<DataConversion> { get }
    var typeDolarConversion: Observable <ConversionValues>{get}
}

protocol ConversionUseCaseProtocol {
    func convertMoneyUseCase(parameters: DataConversion, success: @escaping (ConversionDTOMapping) -> Void, failure: @escaping (Bool) -> Void)
}

protocol ConversionRepositoryProtocol {
    func convertMoney(parameters: DataConversion, success: @escaping (ConversionDTO) -> Void, failure: @escaping (Bool) -> Void)
}

protocol ConversionDataSourceProtocol {
    func requestconvertMoney(parameters: DataConversion, success: @escaping (ConversionDTO?) -> Void, failure: @escaping (Bool) -> Void)
}

protocol DTOToViewModelMapperProtocol {
    associatedtype T
    associatedtype V
    func map(from dto: V) -> T
}
