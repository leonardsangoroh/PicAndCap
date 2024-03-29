//
//  ViewController.swift
//  PicAndCap
//
//  Created by Lee Sangoroh on 01/02/2024.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var interests = [Interest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPicAndCap))
        
        ///load array from disk when app runs
        let defaults = UserDefaults.standard
        
        ///get optional data
        if let savedInterests = defaults.object(forKey: "interests") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                ///hand it to jsonDecoder to convert it back to object graph
                interests = try jsonDecoder.decode([Interest].self, from:savedInterests)
            } catch {
                print("failed to load interests")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Interest", for:indexPath)
        
        let interest = interests[indexPath.item]
        
        cell.textLabel?.text = interest.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Interest") as? InterestViewController {
            
            let interest = interests[indexPath.item]
            //let path = getDocumentsDirectory().appendingPathComponent(interest.image)
            
            //vc.selectedImage?.image = path.path
            vc.selectedImage = interest.image
            navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.reloadData()
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        ///pullout and typecast image from the Image Picker
        guard let image = info[.editedImage] as? UIImage else {return}
        
        ///create UUID object and use its property to extract the unique identifier as a string data type
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        ///convert UIImage to Data object so it can be saved
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            ///write image to disk
            try? jpegData.write(to: imagePath)
        }
        
        let interest = Interest(name: "set caption", image: imageName)
        interests.append(interest)
        save()
        tableView.reloadData()
        
        dismiss(animated:true)
        
    }
    
    func getDocumentsDirectory()-> URL {
        ///asks for documents directory, secont parameter adds that we want the path to be relative to the user's home directory
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        ///returns an array that nearly always contains only one thing
        return paths[0]
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(interests) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "interests")
        }
    }

}

