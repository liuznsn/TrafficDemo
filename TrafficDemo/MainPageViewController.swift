//
//  MainPageViewController.swift
//  TrafficDemo
//
//  Created by Leo on 2016/12/7.
//  Copyright © 2016年 Leo. All rights reserved.
//

import Foundation
import UIKit

class MainPageViewController: UIViewController {

    var pageViewController:UIPageViewController!
    var viewControllers:[UIViewController]?
    var containerView: UIView!
    var nextIndex: Int = 0
    var selectedIndex: Int = 0

    var tabMenuView : PagerTabMenuView = PagerTabMenuView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
        setupViewControllers()
        
        for view in pageViewController.view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupPageViewController() {
        containerView = UIView(frame: UIScreen.mainScreen().bounds)
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController.view.frame = containerView.bounds
        pageViewController.dataSource = self
        pageViewController.delegate = self
        addChildViewController(pageViewController)
        containerView.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)

        containerView.addSubview(pageViewController.view)
        containerView.addSubview(tabMenuView)
        self.view = containerView
      
        if #available(iOS 9.0, *) {
            tabMenuView.translatesAutoresizingMaskIntoConstraints = false
            tabMenuView.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
            tabMenuView.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
            tabMenuView.bottomAnchor.constraintEqualToAnchor(containerView.topAnchor, constant: 100).active = true
            tabMenuView.topAnchor.constraintEqualToAnchor(containerView.topAnchor).active = true
            
            
            pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
            pageViewController.view.leftAnchor.constraintEqualToAnchor(containerView.leftAnchor).active = true
            pageViewController.view.rightAnchor.constraintEqualToAnchor(containerView.rightAnchor).active = true
            pageViewController.view.topAnchor.constraintEqualToAnchor(tabMenuView.bottomAnchor).active = true
            pageViewController.view.bottomAnchor.constraintEqualToAnchor(containerView.bottomAnchor).active = true
            
            self.view.layoutIfNeeded()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setupViewControllers() {
        if let viewControllers = viewControllers {
            for viewController in viewControllers.reverse() {
                pageViewController.setViewControllers([viewController], direction: .Reverse, animated: false, completion: nil)
            }
         }
    }
    
    func selectViewController(atIndex index: Int, animated: Bool) {
        if let viewControllers = viewControllers {
            let oldIndex = selectedIndex
            selectedIndex = index
            let direction: UIPageViewControllerNavigationDirection = (oldIndex < selectedIndex) ? .Forward : .Reverse
            if index >= 0 && index < viewControllers.count {
                let viewController = viewControllers[index]
                pageViewController.setViewControllers([viewController], direction: direction, animated: animated, completion: nil)
            }
        }
    }

}

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index = indexOfViewController(viewController) {
            if index > 0 {
                return viewControllers?[index-1]
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index = indexOfViewController(viewController) {
            if let viewControllers = viewControllers, index < viewControllers.count-1 {
                return viewControllers[index+1]
            }
        }
        return nil
    }

    func indexOfViewController(viewController: UIViewController)-> Int? {
        if let viewControllers = viewControllers {
            for i in 0..<viewControllers.count {
                let vc = viewControllers[i]
                if vc == viewController {
                    return i
                }
            }
        }
        return nil
    }
    
}

extension MainPageViewController:UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
                   if let currentVc = pageViewController.viewControllers?.first {
                        if let index = indexOfViewController(currentVc) {
                            self.selectedIndex = index
                            print("self.selectedIndex:\(self.selectedIndex)")
                }
            }
        }
    }
}

extension MainPageViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if selectedIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if selectedIndex == (viewControllers?.count)! - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if selectedIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if selectedIndex == (viewControllers?.count)! - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }

}

