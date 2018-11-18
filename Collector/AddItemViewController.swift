//
//  AddItemViewController.swift
//  Collector
//
//  Created by tester on 11/18/18.
//  Copyright © 2018 Tepo Labs. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {  //added 'follow uiImagePickerController for delegate'

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePicker.delegate = self //delegate looking for class that can handle its situations.
        
    }
    
    
    @IBAction func cameraTapped(_ sender: Any) {
    }
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary //select photo lib here, not camera
        present(imagePicker, animated: true, completion: nil) //present image picker view controller we created to go to photo lib.  completion can be nil or function to call upon completion.
        
        
    }
    
    //this fxn gets called when someone selects an image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //get selected image from returned info dictionary
        
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                itemImageView.image = chosenImage
        }
        //need to dismiss image picker now that we have selected one
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddTapped(_ sender: Any) {
    }
    
}
