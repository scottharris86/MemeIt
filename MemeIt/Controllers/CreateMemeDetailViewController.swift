//
//  CreateMemeDetailViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/3/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit


class CreateMemeDetailViewController: UIViewController {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    
    
    override func viewDidLoad() {
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(addPhotoTapped))
        memeImageView.isUserInteractionEnabled = true
        memeTextField.delegate = self
        imageLabel.text = ""
        
        memeImageView.addGestureRecognizer(imageTapped)
    }
    
    @objc func addPhotoTapped() {
        print("image tapped!!")
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
        
    }
    
    

    @IBAction func createTapped(_ sender: Any) {
        
    }
    
    
}

extension CreateMemeDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        memeImageView.image = selectedImage
        dismiss(animated: true)
        
    }
    
}

extension CreateMemeDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("called should change characters \(textField.text)")
//        print("Replacement string is: \(string)")
        if let text = textField.text {
            imageLabel.text =  text + string
        } else {
            imageLabel.text = string
        }
        return true
    }
    
}
