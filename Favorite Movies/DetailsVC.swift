//
//  DetailsVC.swift
//  Favorite Movies
//
//  Created by Mohammad Hemani on 4/19/17.
//  Copyright © 2017 Mohammad Hemani. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    var movieToEdit: Movie?
    var imagePicker: UIImagePickerController!
    var defaultImage = UIImage(named: "imagePick")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        urlTextField.delegate = self
        
        if movieToEdit != nil {
            loadMovieData()
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
        var movie: Movie!
        
        if let title = titleTextField.text, let details = descriptionTextField.text, let link = urlTextField.text, movieImage.image != defaultImage {
            
            if movieToEdit == nil {
                movie = Movie(context: context)
            } else {
                movie = movieToEdit
            }
        
            movie.title = title
            movie.details = details
            movie.link = link
            movie.lastUpdated = NSDate()
            
            let picture = Image(context: context)
            picture.image = movieImage.image
            movie.toImage = picture
            
            ad.saveContext()
            navigationController?.popViewController(animated: true)
        } else {
            showErrorAlert(title: "Fields/Image Empty", message: "Please enter text for every field and/or choose an image")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissTextFields() {
        titleTextField.endEditing(true)
        descriptionTextField.endEditing(true)
        urlTextField.endEditing(true)
    }
    
    func loadMovieData() {
        if let movie = movieToEdit {
            titleTextField.text = movie.title
            descriptionTextField.text = movie.details
            urlTextField.text = movie.link
            movieImage.image = movie.toImage?.image as? UIImage
        }
    }
    
    @IBAction func addImageTapped(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage {
            movieImage.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func showErrorAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}
