//
//  CustomToolboxTableViewCell.swift
//  EPath-v0.0.1
//
//  Created by Carlos Pillas on 2025-03-26.
//

import UIKit

class CustomToolBoxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view_background_ToolBox: UIView!
    @IBOutlet weak var iconImageViewToolBox: UIImageView!
    @IBOutlet weak var lbl_Title_Toolbox: UILabel!
    @IBOutlet weak var lbl_Tag_Toolbox: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = .white

        view_background_ToolBox.layer.masksToBounds = true
        view_background_ToolBox.backgroundColor = .systemGray5
    
        //border
        view_background_ToolBox.layer.borderColor = UIColor.systemBackground.cgColor
        view_background_ToolBox.layer.borderWidth = 10
        
        view_background_ToolBox.layer.cornerRadius = 20
        
    }
}
