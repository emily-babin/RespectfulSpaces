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
    
    @IBOutlet weak var txt_Other_Response_Height: NSLayoutConstraint!
    @IBOutlet weak var lbl_Other_Response: UILabel!
    @IBOutlet weak var txt_Other_Response: UITextView!
    @IBOutlet weak var view_Other_Responses: UIView!
        
    @IBOutlet weak var view_Facts: UIView!
    @IBOutlet weak var txt_Facts_Height: NSLayoutConstraint!
    @IBOutlet weak var txt_Facts: UITextView!
        
    //Variables
    var current_Scenario: Scenarios!
    var cornerRadius:CGFloat = 20
    var paddingInsets:CGFloat = 10

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
        // Apply rounded corners for the bubble effect
        txt_Detail_Description.layer.cornerRadius = cornerRadius
        txt_Detail_Description.textContainerInset = UIEdgeInsets(top: paddingInsets, left: paddingInsets, bottom: 0, right: paddingInsets)
        
        /////////////////////////////////// DETAILS TEXT VIEW
        // Apply rounded corners for the bubble effect
        txt_Detail_Response.layer.cornerRadius = cornerRadius
        //txt_Detail_Response.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        ///////////OTHER RESPONSES VIEW
        view_BackgroundResponse.layer.cornerRadius = cornerRadius
        txt_Other_Response.layer.cornerRadius = cornerRadius
        //txt_Facts.textContainerInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        txt_Other_Response.text = current_Scenario.commonResponse
    
        view_Other_Responses.layer.cornerRadius = cornerRadius
        
        view_Facts.layer.cornerRadius = cornerRadius
        txt_Facts.text = current_Scenario.facts
        //txt_Detail_Description.text = current_Scenario.tags.joined(separator: ", ")
    }
    
    @IBAction func View_Tapped(_ sender: UITapGestureRecognizer) {
        txt_Detail_Response.resignFirstResponder()
    }
    
    @IBAction func btn_Send(_ sender: UIButton) {
        
        view_Other_Responses.isHidden = false
        
        view_Facts.isHidden = false
        
        //scrollview enable now so that user can go back up to look at content again
        scrollView.isScrollEnabled = true
        
        /*let fixedWidth = txt_Other_Response.frame.size.width
        
        //Calculate the new size for the text view based on its content, allowing unlimited height
        
        let newSize = txt_Other_Response.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let newSizeFacts = txt_Facts.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
                
        //greatestfinitemagnitude is used for the dynamic height based on the content
        
        //Update the height constraint of the text view to reflect the new calculated height
        txt_Other_Response_Height.constant = newSize.height
        txt_Facts_Height.constant = newSizeFacts.height*/
        
        DispatchQueue.main.async {
            var paddedFrame = self.view_Facts.frame
            paddedFrame.size.height += 20
            
            self.scrollView.scrollRectToVisible(paddedFrame, animated: true)
        }
    }
}
