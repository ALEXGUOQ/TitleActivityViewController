//
//  ViewController.swift
//  TitleActivityViewController
//
//  Created by Jonny on 15/5/15.
//  Copyright (c) 2015 Jonny. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction private func tapShareButton(sender: UIBarButtonItem) {
        
        let title = "Title"
        
        let tavc = TitleActivityViewController(activityItems: [title], applicationActivities: nil)
        
        // option 1
        tavc.title = title
        
        // option 2
        // tavc.setTitle("Title")
        
        // option 3
        // tavc.setTitle("Title", font: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline), numberOfLines: 3, textAlignment: NSTextAlignment.Left)
        
        tavc.popoverPresentationController?.barButtonItem = sender
        
        presentViewController(tavc, animated: true, completion: nil)
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            NSThread.sleepForTimeInterval(2)
            dispatch_async(dispatch_get_main_queue()) {
                tavc.setTitle("Created by Jonny on 15/5/15.\nCopyright (c) 2015 Jonny. All rights reserved.", textAlignment: NSTextAlignment.Left, font: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline))
            }
            NSThread.sleepForTimeInterval(1.5)
            dispatch_async(dispatch_get_main_queue()) {
                tavc.title = "Inspired by an0/WLActivityViewController"
            }
            NSThread.sleepForTimeInterval(1.5)
            dispatch_async(dispatch_get_main_queue()) {
                tavc.title = "Weibo: 匡俊宇Jonny"
            }
            NSThread.sleepForTimeInterval(1.5)
            dispatch_async(dispatch_get_main_queue()) {
                tavc.setTitle(title, textAlignment: NSTextAlignment.Center, numberOfLines: 0, font: UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote))
            }
        }
    }
}

