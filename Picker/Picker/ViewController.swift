//
//  ViewController.swift
//  Picker
//
//  Created by Jingyu Lim on 2021/07/31.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController{
    
    let imagePicker =  UIImagePickerController()
    var captureImage: UIImage!
    var videoURL: URL!
    var flagImageSave = false
    
    var imageView: UIImageView = {
        var view = UIImageView()
        return view
    }()
    
    let vStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        return view
    }()
    
    let topStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fillEqually
        
        return view
    }()
    
    var camearButton: UIButton!
    var camearPickerButton: UIButton!
    var videoButton: UIButton!
    var videoPickerButton: UIButton!
    
    let bottomStackView: UIStackView = {
        var view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fillEqually
        return view
    }()
    
    func makeButton(_ title: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: button.titleLabel!.font.fontName, size: 14)
        return button
    }
    
    func alert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btnCaptureImageFromCamera(_ sender: UIButton){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            alert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    @objc func btnLoadImageFromLibray(_ sender: UIButton){
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            alert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }
    
    @objc func btnRecordVideoFromCamera(_ sender: UIButton) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            flagImageSave = true
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            alert("Camera inaccessable", message: "Application cannot access the camera")
        }
    }
    
    @objc func btnLoadVideoFromLibrary(_ sender: UIButton){
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        } else {
            alert("Photo album inaccessable", message: "Application cannot access the photo album")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        camearButton = makeButton("사진촬영")
        camearButton.addTarget(self, action: #selector(btnCaptureImageFromCamera(_:)), for: .touchUpInside)
        videoButton = makeButton("비디오촬영")
        videoButton.addTarget(self, action: #selector(btnRecordVideoFromCamera(_:)), for: .touchUpInside)
        camearPickerButton = makeButton("사진앨범")
        camearPickerButton.addTarget(self, action: #selector(btnLoadImageFromLibray(_:)), for: .touchUpInside)
        videoPickerButton = makeButton("비디오앨범")
        videoPickerButton.addTarget(self, action: #selector(btnLoadVideoFromLibrary(_:)), for: .touchUpInside)
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(imageView)
        vStackView.addArrangedSubview(topStackView)
        topStackView.addArrangedSubview(camearButton)
        topStackView.addArrangedSubview(videoButton)
        vStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(camearPickerButton)
        bottomStackView.addArrangedSubview(videoPickerButton)
        
        
        let safeArear = view.safeAreaLayoutGuide
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.topAnchor.constraint(equalTo: safeArear.topAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: safeArear.bottomAnchor).isActive = true
        vStackView.leftAnchor.constraint(equalTo: safeArear.leftAnchor).isActive = true
        vStackView.rightAnchor.constraint(equalTo: safeArear.rightAnchor).isActive = true
            
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[.mediaType] as! NSString
        
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            captureImage = info[.originalImage] as? UIImage
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imageView.image = captureImage
        } else if mediaType.isEqual(to: kUTTypeMovie as NSString as String){
            if flagImageSave{
                videoURL = info[.mediaURL] as! URL
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}
