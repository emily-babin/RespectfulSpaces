//
//  ScenariosDetailViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-04.
//

import UIKit

class ScenariosDetailViewController: UIViewController {
    
    @IBOutlet weak var lbl_Detail_Title: UILabel!
    @IBOutlet weak var img_Detail: UIImageView!
    @IBOutlet weak var txt_Detail_Description: UITextView!
    @IBOutlet weak var txt_Detail_Response: UITextView!
    
    var current_Scenario: Scenarios!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title, image, and description
        lbl_Detail_Title.text = current_Scenario.title
        img_Detail.image = UIImage(named: current_Scenario.imageName)
        txt_Detail_Description.text = current_Scenario.description
        
        // Set background color for chat bubble effect
        txt_Detail_Description.backgroundColor = UIColor.systemBlue// Set blue background for chat bubble
        
        // Set text color for contrast
        txt_Detail_Description.textColor = UIColor.white // Black text for readability
        
        // Apply rounded corners for the bubble effect
        txt_Detail_Description.layer.cornerRadius = 15
        txt_Detail_Description.layer.masksToBounds = true // Ensures the text is clipped within the bubble
        
        // Add a subtle shadow to create depth, making the bubble stand out
        txt_Detail_Description.layer.shadowColor = UIColor.black.cgColor // Shadow color
        
        //Shadow's vertical offset
        txt_Detail_Description.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        txt_Detail_Description.layer.shadowOpacity = 0.2 // Soft shadow opacity
        txt_Detail_Description.layer.shadowRadius = 5 // Soft blur radius for shadow
        
        // Optional: Add padding around the text for better readability
        txt_Detail_Description.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        // Set background color for chat bubble effect
        txt_Detail_Response.backgroundColor = UIColor.systemBlue// Set blue background for chat bubble
        
        // Set text color for contrast
        txt_Detail_Response.textColor = UIColor.white // Black text for readability
        
        // Apply rounded corners for the bubble effect
        txt_Detail_Response.layer.cornerRadius = 15
        txt_Detail_Response.layer.masksToBounds = true // Ensures the text is clipped within the bubble
        
        // Add a subtle shadow to create depth, making the bubble stand out
        txt_Detail_Response.layer.shadowColor = UIColor.black.cgColor // Shadow color
        
        //Shadow's vertical offset
        txt_Detail_Response.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        txt_Detail_Response.layer.shadowOpacity = 0.2 // Soft shadow opacity
        txt_Detail_Response.layer.shadowRadius = 5 // Soft blur radius for shadow
        
        // Optional: Add padding around the text for better readability
        txt_Detail_Response.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

    }
}
