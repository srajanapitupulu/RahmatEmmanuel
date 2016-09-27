//
//  MainCollectionViewCell.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/14/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var lblTitle:UILabel!
  @IBOutlet weak var lblDescription:UILabel!
  
  @IBOutlet weak var imgBackground:UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    self.lblTitle.font = UIFont(name: "ProximaNova-Bold", size: 16)
    self.lblDescription.font = UIFont(name: "ProximaNova-Regular", size: 14)
  }
  
  func setContentData(withData homeData:Home) {
    self.lblTitle.text = homeData.TITLE
    self.lblDescription.text = homeData.DESCRIPTION
    self.tag = Int(homeData.ID)!
  }
  
  func setCellBackgroundImage(withImageFromURL url:String){
    if let url = NSURL(string: url) {
      if let data = NSData(contentsOfURL: url) {
        self.imgBackground.image = UIImage(data: data)
      }
    }
  }
}
