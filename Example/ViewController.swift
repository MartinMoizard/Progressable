//
//  ViewController.swift
//  Example
//
//  Created by Martin MOIZARD-LANVIN on 27/09/2016.
//  Copyright © 2016 Martin Moizard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var progressSearchBar: ProgressSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.progressSearchBar.accessibilityLabel = "progress search bar"
        self.progressSearchBar.progressLineWidth = 2
        self.progressSearchBar.progressColor = UIColor.blue
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func incrementProgress() {
        self.progressSearchBar.setProgress(progress: min(100, self.progressSearchBar.progress + 10), withDuration: 0.25)
    }
}

