//
//  ConversionRepositoryTest.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import XCTest
@testable import conversor_divisas

class ConversionRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests
    
    func test_requestConversion_validDTO_successResponse(){
        let dataSource = ConversionDataSourceMocked(responseType: .success)
        let sut = ConversionRepository(dataSource: dataSource)
        let expectation = XCTestExpectation(description: "Wait for data source to complete")
        
        sut.convertMoney(parameters: DataConversion(typeDolar: .dolarblue, value: 0.0)) { ConversionDTO in
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Not supposed to happen")
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_requestConversion_nilDTO_invalidFetch(){
        let dataSource = ConversionDataSourceMocked(responseType: .nilDTO)
        let sut = ConversionRepository(dataSource: dataSource)
        let expectation = XCTestExpectation(description: "Wait for data source to complete")
        
        sut.convertMoney(parameters: DataConversion(typeDolar: .dolarblue, value: 0.0)) { ConversionDTO in
            XCTFail("Not supposed to happen")
        } failure: { _ in
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_requestConversion_anyError_failureResponse(){
        let dataSource = ConversionDataSourceMocked(responseType: .failed)
        let sut = ConversionRepository(dataSource: dataSource)
        let expectation = XCTestExpectation(description: "Wait for data source to complete")
        
        sut.convertMoney(parameters: DataConversion(typeDolar: .dolarblue, value: 0.0)) { ConversionDTO in
            XCTFail("Not supposed to happen")
        } failure: { _ in
            expectation.fulfill()
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }
}
