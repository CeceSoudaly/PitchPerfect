//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Cece Soudaly on 8/13/16.
//  Copyright © 2016 CeceMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        print("Audio Record button has been pressed.")
        
        recordLabel.text = "Recording in progress..."
        recordButton.enabled=false
        stopButton.enabled=true
        
        
    }

    @IBAction func stopRecord(sender: AnyObject) {
        print("Stop Record button has been pressed.")
        recordLabel.text = "Stop Audio..."
        stopButton.enabled=false
        recordButton.enabled=true
        recordLabel.text = "Tap to Record"
        
    }
    
    override func viewWillAppear(animated: Bool) {
         stopButton.enabled=false
    }
    
}

