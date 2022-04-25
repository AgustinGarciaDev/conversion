//
//  ConversionUseCaseTest.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import XCTest
@testable import conversor_divisas

class ConversionUseCaseTest: XCTestCase {

    let mockModelMapper = ConversionDTOToMapperMocked(viewModel: .empty)

    // MARK: - Tests

    func test_conversionUseCase_whenSucessfully() {
        //Given
        let dataSource = ConversionDataSourceMocked(responseType: .success)
        let repository = ConversionRepository(dataSource: dataSource)
        let sut = ConversionUseCase(conversionRepository: repository, modelMapping: mockModelMapper)
        let expectation = XCTestExpectation(description: "Wait for data source to complete")

        //When

        sut.convertMoneyUseCase(parameters: DataConversion(typeDolar: .dolarblue, value: 0.0)) { ConversionDTOMapping in
            expectation.fulfill()
        } failure: { _ in
            XCTFail("Not supposed to happen")
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }

    func test_conversionUseCase_whenFailed() {
        //Given
        let dataSource = ConversionDataSourceMocked(responseType: .nilDTO)
        let repository = ConversionRepository(dataSource: dataSource)
        let sut = ConversionUseCase(conversionRepository: repository, modelMapping: mockModelMapper)
        let expectation = XCTestExpectation(description: "Wait for data source to complete")

        //When

        sut.convertMoneyUseCase(parameters: DataConversion(typeDolar: .dolarblue, value: 0.0)) { ConversionDTOMapping in
            XCTFail("Not supposed to happen")
        } failure: { error in
            expectation.fulfill()
            XCTAssertTrue(error == false, "Error type is not correct. Got \(error) Expected invalidFetchedData")
        }
        // Then
        wait(for: [expectation], timeout: 3.0)
    }
}
