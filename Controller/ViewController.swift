//
//  ViewController.swift
//  Fortune telling and memes
//
//  Created by Pavel Kostin on 05.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkManager.shared
    
    private let questionTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Вопрос"
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.textAlignment = .center
        return textField
    }()
    
    private let mainButton: UIButton = {
        let but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.setTitle("Получить предсказание", for: .normal)
        but.setTitleColor(.white, for: .normal)
        
        but.backgroundColor = .black
        but.layer.cornerRadius = 10
        return but
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        questionTextField.delegate = self
        view.addSubview(questionTextField)
        view.addSubview(mainButton)
        mainButton.addTarget(self, action: #selector(tapOnButton), for: .touchUpInside)
        
        let screenSize = UIScreen.main.bounds.size
        NSLayoutConstraint.activate([
            questionTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            questionTextField.widthAnchor.constraint(equalToConstant: screenSize.width - (screenSize.width/8) * 2),
            questionTextField.heightAnchor.constraint(equalToConstant: questionTextField.intrinsicContentSize.height * 2),
            
            mainButton.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 10),
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.heightAnchor.constraint(equalTo: questionTextField.heightAnchor),
            mainButton.widthAnchor.constraint(equalTo: questionTextField.widthAnchor),
        ])
    }
    
    @objc func tapOnButton() {
        networkService.fetchMemes { [weak self] result in
            switch result {
            case .success(let memes):
                DispatchQueue.main.async {
                    let destinationVC = MemController(downloadedMemes: memes, question: self!.questionTextField.text ?? "")
                    self?.navigationController?.pushViewController(destinationVC, animated: true)
                }
            case .failure(let error):
                let alertController = UIAlertController(title: "Error", message: error.title, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .destructive)
                alertController.addAction(alertAction)
            }
        }
    }
}

