//
//  RegisterViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var consVwMainLeading: NSLayoutConstraint!
  
  var leftMenuView = LeftMenuViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.vwHeader.delHeaderView = self
    self.leftMenuView.delLeftMenu = self
    
    self.addChildViewController(leftMenuView)
    
    var menuFrame = self.leftMenuView.view.frame
    
    menuFrame.origin.x = 0 - menuFrame.size.width
    menuFrame.origin.y = 0
    menuFrame.size.height = self.view.frame.size.height
    
    self.leftMenuView.view.frame = menuFrame
    
    self.view.addSubview(leftMenuView.view)
    self.view.sendSubviewToBack(leftMenuView.view)
    self.leftMenuView.didMoveToParentViewController(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func showLeftMenu() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.vwMain.frame
      viewRect.origin.x = 0 + self.leftMenuView.view.frame.size.width
      self.vwMain.frame = viewRect
      self.vwMain.layoutIfNeeded()
      
      var menuFrame = self.leftMenuView.view.frame
      menuFrame.origin.x = 0
      self.leftMenuView.view.frame = menuFrame
      
      }, completion: { (blnFinish) -> Void in
        
        self.leftMenuView.isLeftMenuShown = !self.leftMenuView.isLeftMenuShown
    })
  }
  
  func dismissLeftMenu() {
    UIView.animateWithDuration(0.25, animations: {
      
      var viewRect = self.vwMain.frame
      viewRect.origin.x = 0
      self.vwMain.frame = viewRect
      self.vwMain.layoutIfNeeded()
      
      var menuFrame = self.leftMenuView.view.frame
      menuFrame.origin.x = 0 - menuFrame.size.width
      self.leftMenuView.view.frame = menuFrame
      
      }, completion: { (blnFinish) -> Void in
        
        self.leftMenuView.isLeftMenuShown = !self.leftMenuView.isLeftMenuShown
    })
  }
}

extension RegisterViewController:DelegateLeftMenu {
  func doGoToHome(){
    self.dismissLeftMenu()
  }
  func doGoToAbout(){
    self.dismissLeftMenu()
  }
  func doGoToSchedule(){
    self.dismissLeftMenu()
  }
  func doGoToNews(){
    self.dismissLeftMenu()
  }
  func doGoToVideo(){
    self.dismissLeftMenu()
  }
  func doGoToCorner(){
    self.dismissLeftMenu()
  }
  
  func doGoToGive() {
    self.dismissLeftMenu()
  }
  func doGoToJoin() {
    self.dismissLeftMenu()
  }
  
  
  func doGoToPassion() {
    self.dismissLeftMenu()
  }
  
  func doGoToPassionLocation() {
    self.dismissLeftMenu()
  }
  
  func doGoToVisionPartners() {
    self.dismissLeftMenu()
  }
  
  func doGoToInsideOut() {
    self.dismissLeftMenu()
  }
  
  func doGoToBaptism() {
    self.dismissLeftMenu()
  }
  
  func doGoToRebic() {
    self.dismissLeftMenu()
  }
  
  func doGoToVolunteers() {
    self.dismissLeftMenu()
  }
}

extension RegisterViewController:DelegateHeaderView {
  func doOpenLeftMenu() {
    if self.leftMenuView.isLeftMenuShown {
      self.dismissLeftMenu()
    }
    else {
      self.showLeftMenu()
    }
  }
}
