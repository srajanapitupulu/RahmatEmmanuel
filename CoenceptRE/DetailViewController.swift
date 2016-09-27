//
//  DetailViewController.swift
//  Rahmat Emmanuel
//
//  Created by Reebonz on 9/27/16.
//  Copyright © 2016 srajanapitupulu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var vwHeader:HeaderView!
  @IBOutlet weak var vwMain:UIView!
  
  @IBOutlet weak var lblTitle:UILabel!
  @IBOutlet weak var lblAuthor:UILabel!
  @IBOutlet weak var lblContent:UILabel!
  
  @IBOutlet weak var imgBackground:UIImageView!
  @IBOutlet weak var imgVideoIcon:UIImageView!
  
  @IBOutlet weak var loadingView:UIActivityIndicatorView!
  
  var detailType = String()
  
  var newsData = News()
  var videoData = Video()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadingView.hidden = true
    // Do any additional setup after loading the view.
    
    self.vwHeader.delHeaderView = self
    self.vwHeader.setHeaderForDetail(withTitle: "DETAIL")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(true)
    
    self.navigationController?.navigationBarHidden = true
    
    if detailType.caseInsensitiveCompare("DETAIL_NEWS") == .OrderedSame {
      self.lblTitle.text = newsData.title
      self.lblAuthor.text = "by : \(newsData.author)"
      self.lblContent.text = newsData.content
      
      if let url = NSURL(string: newsData.imageURL) {
        if let data = NSData(contentsOfURL: url) {
          self.imgBackground.image = UIImage(data: data)
        }
      }
      
      self.imgVideoIcon.hidden = true
    }
    else if detailType.caseInsensitiveCompare("DETAIL_VIDEO") == .OrderedSame {
      self.lblTitle.text = videoData.title
      self.lblAuthor.text = "by : \(videoData.author)"
      self.lblContent.text = videoData.content
      
      if let url = NSURL(string: videoData.imageURL) {
        if let data = NSData(contentsOfURL: url) {
          self.imgBackground.image = UIImage(data: data)
        }
      }
      
      let tapVideo: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.openVideoURL))
      self.imgVideoIcon.addGestureRecognizer(tapVideo)
      self.imgVideoIcon.hidden = false
    }
  }
  
  func openVideoURL(){
    if let url = NSURL(string: videoData.videoURL) {
      UIApplication.sharedApplication().openURL(url)
    }
  }
}

extension DetailViewController:DelegateHeaderView {
  func doOpenLeftMenu() {}
}

