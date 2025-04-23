//
//  ScenariosDetailViewController.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-04.
//

import UIKit

class ScenariosDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lbl_Detail_Title: UILabel!
    //@IBOutlet weak var img_Detail: UIImageView!
    @IBOutlet weak var txt_Detail_Description: UITextView!
    @IBOutlet weak var txt_Detail_Response: UITextView!
    
    @IBOutlet weak var view_BackgroundResponse: UIView!
    
    
    @IBOutlet weak var lbl_Other_Response: UILabel!
    @IBOutlet weak var txt_Facts: UITextView!
    
    
    var current_Scenario: Scenarios!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title, image, and description
        lbl_Detail_Title.text = current_Scenario.title
        //img_Detail.image = UIImage(named: current_Scenario.imageName)
        txt_Detail_Description.text = current_Scenario.content
        
        //HIG DOES NOT WANT THE COLORS TO BE SET PROGRAMMATICALLY IF POSSIBLE
        //SHADOW EFFECT REMOVED
        //SHADOW EFFECT NOT REQUIRED FOR HIG
        //IF SHADOW IS NEEDED THE VIEW MUST BE PLACED INSIDE ANOTHER VIEW
        //THE MASKSTOBOUNDS PROPERTY MUST BE SET TO FALSE ON PARENT VIEW TO SEE SHADOW
        //IF SET TO FALSE ON CHILD VIEW TEXTVIEW WILL NOT WORK PROPERLY ON LONG TEXTS
        
        /////////////////////////////////// TOP LABEL
        // Set background color for chat bubble effect
        //txt_Detail_Description.backgroundColor = UIColor.systemGray// Set background for chat bubble
        
        // Set text color for contrast
        //txt_Detail_Description.textColor = UIColor.label
        
        // Apply rounded corners for the bubble effect
        txt_Detail_Description.layer.cornerRadius = 20
        //txt_Detail_Description.layer.masksToBounds = true // Ensures the text is clipped within the bubble
        
        txt_Detail_Description.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        /*
        // Add a subtle shadow to create depth, making the bubble stand out
        txt_Detail_Description.layer.shadowColor = UIColor.black.cgColor // Shadow color
        
       
         
         //Shadow's vertical offset
        txt_Detail_Description.layer.shadowOffset = CGSize(width: 0, height: 2)
    
        txt_Detail_Description.layer.shadowOpacity = 0.2 // Soft shadow opacity
        txt_Detail_Description.layer.shadowRadius = 5 // Soft blur radius for shadow
       
         */
        
       

        /////////////////////////////////// BOTTOM TEXT VIEW
        // Set background color for chat bubble effect
        //txt_Detail_Response.backgroundColor = UIColor.systemBlue// Set blue background for chat bubble
    
        // Set text color for contrast
        //txt_Detail_Response.textColor = UIColor.label // Black text for readability
        
        // Apply rounded corners for the bubble effect
        txt_Detail_Response.layer.cornerRadius = 20
        txt_Detail_Response.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        /*
        //txt_Detail_Response.layer.masksToBounds = true // Ensures the text is clipped within the bubble
        // Add a subtle shadow to create depth, making the bubble stand out
        txt_Detail_Response.layer.shadowColor = UIColor.black.cgColor // Shadow color
        
        //Shadow's vertical offset
        txt_Detail_Response.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        txt_Detail_Response.layer.shadowOpacity = 0.2 // Soft shadow opacity
        txt_Detail_Response.layer.shadowRadius = 5 // Soft blur radius for shadow
        */
        
    
        
        view_BackgroundResponse.layer.cornerRadius = 20
        
        ///////////FACTS VIEW
        txt_Facts.layer.cornerRadius = 20
        txt_Facts.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        txt_Facts.isScrollEnabled = false
        txt_Facts.text = current_Scenario.content
        txt_Facts.sizeToFit()
        /*txt_Facts.layer.masksToBounds = false
        txt_Facts.layer.shadowColor = UIColor.red.cgColor
        txt_Facts.layer.shadowOffset = CGSize(width: 0, height: 2)
        txt_Facts.layer.shadowOpacity = 0.2
        txt_Facts.layer.shadowRadius = 5*/

    }
    
    override func viewDidAppear(_ animated: Bool) {
        lbl_Other_Response.isHidden = true
        txt_Facts.isHidden = true
    }
    
    @IBAction func View_Tapped(_ sender: UITapGestureRecognizer) {
        txt_Detail_Response.resignFirstResponder()
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        lbl_Other_Response.isHidden = false
        txt_Facts.isHidden = false
        scrollView.isScrollEnabled = true
    }
}
