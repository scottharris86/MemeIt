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
    

//    var newMeme: Meme?
    
    // MARK: - Outlets and Actions
    
    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeTextField: UITextField!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var labelBackground: UIView!
    
    // MARK: - Properties
    
    var memeController: MemeController?
    var meme: Meme?
    
    
    
    @IBAction func createTapped(_ sender: Any) {
        
        if let image = memeImageView.image {
            let size = memeImageView.frame.size
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: size.width, height: size.height))
            let img = renderer.image { ctx in
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .center
                
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
                let meme = Meme(category: .Uncategorized, imageData: pngData, isFavorite: true)
                memeController?.createMeme(meme: meme)
                self.meme = meme
            }

        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(addPhotoTapped))
        updateViews()
        memeImageView.addGestureRecognizer(imageTapped)
    }
    
    // MARK: - Methods
    
    @objc func addPhotoTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func updateViews() {
        if let meme = meme {
            memeImageView.image = meme.image
            labelBackground.alpha = 1
        } else {
            memeImageView.image = UIImage(named: "add_photo")
        }
        memeImageView.isUserInteractionEnabled = true
        memeTextField.delegate = self
        imageLabel.text = ""
        labelBackground.backgroundColor = UIColor(white: 0, alpha: 0.05)
        
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        guard let userInfo = notification.userInfo else {return}
        let keyboardFrame = keyboardValue.cgRectValue
        
//        let keyboardScreenEndFrame = keyboardValue.cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        } else {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardFrame.height - 80
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChooseCategorySegue"{
            guard let categorySelectionVC = segue.destination as? CategorySelectionViewController,
                let passedMeme = meme,
                let memeController = memeController else { return }
            categorySelectionVC.meme = passedMeme
            categorySelectionVC.memeController = memeController
                
          
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
