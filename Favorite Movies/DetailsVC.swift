//
//  DetailsVC.swift
//  Favorite Movies
//
//  Created by Mohammad Hemani on 4/19/17.
//  Copyright © 2017 Mohammad Hemani. All rights reserved.
//

import UIKit
import CoreData

class DetailsVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieImageButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    var movieToEdit: Movie?
    
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
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
        var movie: Movie!
        
        if movieToEdit == nil {
            movie = Movie(context: context)
        } else {
            movie = movieToEdit
        }
        
        if let title = titleTextField.text, let details = descriptionTextField.text, let link = urlTextField.text {
        
            movie.title = title
            movie.details = details
            movie.link = link
        }
        
        ad.saveContext()
        navigationController?.popViewController(animated: true)
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
        }
    }

}
