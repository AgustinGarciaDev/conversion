//
//  ViewController.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 12/04/2022.
//

import UIKit

class ViewController: UIViewController {
        
    lazy var titleHome: UILabel = {
        let title = UILabel()
        title.text = "Bienvenido!"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var buttonPrimary: UIButton = {
        let button = UIButton()
        button.setTitle("Empezar", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateView), for: .touchUpInside)
        return button
    }()
    
    deinit {
        print("deinit \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViewHierarchy()
        setupConstraints()
    }

    // MARK: - Layout setup

    private func buildViewHierarchy() {
        view.addSubview(titleHome)
        view.addSubview(buttonPrimary)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleHome.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            buttonPrimary.bottomAnchor.constraint(equalTo: titleHome.bottomAnchor, constant: 50),
            buttonPrimary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPrimary.widthAnchor.constraint(equalToConstant: 200)

            ])
    }

    @objc func navigateView() {
        
        let dicontainer = ConversionDIContainer()
        let vc = dicontainer.makeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let conversationContainer = ConversionDIContainer()
//        let flow = conversationContainer.makeConversionFlowCoordinator(navigationController: navigationController!)
//        flow.start()
    }
}

