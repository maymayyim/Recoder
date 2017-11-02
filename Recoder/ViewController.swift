//
//  ViewController.swift
//  Recoder
//
//  Created by 6272 on 11/2/2560 BE.
//  Copyright © 2560 6272. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer?
    var audioRecord: AVAudioRecorder?

    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var recordBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fileManager = FileManager()
        let documentsFolderUrl = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let fileURL = documentsFolderUrl?.appendingPathComponent("Recording.m4a")
        
        let audioSetting = [AVFormatIDKey : kAudioFormatMPEG4AAC as NSNumber, AVSampleRateKey : 16000.0 as NSNumber, AVNumberOfChannelsKey : 1 as NSNumber, AVEncoderAudioQualityKey : AVAudioQuality.low.rawValue as NSNumber]
        
        
        var error : NSError?
        do {
            audioRecord = try AVAudioRecorder(url: fileURL!, settings: audioSetting)
        } catch var error1 as NSError {
            error = error1
            audioRecord = nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordMethod(_ sender: Any) {
        if(audioRecord!.isRecording){
            audioRecord!.stop()
            recordBtn.setTitle("Record", for: UIControlState.normal)
            playBtn.isEnabled = true
        }else{
            audioRecord!.record()
            recordBtn.setTitle("Stop", for: UIControlState.normal)
            playBtn.isEnabled = false
        }
        
    }
    @IBAction func playMethod(_ sender: Any) {
        if(!(audioRecord?.isRecording)!){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: (audioRecord?.url)!)
            }catch let error as NSError{
                audioPlayer = nil
            }
            audioPlayer?.play()
        }
        
    }
    

}

