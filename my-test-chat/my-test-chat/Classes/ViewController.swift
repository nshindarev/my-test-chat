//
//  ViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 20.10.2021.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: UIFields
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewPhoto: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func onEditTapped(_ sender: UIButton) {

        self.btnEdit.isUserInteractionEnabled = true

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            print("camera")
            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            print("gallery")
            self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

        viewPhoto.addSubview(imagePicker.view)
    }
    
    //MARK:- ***************  UIImagePickerController delegate Methods ****************

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        imageView.image = selectedImage
        viewPhoto.isHidden = true

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPhoto.layer.cornerRadius = viewPhoto.bounds.width / 2
        btnSave.layer.cornerRadius = 14
        
        imagePicker.delegate = self
    }
    

    
}

extension ViewController {
    func alertMessageOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
