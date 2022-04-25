//
//  ConversionDTOToMapperTest.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import XCTest
@testable import conversor_divisas

class ConversionDTOToMapperTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Tests
    
    func test_mapDTOToViewModel_validDTO_success() {
        // Given
        let sut = ConversionDTOToMapper()       
        // When
        let viewModel = sut.map(from: ConversionDTO(fecha: "", compra: "", venta: ""))
        
        // Then
        XCTAssertNotNil(viewModel, "View model is nil for some reason")
    }

}
