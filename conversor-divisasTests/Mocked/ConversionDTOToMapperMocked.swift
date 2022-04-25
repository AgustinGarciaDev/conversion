//
//  File.swift
//  conversor-divisasTests
//
//  Created by Agustin Chinchilla on 20/04/2022.
//

import Foundation
@testable import conversor_divisas

class ConversionDTOToMapperMocked: ConversionDTOToMapper {
  
    typealias T = ConversionDTOMapping
    typealias V = ConversionDTO
    
    private var viewModel: ConversionDTOMapping
    
    init(viewModel: ConversionDTOMapping) {
        self.viewModel = viewModel
    }
    
    override func map(from dto: ConversionDTO) -> ConversionDTOMapping {
        viewModel
    }
}
