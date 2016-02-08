//
//  ViewController.swift
//  ActionExtensionApp
//
//  Created by Laura Calinoiu on 01/02/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func actionButtonPressed(sender: UIBarButtonItem) {
    let activityVC = UIActivityViewController(activityItems: [textView.text], applicationActivities: nil)
    presentViewController(activityVC, animated: true, completion: nil)
  }

}

