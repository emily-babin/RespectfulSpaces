//
//  ToolBoxDetailsViewController.swift
//  EPath-v0.0.1
//
//  Created by Pillas,Carlos Andre on 2025-05-02.
//

import UIKit

class ToolBoxDetailsViewController: UIViewController {

    @IBOutlet weak var txt_Content_Height: NSLayoutConstraint!
    @IBOutlet weak var txt_Content: UITextView!
    
    
    var current_ToolBox: ToolBox!
    var cornerRadius:CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextDetails()
    }
    
    override func viewDidLayoutSubviews() {
        //Dynamically adjust height of the view
        let fixedWidth = txt_Content.frame.size.width
        let newSize = txt_Content.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        txt_Content_Height.constant = newSize.height
        
        view.layoutIfNeeded()
    }
    
    func setupTextDetails() {
        //Parse HTML content into attributed text
        /*if let data = current_ToolBox.content.data(using: .utf8) {
            let options:[NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue]
            
            
            if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                txt_Content.attributedText = attributedString
                txt_Content.font = .systemFont(ofSize: 14)
            } else {
                txt_Content.text = "failed"
            }
        }*/
        
        txt_Content.text = current_ToolBox.content
        //Setup textview styles
        txt_Content.layer.cornerRadius = cornerRadius
        txt_Content.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
    }
}
