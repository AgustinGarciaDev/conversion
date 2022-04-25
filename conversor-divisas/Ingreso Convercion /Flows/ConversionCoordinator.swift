//
//  ConversionCoordinator.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 19/04/2022.
//

import Foundation
import UIKit

final class ConversionCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependecies: DIContainer
    private weak var viewController: ConversionViewController?
    
    init(navigationController: UINavigationController, dependecies:DIContainer) {
        self.navigationController = navigationController
        self.dependecies = dependecies
    }
    
    func start(){
        let vc = dependecies.makeViewController()
        print(vc)
       navigationController?.pushViewController(vc, animated: false)
    }
}
