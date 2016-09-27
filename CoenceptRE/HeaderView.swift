//
//  HeaderView.swift
//  Coencept_RE
//
//  Created by Samuel Napitupulu on 6/15/16.
//  Copyright © 2016 Samuel Napitupulu. All rights reserved.
//

import UIKit

protocol DelegateHeaderView: NSObjectProtocol {
  func doOpenLeftMenu()
//  func doBack()
//  func doShare()
}

class HeaderView: UIView {
  
  @IBOutlet weak var btnNavLeft:UIButton!
  @IBOutlet weak var btnNavRight:UIButton!
  @IBOutlet weak var lblTitle:UILabel!
  
  var delHeaderView: AnyObject!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    
    if let theView = self.getViewFromNib() {
      self.addSubview(theView)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.lblTitle.font = UIFont(name: "ProximaNova-Bold", size: 17)
    self.btnNavLeft.addTarget(self, action: #selector(self.actionLeftButtonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    self.btnNavRight.hidden = true
  }
  
  func setHeader(withTitle title:String) {
    self.lblTitle.text = title
    self.btnNavRight.hidden = true
  }
  
  func setHeaderForDetail(withTitle title:String) {
    self.lblTitle.text = title
    
    self.btnNavLeft.setImage(UIImage.init(named: "ic_chevron_left_white"), forState: UIControlState.Normal)
    self.btnNavRight.setImage(UIImage.init(named: "ic_share_white"), forState: UIControlState.Normal)
    self.btnNavRight.hidden = false
  }
  
  func actionLeftButtonClicked(sender: UIButton) {
    (self.delHeaderView as! DelegateHeaderView).doOpenLeftMenu()
  }
  
//  func actionBack(sender: UIButton) {
//    (self.delHeaderView as! DelegateHeaderView).doBack()
//  }
//  
//  func actionShare(sender: UIButton) {
//    (self.delHeaderView as! DelegateHeaderView).doShare()
//  }
}
