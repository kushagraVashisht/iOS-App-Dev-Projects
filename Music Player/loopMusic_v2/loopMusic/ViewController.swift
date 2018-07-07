
//
//  ViewController.swift
//  loopMusic
//
//  Created by ritu sharma on 17/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class ViewController: UIViewController, MPMediaPickerControllerDelegate{
    
    var playing = true
    var loopData = [TimeInterval]()
    
    @IBOutlet weak var loopLeft: UILabel!
    @IBOutlet weak var loopRight: UILabel!
    
    
    var loopLeftChanging = false
    var loopRightChanging = false
    
    
    var trackElapsed:TimeInterval!
    var time1Elapsed:TimeInterval!
    
    var isPlayingLoopedSong:Bool = false
    
    @IBAction func loopLeftBackwards(_ sender: UIButton) {
        
    }
    
    @IBAction func loopLeftForwards(_ sender: UIButton) {
    }
    @IBAction func loopRightBackwards(_ sender: UIButton) {
    }
    @IBAction func loopRightForwards(_ sender: UIButton) {
    }
    @IBOutlet var sliderTime: UISlider!
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBOutlet weak var nameOfTheSong: UILabel!
    
    
    @IBAction func play(_ sender: UIButton)
    {
        if playing
        {
            sender.setImage(UIImage(named:"ic_action_pausesong.png"), for: .normal)
            mp.play()
            playing = false
            
        }
        else
        {
            sender.setImage(UIImage(named:"ic_action_playsong.png"), for: .normal)
            mp.pause()
            playing = true
            
        }
    }
    
    
    @IBAction func stop(_ sender: Any)
    {
        mp.currentPlaybackTime = trackElapsed
        mp.skipToBeginning()
        mp.pause()
        loopData = []
    }
    
    
    var mediapicker1 : MPMediaPickerController!
    let mp = MPMusicPlayerController.systemMusicPlayer()
    var timer = Timer()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
        
        mp.beginGeneratingPlaybackNotifications()
        
        NotificationCenter.default.addObserver(self, selector:#selector(ViewController.updateNowPlayingInfo), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        
        mp.prepareToPlay()
        
        let mediaPicker: MPMediaPickerController = MPMediaPickerController.self(mediaTypes:MPMediaType.music)
        mediaPicker.allowsPickingMultipleItems = false
        mediapicker1 = mediaPicker
        mediaPicker.delegate = self
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func songPick(_ sender: Any)
    {
        let myMediaPickerVC = MPMediaPickerController(mediaTypes: MPMediaType.music)
        myMediaPickerVC.allowsPickingMultipleItems = false
        //myMediaPickerVC.popoverPresentationController?.sourceView = sender as! UIButton
        myMediaPickerVC.delegate = self
        self.present(myMediaPickerVC, animated: true, completion: nil)
    }
    
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection)
    {
        mp.setQueue(with: mediaItemCollection)
        mediaPicker.dismiss(animated: true, completion: nil)
        mp.play()
    }
    
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController)
    {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    
    //Function to pull track info and update labels
    func timerFired(_:AnyObject)
    {
        
        //Ensure the track exists before pulling the info
        if let currentTrack = MPMusicPlayerController.systemMusicPlayer().nowPlayingItem
        {
            let trackDuration = currentTrack.playbackDuration
            //pull artist and title for current track and show in labelTitle
            let trackName = currentTrack.title!
            
            if let artist = currentTrack.artist
            {
                nameOfTheSong.text = "\(artist) - \(trackName)"
            }
            else
            {
                nameOfTheSong.text = "\(trackName)"
            }
            
            
            
            //Find elapsed time by pulling currentPlaybackTime
            
            //currentPlayBacktime points to the playhead of the scrollbar
            trackElapsed = mp.currentPlaybackTime
            //time1Elapsed = mp.currentPlaybackTime
            
            // avoid crash
            if trackElapsed.isNaN
            {
                return
            }
            //Repeat same steps to display the elapsed time as we did with the duration
            let trackElapsedMinutes = Int(trackElapsed / 60)
            
            let trackElapsedSeconds = Int(trackElapsed.truncatingRemainder(dividingBy: 60))
            
            if trackElapsedSeconds < 10
            {
                timeElapsed.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds)"
            }
            else
            {
                timeElapsed.text = "\(trackElapsedMinutes):\(trackElapsedSeconds)"
            }
            
            let trackElapsedMilliseconds = Int(trackElapsed.truncatingRemainder(dividingBy: 1) * 1000)
            
            //Find remaining time by subtraction the elapsed time from the duration
            let trackRemaining = Int(trackDuration) - Int(trackElapsed)
            
            //Repeat same steps to display remaining time
            let trackRemainingMinutes = trackRemaining / 60
            
            let trackRemainingSeconds = trackRemaining % 60
            
            if trackRemainingSeconds < 10
            {
                timeRemaining.text = "\(trackRemainingMinutes):0\(trackRemainingSeconds)"
            }
            else
            {
                timeRemaining.text = "\(trackRemainingMinutes):\(trackRemainingSeconds)"
            }
            
            if trackElapsedSeconds < 10
            {
                //add a 0 if the number of seconds is less than 10
                timeDuration.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
            }
            else
            {
                //if more than 10, display as is
                timeDuration.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
            }
            sliderTime.minimumValue = 0;
            sliderTime.value = Float(mp.currentPlaybackTime);
            sliderTime.maximumValue = Float(trackDuration)
            
            if loopLeftChanging {
                loopLeft.text = timeDuration.text
            }
            
            
            if loopRightChanging {
                loopRight.text = timeDuration.text
                //mp.pause()
                
            }
            if (loopData.count == 2 && !isPlayingLoopedSong)
            {
                //print("Not Empty")
                //mp.skipToBeginning()
                mp.pause()
                mp.currentPlaybackTime = loopData[0]
                //loop()
            } else {
                loop()
            }
        }
    }
    
    
    @IBAction func sliderTimeChanged(_ sender: Any)
    {
        mp.currentPlaybackTime = TimeInterval(sliderTime.value)
    }
    
    
    @IBAction func start(_ sender: UIButton)
    {
        loopLeftChanging = false
        
        print(trackElapsed)
        loopData.append(trackElapsed)
    }
    
    @IBAction func end(_ sender: UIButton)
    {
        loopRightChanging = false
        
        print(trackElapsed)
        loopData.append(trackElapsed)
        timer.invalidate()
    }
    
    func updateNowPlayingInfo()
    {
        
        loopLeftChanging = true
        loopRightChanging = true
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.timerFired(_:)), userInfo: nil, repeats: true)
        self.timer.tolerance = 0.1
    }
    @IBAction func saveLoopedSong(_ sender: UIButton)
    {
        print("LoopData: \(loopData)")
    }
    
    @IBAction func deleteLoopedSong(_ sender: UIButton)
    {
    }
    
    @IBAction func resetLoopedSong(_ sender: UIButton)
    {
        mp.skipToBeginning()
        mp.pause()
        loopLeft.text = timeElapsed.text
        loopRight.text = timeElapsed.text
        isPlayingLoopedSong = false
    }
    
    @IBAction func playLoopedSong(_ sender: UIButton)
    {
        
        isPlayingLoopedSong = true
        
        loop()
    }
    
    func loop()
    {
        
        if loopData.count == 2 {
        if(mp.currentPlaybackTime < loopData[1])
        {
            mp.play()
        }
        else if(mp.currentPlaybackTime >= loopData[1])
        {
            mp.currentPlaybackTime = loopData[0]
            print("NA")
        }
        }
    }
}
