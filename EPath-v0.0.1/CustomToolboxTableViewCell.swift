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

        view_background_ToolBox.layer.cornerRadius = 20
        //this removes the highlight when selecting a row
        self.selectionStyle = UITableViewCell.SelectionStyle.none

    }
}
