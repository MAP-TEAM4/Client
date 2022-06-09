//
//  PhotoViewController.swift
//  medicine
//
//  Created by 김동규 on 2022/06/10.
//

import UIKit
import SnapKit
import Then
import AVFoundation

class PhotoViewController: UIViewController, ViewProtocol {
    private let imagePickerController = UIImagePickerController()
    
    private let loadingLabel = UILabel().then {
        $0.text = ""
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        takePicture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setUpValue() {
        
    }
    
    func setUpView() {
        
    }
    
    func setConstraints() {
        
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePicture() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.6) else {
            return
        }
        
        CameraService.shared.getOcrResult(imageData: imageData) { data in
            print(data)
        }
        
        self.imagePickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePickerController.dismiss(animated: true, completion: nil)
        self.popView()
    }
}
