//
//  TutorialController.swift
//  hackmit
//
//  Created by Kunal Sahni on 14/09/2019.
//  Copyright © 2019 Kunal Sahni. All rights reserved.
//

import Foundation
import UIKit

class TutorialController: UIPageViewController {
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newTutorialPageController(number: "1"),
                self.newTutorialPageController(number: "2"),
                self.newTutorialPageController(number: "3"),
                UIStoryboard(name: "Main", bundle: nil) .
                    instantiateViewController(withIdentifier: "login")
        ]
    }()
    
    private func newTutorialPageController(number: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "tutorial\(number)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if (isAppAlreadyLaunchedOnce() == true){
            orderedViewControllers.removeAll()
            orderedViewControllers.append(UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "login"))
        }
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}
// MARK: UIPageViewControllerDataSource

extension TutorialController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewControllerBefore) else {
        return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewControllerAfter) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

func isAppAlreadyLaunchedOnce()->Bool{
    let defaults = UserDefaults.standard
    if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
        print("App already launched")
        return true
    }else{
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}
