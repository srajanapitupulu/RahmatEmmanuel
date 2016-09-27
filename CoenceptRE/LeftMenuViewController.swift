//
//  LeftMenuViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

protocol DelegateLeftMenu: NSObjectProtocol {
  func doGoToHome()
  func doGoToAbout()
  func doGoToSchedule()
  func doGoToNews()
  func doGoToVideo()
  func doGoToCorner()
  func doGoToPassion()
  func doGoToPassionLocation()
  func doGoToJoin()
  func doGoToVisionPartners()
  func doGoToInsideOut()
  func doGoToBaptism()
  func doGoToRebic()
  func doGoToVolunteers()
  func doGoToGive()
}

class LeftMenuViewController: UIViewController {
  
  @IBOutlet weak var tblMenus: UITableView!
  
  var delLeftMenu: AnyObject!
  
  var isLeftMenuShown: Bool = false
  
  let menuUpper = [String](arrayLiteral: "Home", "About", "Schedule", "News", "Video Sermons", "Ps. Joshua's Corner", "Passion", "Passion Location", "RE Next Step", "Vision Partners", "Inside Out", "Baptism", "Rebic", "Volunteers", "Give")
  let menuLower = [String]() //[String](arrayLiteral: "Log In", "Register", "Log Out")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    let nibMenusViewCell = UINib(nibName: String(MenuViewCell.classForCoder()), bundle: nil)
    self.tblMenus.registerNib(nibMenusViewCell, forCellReuseIdentifier: String(MenuViewCell.classForCoder()))
    
    self.tblMenus.separatorStyle = .None
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func setLeftMenu(){
    self.isLeftMenuShown = !self.isLeftMenuShown
  }
  
  func show() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.view.frame
      viewRect.origin.x = 0
      
      self.view.frame = viewRect
      
      self.view.layoutIfNeeded()
      }, completion: { (blnFinish) -> Void in
    })
  }
  
  func dismiss() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.view.frame
      viewRect.origin.x = 0 - viewRect.size.width
      
      self.view.frame = viewRect
      
      self.view.layoutIfNeeded()
      }, completion: { (blnFinish) -> Void in
    })
  }
}

extension LeftMenuViewController:UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    switch indexPath.section {
    case 0:
      switch indexPath.row {
      case 0: // HOME
        (self.delLeftMenu as! DelegateLeftMenu).doGoToHome()
        break
      case 1: // ABOUT
        (self.delLeftMenu as! DelegateLeftMenu).doGoToAbout()
        break
      case 2: // SCHEDULE
        (self.delLeftMenu as! DelegateLeftMenu).doGoToSchedule()
        break
      case 3: // NEWS
        (self.delLeftMenu as! DelegateLeftMenu).doGoToNews()
        break
      case 4: // VIDEO
        (self.delLeftMenu as! DelegateLeftMenu).doGoToVideo()
        break
      case 5: // PS CORNER
        (self.delLeftMenu as! DelegateLeftMenu).doGoToCorner()
        break
      case 6: // PASSION
        (self.delLeftMenu as! DelegateLeftMenu).doGoToPassion()
        break
      case 7: // PASSION LOCATION
        (self.delLeftMenu as! DelegateLeftMenu).doGoToPassionLocation()
        break
      case 8: // NEXT STEP
        (self.delLeftMenu as! DelegateLeftMenu).doGoToJoin()
        break
      case 9: // VISION PARTNERS
        (self.delLeftMenu as! DelegateLeftMenu).doGoToVisionPartners()
        break
      case 10: // INSIDE OUT
        (self.delLeftMenu as! DelegateLeftMenu).doGoToInsideOut()
        break
      case 11: // BAPTISM
        (self.delLeftMenu as! DelegateLeftMenu).doGoToBaptism()
        break
      case 12: // REBIC
        (self.delLeftMenu as! DelegateLeftMenu).doGoToRebic()
        break
      case 13: // VOLUNTEERS
        (self.delLeftMenu as! DelegateLeftMenu).doGoToVolunteers()
        break
      default: // GIVE
        (self.delLeftMenu as! DelegateLeftMenu).doGoToGive()
        break
      }
      break
    default:
      switch indexPath.row {
      case 0: // LOG IN
        break
      case 1: // REGISTER
        break
      default: // LOG OUT
        break
      }
      break
    }
  }
}

extension LeftMenuViewController:UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return self.menuUpper.count
    }
    else {
      return self.menuLower.count
    }
  }
  
  func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 35.0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let menuViewCell = tableView.dequeueReusableCellWithIdentifier(String(MenuViewCell.classForCoder()), forIndexPath: indexPath) as! MenuViewCell
    
    if indexPath.section == 0 {
      menuViewCell.lblMenuTitle.text = String.init(format:"%@", menuUpper[indexPath.row])
    }
    else {
      menuViewCell.lblMenuTitle.text = String.init(format:"%@", menuLower[indexPath.row])
    }
    
    menuViewCell.backgroundColor = UIColor.clearColor()
    menuViewCell.lblMenuTitle.textColor = UIColor.whiteColor()
    
    return menuViewCell
  }
}
