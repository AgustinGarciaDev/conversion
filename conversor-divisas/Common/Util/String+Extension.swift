//
//  String+Extension.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 13/04/2022.
//

import UIKit

public extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
