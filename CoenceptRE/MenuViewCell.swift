//
//  MenuViewCell.swift
//  Coencept_RE
//
//  Created by Samuel Napitupulu on 6/15/16.
//  Copyright © 2016 Samuel Napitupulu. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
  
  @IBOutlet weak var lblMenuTitle:UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.lblMenuTitle.font = UIFont(name: "ProximaNova-Light", size: 16)
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
