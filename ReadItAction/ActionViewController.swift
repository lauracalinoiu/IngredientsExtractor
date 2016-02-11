//
//  ActionViewController.swift
//  ReadItAction
//
//  Created by Laura Calinoiu on 03/02/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class ActionViewController: UIPageViewController {
  
  @IBOutlet weak var textView: UITextView!
  
  private lazy var orderedViewControllers: [UIViewController] = {
    return [self.newRecipePartViewController("IngredientsController"), self.newRecipePartViewController("StepsController")]
  }()
  
  private func newRecipePartViewController(storyboardId: String) -> UIViewController{
    return UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewControllerWithIdentifier(storyboardId)
  }
  
  override func viewDidLoad(){
    super.viewDidLoad()
    
    dataSource = self
    
    if let firstViewController = orderedViewControllers.first {
      setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
    }
  }
}

extension ActionViewController: UIPageViewControllerDataSource{
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    return orderedViewControllers[(orderedViewControllers.indexOf(viewController)!+1)%2]
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    return orderedViewControllers[(orderedViewControllers.indexOf(viewController)!+1)%2]
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return orderedViewControllers.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    guard let firstViewController = viewControllers?.first,
      firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
        return 0
    }
    
    return firstViewControllerIndex
  }
}
