//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Cece Soudaly on 8/13/16.
//  Copyright © 2016 CeceMobile. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    var recordedAudioURL:AVAudioRecorder!
    
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
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! recordedAudioURL = AVAudioRecorder(URL: filePath!, settings: [:])
        recordedAudioURL.meteringEnabled = true
        recordedAudioURL.prepareToRecord()
        recordedAudioURL.record()
        
        
    }

    @IBAction func stopRecord(sender: AnyObject) {
        print("Stop Record button has been pressed.")
        recordLabel.text = "Stop Audio..."
        stopButton.enabled=false
        recordButton.enabled=true
        recordLabel.text = "Tap to Record"
        
        recordedAudioURL.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)

        print("Done....")
  
    }
    
    override func viewWillAppear(animated: Bool) {
         stopButton.enabled=false
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        //this function is part of the protocal(contract) between the current class and AVAudioRecorderDelegate
        print("Finish recording...")
        
        if(flag)
        {
            self.performSegueWithIdentifier("StopRecording", sender: recordedAudioURL.url)
        }else
        {
            print("stop recording fail")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //testing 
            if (segue.identifier == "StopRecording") {
                let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
                let recordedAudioURL = sender as! NSURL
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
    }
    
    
    
}

