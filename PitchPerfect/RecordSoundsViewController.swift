//
//  RecordSoundsViewController.swift
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
    var variableString = "say"


    @IBAction func recordAudio(sender: AnyObject) {

        configureUI(true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let currentDateTime=NSDate();
        let formatter =  NSDateFormatter();
        formatter.dateFormat =  "ddMMyyyy-HHmmss";
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        //let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! recordedAudioURL = AVAudioRecorder(URL: filePath!, settings: [:])
        recordedAudioURL.delegate=self
        recordedAudioURL.meteringEnabled = true
        recordedAudioURL.prepareToRecord()
        recordedAudioURL.record()
        
        
    }

    @IBAction func stopRecord(sender: AnyObject) {
        configureUI(false)
        recordedAudioURL.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(animated)
         stopButton.enabled=false
    }
    
    
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        //this function is part of the protocal(contract) between the current class and AVAudioRecorderDelegate
        if(flag)
        {
           performSegueWithIdentifier("StopRecording", sender: recordedAudioURL.url)
        }else
        {
            print("stop recording fail")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if (segue.identifier == "StopRecording") {
                let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
                let recordedAudioURL = sender as! NSURL
                playSoundsVC.recordedAudioURL = recordedAudioURL
            }
    }
    
    func configureUI(recording: Bool)
    {
        if(recording)
        {
            recordLabel.text = "Recording in progress..."
            recordButton.enabled=false
            stopButton.enabled=true
        }else
        {
            stopButton.enabled=false
            recordButton.enabled=true
            recordLabel.text = "Tap to Record"

        }
    }
    
}

