//
//  CreateMemeDetailViewController.swift
//  MemeIt
//
//  Created by scott harris on 2/3/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit
import CoreGraphics


class CreateMemeDetailViewController: UIViewController, ViewControllerMemeController {
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var labelBackground: UIView!
    
    var memeController: MemeController?
    
    
    override func viewDidLoad() {
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(addPhotoTapped))
        memeImageView.isUserInteractionEnabled = true
        memeTextField.delegate = self
        imageLabel.text = ""
        labelBackground.backgroundColor = UIColor(white: 0, alpha: 0.05)
        memeImageView.addGestureRecognizer(imageTapped)
    }
    
    @objc func addPhotoTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
        
        
    }
    
    
    
    @IBAction func createTapped(_ sender: Any) {
        if let image = memeImageView.image {
            let size = memeImageView.frame.size
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: size.width, height: size.height))
            let img = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left
                
                image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: ctx.currentImage.size))
                
                let rectangle = CGRect(origin: CGPoint(x: 0, y: ctx.currentImage.size.height - 44), size: CGSize(width: ctx.currentImage.size.width, height: 44))
                ctx.cgContext.setFillColor(red: 0, green: 0, blue: 0, alpha: 0.02)
                ctx.cgContext.addRect(rectangle)
                ctx.cgContext.drawPath(using: .fill)
                
                let attrs = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-bold", size: 36)!, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor: UIColor.white]
                
                if let text = memeTextField.text, !text.isEmpty {
                    let string = NSAttributedString(string: text, attributes: attrs)
                    string.draw(at: CGPoint(x: 10, y: ctx.currentImage.size.height - 48))
                }
                
            }
            
            labelBackground.alpha = 0
            memeImageView.image = img
            
            if let pngData = img.pngData() {
                let meme = Meme(category: .uncategorized, imageData: pngData, isFavorite: true)
                memeController?.createMeme(meme: meme)
                
            }
            
            tabBarController?.selectedIndex = 0
            
            
            
        }
        
        
        
    }
    
    
}

extension CreateMemeDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        labelBackground.alpha = 1
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
