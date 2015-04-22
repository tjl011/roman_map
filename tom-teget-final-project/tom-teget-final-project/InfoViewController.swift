//
//  InfoViewController.swift
//  tom-teget-final-project
//
//  Created by Yiğitcan Aydın on 4/22/15.
//  Copyright (c) 2015 Bucknell University. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    /// Filename of the image to be displayed on the information page
    var imageFileName: String?
    
    /// Filename of the text file which contains the info to be displayed on the info page
    var textFileName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setImageView()
        setTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Returns the path to the root of the project
    func resourcePath() -> String {
        return NSBundle.mainBundle().resourcePath!
    }
    
    func setImageView() {
        let imagePath = resourcePath().stringByAppendingPathComponent(imageFileName!)
        if let theImage = UIImage(contentsOfFile: imagePath) {
            imageView.image = theImage
        } else {
            println("\(__FUNCTION__): image is nil!")
        }
    }
    
    func setTextView() {
        let textPath = resourcePath().stringByAppendingPathComponent(textFileName!)
        if let theText = String(contentsOfFile: textPath, encoding: NSUTF8StringEncoding, error: nil) {
            textView.text = theText
        } else {
            println("\(__FUNCTION__): text is nil!")
        }
    }

}
