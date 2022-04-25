//
//  ConversionViewController.swift
//  conversor-divisas
//
//  Created by Agustin Chinchilla on 12/04/2022.
//

import UIKit

enum type_dolar {
    case dolarblue
    case dolarbolsa
    case dolaroficial
}

class ConversionViewController: UIViewController, Alertable {

    private var viewModel: ConversionViewModel!

    // MARK: -  Components

    lazy var titleHome: UILabel = {
        let title = UILabel()
        title.text = "Conversor de ARS a USD"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var inputCash: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Ingrese monto"
        input.textColor = .black
        input.backgroundColor = .white
        input.setLeftPaddingPoints(20)
        input.borderStyle = .line
        input.layer.borderWidth = 1
        input.layer.borderColor = UIColor.black.cgColor
        input.keyboardType = .decimalPad
        return input
    }()


    lazy var menuButton: UIMenu = {

        let dolarOficial = UIAction(title: "Dolar Oficial",
            image: UIImage(systemName: "")) { [weak self] _ in
            self?.loading.isHidden = false
            self?.viewModel.convertMoney(DataConversion(typeDolar: .dolaroficial, value: (self?.getValue())!))
        }

        let dolarBolsa = UIAction(title: "Dolar Bolsa",
            image: UIImage(systemName: "")) { [weak self] _ in
            self?.loading.isHidden = false
            self?.viewModel.convertMoney(DataConversion(typeDolar: .dolarbolsa, value: Double(self?.inputCash.text ?? "") ?? 0.0))
        }

        let dolarBlue = UIAction(title: "Dolar Blue",
            image: UIImage(systemName: "")) { [weak self] _ in
            self?.loading.isHidden = false
            self?.viewModel.convertMoney(DataConversion(typeDolar: .dolarblue, value: Double(self?.inputCash.text ?? "") ?? 0.0))
        }

        return UIMenu(title: "Conversion", children: [dolarOficial, dolarBolsa, dolarBlue])
    }()

    lazy var buttonPrimary: UIButton = {

        let button = UIButton()
        button.setTitle("Convertir", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsMenuAsPrimaryAction = true
        button.menu = menuButton
        return button
    }()

    lazy var labelCashTotality: UILabel = {
        let label = UILabel()
        // label.text = viewModel.totalConversion.value
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var loading: UIActivityIndicatorView = {
        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.isHidden = true
        return loading
    }()

    // MARK: - Lifecycle

    static func create(with viewModel: ConversionViewModel) -> ConversionViewController {
        let view = ConversionViewController()
        view.viewModel = viewModel
        return view
    }

    deinit {
        print("deinit \(self)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buildViewHierarchy()
        bind(to: viewModel)
        setupConstraints()
    }

    private func bind(to viewModel: ConversionViewModel) {
        viewModel.total.observe(on: self) { [weak self] in
            self?.updateInput(String($0.value))
        }
//        viewModel.totalConversion.observe(on: self) { [weak self] in
//            self?.updateInput($0)
//        }
        viewModel.error.observe(on: self) { [weak self] in
            self?.errorShow($0)
        }

        viewModel.typeDolarConversion.observe(on: self) { [weak self] in
            self?.getTypeDolar($0)
        }

    }

    // MARK: - Layout setup

    private func buildViewHierarchy() {
        view.addSubview(titleHome)
        view.addSubview(inputCash)
        view.addSubview(buttonPrimary)
        view.addSubview(labelCashTotality)
        view.addSubview(loading)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            inputCash.topAnchor.constraint(equalTo: titleHome.bottomAnchor, constant: 20),
            inputCash.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputCash.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputCash.widthAnchor.constraint(equalToConstant: 400),
            inputCash.heightAnchor.constraint(equalToConstant: 50),

            buttonPrimary.bottomAnchor.constraint(equalTo: inputCash.bottomAnchor, constant: 50),
            buttonPrimary.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonPrimary.widthAnchor.constraint(equalToConstant: 200),


            loading.topAnchor.constraint(equalTo: buttonPrimary.bottomAnchor, constant: 20),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            labelCashTotality.topAnchor.constraint(equalTo: buttonPrimary.bottomAnchor, constant: 20),
            labelCashTotality.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            ])
    }

    // MARK: - Funcionality

    func getValue() -> Double {
        let value = Double(self.inputCash.text ?? "") ?? 0.0
        return value
    }

    private func updateInput(_ conversion: String) {
        if(conversion != "") {
            loading.isHidden = true
            labelCashTotality.text = "$\(conversion)"
        }
    }

    private func errorShow(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }

    private func getTypeDolar(_ typeDolar: ConversionValues) {
        print(typeDolar.value)
    }

}


extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
