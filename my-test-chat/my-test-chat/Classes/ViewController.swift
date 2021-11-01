//
//  ViewController.swift
//  my-test-chat
//
//  Created by Shindarev Nikita on 20.10.2021.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate{

    // MARK: UIFields
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    // MARK: ================== LIFECYCLE EVENTS =======================

    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.layer.cornerRadius = profileView.bounds.width / 2
        imageView.layer.cornerRadius = profileView.bounds.width / 2
        
        btnSave.layer.cornerRadius = 14
        imagePicker.delegate = self
    }
    
    // MARK: ================== UI EVENTS =======================
    
    @IBAction func onEditTapped(_ sender: UIButton) {

        self.btnEdit.isUserInteractionEnabled = true

        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.switchImagePicker(.camera)
        }))

        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.switchImagePicker(.photoLibrary)
        }))
        

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }

    // MARK: ================== SUPPORT METHODS =======================
    
    func switchImagePicker (_ type: UIImagePickerController.SourceType){
        switch type{
        case .camera:
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
            {
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                self.imagePicker.allowsEditing = true
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        case .photoLibrary:
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary))
            {
                self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.imagePicker.allowsEditing = true
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have photo library access", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        default:
            return
        }
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}


// MARK: ================== UIImagePickerController DELEGATE METHODS =======================
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

        // Set photoImageView to display the selected image.
        imageView.image = selectedImage

        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
}
