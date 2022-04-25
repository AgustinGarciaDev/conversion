//
//  ConversionDTO.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import Foundation

struct ConversionDTO: Decodable {
    let fecha: String?
    let compra: String?
    let venta: String?
}
