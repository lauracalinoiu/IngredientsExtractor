//
//  InstructionsViewController.swift
//  ActionExtensionApp
//
//  Created by Laura Calinoiu on 11/02/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Kanna

class InstructionsViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  
  @IBAction func actionDone(sender: UIBarButtonItem) {
    self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.layer.cornerRadius = 5
    textView.layer.borderColor = UIColor.grayColor().colorWithAlphaComponent(0.5).CGColor
    textView.layer.borderWidth = 0.5
    textView.clipsToBounds = true
  
    getHTMLContent()
  }
  
  func getHTMLContent(){
    for item: AnyObject in self.extensionContext!.inputItems {
      let inputItem = item as! NSExtensionItem
      for provider: AnyObject in inputItem.attachments! {
        let itemProvider = provider as! NSItemProvider
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
          itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (dict, error) in
            
            let itemDictionary = dict as! NSDictionary
            let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
            
            self.extractHTML(javaScriptValues)
          })
          break
        }
      }
    }
  }
  
  func extractHTML(javaScriptValues: NSDictionary) {
    if let doc = Kanna.HTML(html: javaScriptValues["body"] as! String, encoding: NSUTF8StringEncoding) {
      for link in doc.xpath("//*[preceding-sibling::*[contains(.,'Ne trebuie')] and following-sibling::*[contains(., 'Cum se fac')]]") {
        if let unwrappedT = link.text{
          dispatch_async(dispatch_get_main_queue(), {
            self.textView.text.appendContentsOf(unwrappedT+"\n")
          })
        }
      }
    }
  }
}
