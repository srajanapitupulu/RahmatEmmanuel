//
//  NewsViewController.swift
//  CoenceptRE
//
//  Created by Reebonz on 9/8/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  
  @IBOutlet weak var tblNews:UITableView!
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  @IBOutlet weak var consVwMainLeading: NSLayoutConstraint!
  
  var leftMenuView = LeftMenuViewController()
  
  var sbMain:UIStoryboard!
  
  var newsService: NewsService!
  
  var arrNews:[News] = [News]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sbMain = UIStoryboard.init(name: "Main", bundle: nil)
    
    self.vwHeader.delHeaderView = self
    self.leftMenuView.delLeftMenu = self
    
    self.vwHeader.lblTitle.text = "Latest News"
    
    self.addChildViewController(leftMenuView)
    
    var menuFrame = self.leftMenuView.view.frame
    
    menuFrame.origin.x = 0 - menuFrame.size.width
    menuFrame.origin.y = 0
    menuFrame.size.height = self.view.frame.size.height
    
    self.leftMenuView.view.frame = menuFrame
    
    self.view.addSubview(leftMenuView.view)
    self.view.sendSubviewToBack(leftMenuView.view)
    self.leftMenuView.didMoveToParentViewController(self)
    
    let nibNewsViewCell = UINib(nibName: String(NewsTableViewCell.classForCoder()), bundle: nil)
    self.tblNews.registerNib(nibNewsViewCell, forCellReuseIdentifier: String(NewsTableViewCell.classForCoder()))
    self.tblNews.separatorStyle = .None
    
    self.newsService = NewsService(delNewsService: self)
    self.newsService.getNewsData()
    
    self.loadingView.hidden = false
    self.loadingView.startAnimating()
    self.tblNews.hidden = true
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.navigationController?.navigationBarHidden = true
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


extension NewsViewController:DelegateNewsService {
  func newsServiceResponse(newsData data: [News]) {
    self.arrNews = data
    self.tblNews.reloadData()
    
    self.loadingView.hidden = true
    self.loadingView.stopAnimating()
    self.tblNews.hidden = false
  }
}


extension NewsViewController:UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var detailVC = DetailViewController()
    detailVC = sbMain.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
    detailVC.detailType = "DETAIL_NEWS"
    detailVC.newsData = self.arrNews[indexPath.row]
    
    if let navController = self.navigationController {
      navController.pushViewController(detailVC, animated: true)
    }
  }
}

extension NewsViewController:UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.arrNews.count
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return 180.0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let viewCell = tableView.dequeueReusableCellWithIdentifier(String(NewsTableViewCell.classForCoder()), forIndexPath: indexPath) as! NewsTableViewCell
    
    let newsData = self.arrNews[indexPath.row]
    
    viewCell.setContentDataForNews(withData: newsData)
    viewCell.setCellBackgroundImage(withImageFromURL: newsData.imageURL)
    
    return viewCell
  }
}


extension NewsViewController:DelegateLeftMenu {
  func doGoToHome(){
    self.dismissLeftMenu()
    var homeVC = ViewController()
    homeVC = sbMain.instantiateViewControllerWithIdentifier("MainViewController") as! ViewController
//    homeVC.modalPresentationStyle = .None
//    homeVC.modalTransitionStyle = .FlipHorizontal
    self.presentViewController(homeVC, animated: true, completion: nil)
  }
  
  
  
  func doGoToSchedule(){
    self.dismissLeftMenu()
    var scheduleVC = ScheduleViewController()
    scheduleVC = sbMain.instantiateViewControllerWithIdentifier("ScheduleViewController") as! ScheduleViewController
    
    let navController = UINavigationController.init(rootViewController: scheduleVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  func doGoToNews(){
    self.dismissLeftMenu()
  }
  
  func doGoToVideo(){
    self.dismissLeftMenu()
    var videoVC = VideosViewController()
    videoVC = sbMain.instantiateViewControllerWithIdentifier("VideosViewController") as! VideosViewController
    
    let navController = UINavigationController.init(rootViewController: videoVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  func doGoToCorner(){
    self.dismissLeftMenu()
    var cornerVC = PSCornerViewController()
    cornerVC = sbMain.instantiateViewControllerWithIdentifier("PSCornerViewController") as! PSCornerViewController
    
    let navController = UINavigationController.init(rootViewController: cornerVC)
    self.presentViewController(navController, animated: true, completion: nil)
  }
  
  // BELOW HERE IS FOR WEBVIEW
  
  func doGoToAbout(){
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_ABOUT
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToPassion() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_PASSION
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToPassionLocation() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_PASSION_LOCATION
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToJoin() {
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_NEXT_STEP
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVisionPartners() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_VISION_PARTNERS
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToInsideOut() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_INSIDE_OUT
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToBaptism() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_BAPTISM
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToRebic() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_REBIC
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToVolunteers() {
    self.dismissLeftMenu()
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_VOLUNTEERS
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
  
  func doGoToGive() {
    var aboutVC = AboutViewController()
    aboutVC = sbMain.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
    aboutVC.intWebViewType = Constants.IDX_MENU_GIVE
    self.presentViewController(aboutVC, animated: true, completion: nil)
  }
}

extension NewsViewController:DelegateHeaderView {
  func doOpenLeftMenu() {
    if self.leftMenuView.isLeftMenuShown {
      self.dismissLeftMenu()
    }
    else {
      self.showLeftMenu()
    }
  }
}
