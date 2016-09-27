//
//  ScheduleTableViewCell.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/9/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

  @IBOutlet weak var lblTitle:UILabel!
  @IBOutlet weak var lblRoom:UILabel!
  @IBOutlet weak var lblAddress:UILabel!
  @IBOutlet weak var lblMainSchedule:UILabel!
  @IBOutlet weak var lblKidsSchedule:UILabel!
  
  @IBOutlet weak var btnDirection:UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.btnDirection.layer.borderColor = UIColor.whiteColor().CGColor
    self.btnDirection.layer.borderWidth = 1.0
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
