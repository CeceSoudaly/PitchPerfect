//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Cece Soudaly on 8/19/16.
//  Copyright © 2016 CeceMobile. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: NSURL!

    @IBOutlet weak var SnailButton: UIButton!
    @IBOutlet weak var RabbitButton: UIButton!
    @IBOutlet weak var ChipmunkButton: UIButton!
    @IBOutlet weak var DarthVaderButton: UIButton!
    @IBOutlet weak var ParrotButton: UIButton!
    @IBOutlet weak var ReverbButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    
    var recordAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var recordedAudio: NSURL!
    
    enum ButtonType: Int{case Slow=0, Fast, Chipmunk, Vader, Echo, Reverb}
    
    @IBAction func playSoundsforButtons(sender: UIButton)
    {
        
        switch(ButtonType(rawValue: sender.tag)!){
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
        
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject)
    {
        stopAudio()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PlaySoundsViewController loaded")
        setupAudio()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        SnailButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        RabbitButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        ChipmunkButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        DarthVaderButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        ParrotButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        ReverbButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        
        configureUI(.NotPlaying)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   
    

}
