//
//  Extension+ViewController.swift
//  FortuneTellingAndMemes
//
//  Created by Pavel Kostin on 07.06.2024.
//

import Foundation
import UIKit


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

extension UIView {
    func addGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        addGestureRecognizer(tapGesture)
    }
}
