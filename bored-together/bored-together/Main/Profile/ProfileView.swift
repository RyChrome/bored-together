//
//  ProfileView.swift
//  bored-together
//
//  Created by Ryan Dils on 6/15/19.
//  Copyright © 2019 team19. All rights reserved.
//

import Foundation
import UIKit

struct Setting {
    var name: String
}

class ProfileView: UIViewController, UIImagePickerControllerDelegate, UITableViewDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
  
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var hometown: UILabel!
  @IBOutlet weak var circleView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    profileImage.layer.masksToBounds = false
//    profileImage.layer.borderColor = UIColor.black.cgColor
//    profileImage.layer.cornerRadius = profileImage.frame.height/2
//    profileImage.clipsToBounds = true
    
    imagePicker.delegate = self
    
    messages = []
    
    let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
    swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
    self.view.addGestureRecognizer(swipeLeft)
  }
  
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
      if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
          // go back
          print("going back")
          self.performSegue(withIdentifier: "back_to", sender: self)
        default:
          break
        }
      }
    }
    
    var messages:[String]!
    
    @IBAction func changeImage(sender: Any) {
      
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}


