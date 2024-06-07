//
//  MemController.swift
//  Fortune telling and memes
//
//  Created by Pavel Kostin on 05.06.2024.
//

import Foundation
import UIKit


final class MemController: UIViewController {
    
    private let downloadedMemes: [Meme]
    
    private var currentMeme: Meme
    
    private let question: String
    
    let networkService = NetworkManager.shared
    
    private let memeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let rejectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        let symbolFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: symbolFont)
        let symbolImage = UIImage(systemName: "hand.thumbsdown.fill", withConfiguration: configuration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let accessButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        let symbolFont = UIFont.systemFont(ofSize: 50)
        let configuration = UIImage.SymbolConfiguration(font: symbolFont)
        let symbolImage = UIImage(systemName: "hand.thumbsup.fill", withConfiguration: configuration)
        button.setImage(symbolImage, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    private let questionLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = ""
        return lable
    }()
    
    required init(downloadedMemes: [Meme], question: String) {
        self.downloadedMemes = downloadedMemes
        self.question = question
        self.questionLable.text = question
        self.currentMeme = downloadedMemes.randomElement()!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.fetchMemeImage(from: currentMeme) { image in
            self.memeImageView.image = image
        }
        
        rejectButton.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
        accessButton.addTarget(self, action: #selector(accessAction), for: .touchUpInside)
        
        view.backgroundColor = .lightGray
        view.addSubview(questionLable)
        view.addSubview(memeImageView)
        view.addSubview(rejectButton)
        view.addSubview(accessButton)
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        
        NSLayoutConstraint.activate([
            questionLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            memeImageView.topAnchor.constraint(equalTo: questionLable.bottomAnchor, constant: 25),
            memeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            memeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            memeImageView.heightAnchor.constraint(equalToConstant: screenSize.height / 2),
            
            rejectButton.topAnchor.constraint(equalTo: memeImageView.bottomAnchor, constant: 20),
            rejectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            accessButton.topAnchor.constraint(equalTo: memeImageView.bottomAnchor, constant: 20),
            accessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
        ])
    }
    
    @objc private func rejectAction() {
        
        currentMeme = downloadedMemes.randomElement()!
        
        networkService.fetchMemeImage(from: currentMeme) { image in
            self.memeImageView.image = image
        }
    }
    
    @objc private func accessAction() {
        let allert = UIAlertController(title: "Ответ принят!", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
            
        }
        allert.addAction(action)
        self.present(allert, animated: true)
    }
}
