//
//  ViewController.swift
//  GuideDemo
//
//  Created by doriswu on 2016/8/24.
//  Copyright © 2016年 doriswu. All rights reserved.
//  Source Code Reference From: http://www.jianshu.com/p/88f48900a5b2 ios制作引导页和广告栏


import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var guideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var goButton: UIButton!
    let width = UIScreen.mainScreen().bounds.width
    let height = UIScreen.mainScreen().bounds.height
    let pageCount: Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guideScrollView.delegate = self
        setGuidePages()
        addButton()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setGuidePages() {
        // Setting scrollview content size
        guideScrollView.contentSize = CGSizeMake(width * CGFloat(pageCount), height)
        
        // Adding pictures to guide page in scrollview
        for i in 1...pageCount {
            let imageView = UIImageView(frame: CGRectMake(width * CGFloat(i - 1), 0, width, height))
            imageView.image = UIImage(named: "Guide\(i)")
            guideScrollView.addSubview(imageView)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // Get the currently displayed page
        let currentPage = Int(scrollView.contentOffset.x / width)
        
        if currentPage == pageCount-1 {
        
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.goButton.layer.opacity = 1
            })
        } else {
        
            UIView.animateWithDuration(1.5, animations: { () -> Void in
                self.goButton.layer.opacity = 0
            })
        }
        
        pageControl.currentPage = currentPage
    }
    
    func addButton() {
        
        goButton = UIButton(frame: CGRectMake(width * CGFloat(pageCount-1), height - 100.0, 100, 35))
        goButton.center.x = self.view.center.x + width * CGFloat(pageCount-1)
        goButton.backgroundColor = UIColor.blackColor()
        goButton.setTitle("Start", forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        goButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        goButton.addTarget(self, action: "goMainPage:", forControlEvents: UIControlEvents.TouchUpInside)
        guideScrollView.addSubview(goButton)
    }

    func goMainPage(button: UIButton)  {
        let mainPageVC = storyboard!.instantiateViewControllerWithIdentifier("mainPage")
        self.presentViewController(mainPageVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

