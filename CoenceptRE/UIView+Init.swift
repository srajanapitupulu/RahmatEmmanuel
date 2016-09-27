//
//  UIView+init.swift
//  Coencept_RE
//
//  Created by Samuel Napitupulu on 6/15/16.
//  Copyright © 2016 Samuel Napitupulu. All rights reserved.
//

import UIKit

extension UIView {
  //MARK: Public Function
  func getViewFromNib(bundle bdl: NSBundle? = nil) -> UIView? {
    return getViewFromNib(bundle: bdl, nibName: nil, tag: -1)
  }
  
  func getViewFromNib(bundle bdl: NSBundle? = nil, nibName strNibName: String? = nil, tag intTag: Int) -> UIView? {
    let nib: UINib
    
    if let strNibName = strNibName {
      if let bdl = bdl {
        nib = UINib(nibName: strNibName, bundle: bdl)
      } else {
        nib = UINib(nibName: strNibName, bundle: NSBundle(forClass: self.classForCoder))
      }
    } else {
      if let bdl = bdl {
        nib = UINib(nibName: String(self.classForCoder), bundle: bdl)
      } else {
        nib = UINib(nibName: String(self.classForCoder), bundle: NSBundle(forClass: self.classForCoder))
      }
    }
    
    let obj   = nib.instantiateWithOwner(self, options: nil)
    
    for vw in obj {
      if let vw = vw as? UIView {
        if intTag == -1 {
          vw.frame = bounds
          return vw
        } else {
          if vw.tag == intTag {
            vw.frame = bounds
            
            return vw
          }
        }
      }
    }
    
    return nil
  }
}
