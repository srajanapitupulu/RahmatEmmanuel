//
//  Utils.swift
//  Coencept_RE
//
//  Created by Samuel Napitupulu on 6/15/16.
//  Copyright © 2016 Samuel Napitupulu. All rights reserved.
//

import UIKit

class Utils: NSObject {
  static func getViewFromNib(fromNib nibName:String) -> UIView? {
    let nib: UINib
    
    nib = UINib(nibName: String(self.classForCoder), bundle: NSBundle(forClass: self.classForCoder()))
    
    let obj   = nib.instantiateWithOwner(self, options: nil)
    
    for vw in obj {
      if let vw = vw as? UIView {
//        if intTag == -1 {
//          vw.frame = bounds
          return vw
//        } else {
//          if vw.tag == intTag {
//            vw.frame = bounds
//            
//            return vw
//          }
//        }
      }
    }
    
    return nil
//    return NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[0] as? UIView
  }
}
