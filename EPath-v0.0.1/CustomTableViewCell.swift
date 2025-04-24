//
//  CustomTableViewCell.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-03.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view_background: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var lbl_Tag: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_background.layer.cornerRadius = 20
        
        //this removes the highlight when selecting a row
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        //backgroundColor = .white
   
        //view_background.layer.masksToBounds = true
        //view_background.backgroundColor = .systemGray5
    
        //border
        //view_background.layer.borderColor = UIColor.systemBackground.cgColor
        //view_background.layer.borderWidth = 10
        //view_background.layer.cornerRadius = 20
    }
    
}
