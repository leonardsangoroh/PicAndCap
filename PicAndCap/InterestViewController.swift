//
//  InterestViewController.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 02/02/2024.
//

import UIKit

class InterestViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        
        print(selectedImage)
        if let imageToLoad = selectedImage {
            print(imageToLoad)
            let path = getDocumentsDirectory().appendingPathComponent(imageToLoad)
            imageView.image = UIImage(contentsOfFile: path.path)
        } else {
            fatalError("Cannot find Photo to Load")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func getDocumentsDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    

}
