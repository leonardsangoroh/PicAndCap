//
//  ViewController.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 01/02/2024.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicAndCap))
    }
    
    @objc func addPicAndCap() {
        let picker = UIImagePickerController()
        
        if UIDevice.isSimulator {
            picker.sourceType = .photoLibrary
        } else {
            picker.sourceType = .camera
        }
        
        ///allow croping of selected image
        picker.allowsEditing = true
        ///setting self as delegate. Need to conform to UIImagePickerControllerDelegate protocol and the UINavigationControllerDelegate protocol
        picker.delegate = self
        present(picker, animated: true)
    }


}

