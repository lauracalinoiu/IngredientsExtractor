//
//  ActionViewController.swift
//  ReadItAction
//
//  Created by Laura Calinoiu on 03/02/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ActionViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad(){
    super.viewDidLoad()
  
    for item: AnyObject in self.extensionContext!.inputItems {
      let inputItem = item as! NSExtensionItem
      for provider: AnyObject in inputItem.attachments! {
        let itemProvider = provider as! NSItemProvider
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
          itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (dict, error) in
            
            let itemDictionary = dict as! NSDictionary
            let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
            print(javaScriptValues)
          })
          break
        }
      }
    }
  }
  
  @IBAction func done() {
    self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
  }
  
}
