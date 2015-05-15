//
//  TitleActivityViewController.swift
//  TitleActivityViewController
//
//  Created by Jonny on 15/5/14.
//  Copyright (c) 2015 Jonny. All rights reserved.
//

import UIKit


/**
*  System provided share sheet with custom title.
*/
class TitleActivityViewController: UIActivityViewController {
    
    // MARK: - Public
    
    /**
    :param: title         The title you want to show alongside the share sheet.
    :param: font          default: UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    :param: numberOfLines default: 0 (self-adaptive)
    :param: textAlignment default: NSTextAlignment.Center
    */
    func setTitle(title: String?, font: UIFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote), numberOfLines: Int = 0, textAlignment: NSTextAlignment = .Center) {
        self.title = title
        titleFont = font
        numberOfTitleLines = numberOfLines
        titleAlignment = textAlignment
        
        titleView?.setTitle(title, font: titleFont, numberOfLines: numberOfTitleLines, textAlignment: titleAlignment)
    }
    
    override var title: String? {
        get {
            return super.title
        }
        set {
            super.title = newValue
            
            if isViewLoaded() {
                if count(title ?? "") > 0 && titleView == nil {
                    showTitleViewAnimate(true)
                } else if count(title ?? "") == 0 && titleView != nil {
                    self.hideTitleViewAnimate(true)
                } else {
                    titleView?.title = title
                    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: {
                        self.view.window?.layoutIfNeeded()
                        }) { success in }
                }
            }
        }
    }
    
    
    // MARK: - Private
    
    private var titleFont = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    private var numberOfTitleLines = 0
    private var titleAlignment: NSTextAlignment = .Center
    
    private var titleView: ActivityViewControllerTitleView? {
        didSet {
            titleView?.setTitle(title, font: titleFont, numberOfLines: numberOfTitleLines, textAlignment: titleAlignment)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if count(title ?? "") > 0 && titleView == nil {
            showTitleViewAnimate(animated)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if animated {
            UIView.animateWithDuration(CATransaction.animationDuration(), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: {
                self.titleView?.alpha = 0
                }) { success in }
        }
    }
    
    private func showTitleViewAnimate(animated: Bool) {
        var transitionView = view.superview
        var popoverView: UIView?
        
        while transitionView?.superview != nil && !(transitionView?.superview is UIWindow) {
            if popoverPresentationController != nil {
                // Find popover view.
                if NSStringFromClass(transitionView?.classForCoder) != nil {
                    popoverView = transitionView
                }
            }
            transitionView = transitionView?.superview
        }
        
        var containerView: UIView?
        
        if popoverView != nil {
            containerView = popoverView
        } else {
            // For parallax, it must be embedded at least this deep.
            containerView = (view.subviews.first as? UIView)?.subviews.last as? UIView
        }
        
        let contentView = containerView?.subviews.last as! UIView
        
        titleView = ActivityViewControllerTitleView(frame: contentView.bounds)
        
        titleView?.layer.cornerRadius = popoverView == nil ? 4 : 11
        titleView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        containerView?.addSubview(titleView!)
        
        let viewDict = ["titleView": titleView!, "contentView": contentView]
        
        let horizontalCon = NSLayoutConstraint.constraintsWithVisualFormat("|[titleView]|", options: nil, metrics: nil, views: viewDict)
        let verticalCon: [AnyObject]
        
        if popoverPresentationController != nil && popoverPresentationController!.arrowDirection == .Up {
            verticalCon = NSLayoutConstraint.constraintsWithVisualFormat("V:[contentView]-[titleView]", options: nil, metrics: nil, views: viewDict)
        } else {
            verticalCon = NSLayoutConstraint.constraintsWithVisualFormat("V:[titleView]-[contentView]", options: nil, metrics: nil, views: viewDict)
        }
        
        containerView?.addConstraints(horizontalCon + verticalCon)
        
        
        let con = NSLayoutConstraint(item: titleView!, attribute: .Width, relatedBy: .Equal, toItem: contentView, attribute: .Width, multiplier: 1, constant: 0)
        let con1 = NSLayoutConstraint(item: titleView!, attribute: .Top, relatedBy: .GreaterThanOrEqual, toItem: transitionView!, attribute: .Top, multiplier: 1, constant: 20)
        let con2 = NSLayoutConstraint(item: titleView!, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: transitionView!, attribute: .Bottom, multiplier: 1, constant: 20)
        
        transitionView?.addConstraints([con, con1, con2])
        
        titleView?.alpha = 0
        
        if animated {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: {
                self.view.window?.layoutIfNeeded()
                self.titleView?.removeAllAnimations()
                self.titleView?.alpha = 1
                }) { success in }
        } else {
            titleView?.alpha = 1
        }
    }
    
    private func hideTitleViewAnimate(animated: Bool) {
        titleView?.removeFromSuperview()
        titleView = nil
        
        if animated {
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: nil, animations: {
                self.view.window?.layoutIfNeeded()
                }) { success in }
        }
    }
}


class ActivityViewControllerTitleView: UIView {
    
    func setTitle(title: String?, font: UIFont, numberOfLines: Int, textAlignment: NSTextAlignment) {
        if let label = label {
            label.text = title
            label.font = font
            label.numberOfLines = numberOfLines
            label.textAlignment = textAlignment
        }
    }
    
    private var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight))
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(blurView)
        
        let label = UILabel()
        label.textColor = UIColor(white: 0.4, alpha: 1)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        addSubview(label)
        
        let viewDict = ["blurView": blurView, "label": label]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|[blurView]|", options: nil, metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[blurView]|", options: nil, metrics: nil, views: viewDict))
        
        let labelHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("|-14-[label]-14-|", options: nil, metrics: nil, views: viewDict)
        
        let labelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-8-[label]-8-|", options: nil, metrics: nil, views: viewDict)
        
        addConstraints(labelHorizontalConstraints)
        addConstraints(labelVerticalConstraints)
        
        self.label = label
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var title: String? {
        get {
            return label?.text
        }
        set {
            label?.text = newValue
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        var size = label!.intrinsicContentSize()
        size.width += 2 * 10
        size.height += 2 * 10
        return size
    }
}


extension UIView {
    
    func removeAllAnimations() {
        layer.removeAllAnimations()
        for subview in subviews {
            subview.removeAllAnimations()
        }
    }
}