//
//  ViewController.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 01/02/2024.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicAndCap))
    }
    
    @objc func addPicAndCap() {
        
    }


}

