//
//  SaleResultViewModeTest.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import XCTest
@testable import conversor_divisas

class SaleResultViewModeTest: XCTestCase {

    // MARK: - Tests
    
    func test_whenUserConversionDolarBlue_thenViewModelContainConversionTotal(){
        //Given 
        let useCase = MockUseCaseConversion()
        useCase.expectation = self.expectation(description: "Wait for conversion")
        let sut = ConversionViewModel(conversationUseCase: useCase)
        let data = DataConversion(typeDolar: .dolaroficial, value: 1)
        //When 
    
        sut.convertMoney(data)    
        //Then 
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(sut.total.value.value, 119.03)
    }
    
    func test_integration_whenUserConversionDolarBlue_thenViewModelContainConversionTotal(){
        //Given 
        let useCase = MockUseCaseConversion()
        useCase.expectation = self.expectation(description: "Wait for conversion")
        let sut = ConversionViewModel(conversationUseCase: useCase)
        let data = DataConversion(typeDolar: .dolaroficial, value: 5)
        //When 
    
        sut.convertMoney(data)   
        sut.total.observe(on: self) { data in
            print(data)
            XCTAssertTrue(true)
        }
        //Then 
        waitForExpectations(timeout: 5, handler: nil)
    }
}
