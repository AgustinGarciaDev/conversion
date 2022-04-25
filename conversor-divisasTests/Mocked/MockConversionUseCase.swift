//
//  MockConversionUseCase.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 21/04/2022.
//

import Foundation
import XCTest
@testable import conversor_divisas


class MockUseCaseConversion: ConversionUseCaseProtocol {
    var expectation: XCTestExpectation?
    var error: Error?
    let dto = ConversionDTOMapping(fecha: "", compra: "119.03", venta: "119.03")

    func convertMoneyUseCase(parameters: DataConversion, success: @escaping (ConversionDTOMapping) -> Void, failure: @escaping (Bool) -> Void) {

        if error != nil {
            failure(false)
        } else {
            success(dto)
        }
        expectation?.fulfill()
    }
}

