//
//  ConversionDTOToMapper.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation

class ConversionDTOToMapper: DTOToViewModelMapperProtocol {

    typealias T = ConversionDTOMapping
    typealias V = ConversionDTO

    func map(from dto: ConversionDTO) -> ConversionDTOMapping {

        return ConversionDTOMapping(fecha: dto.fecha ?? "",
            compra: dto.compra ?? "",
            venta: dto.venta ?? "")
    }

}
