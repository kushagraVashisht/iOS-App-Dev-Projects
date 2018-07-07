
//
//  ViewController.swift
//  loopMusic
//
//  Created by Kushagra Vashisht on 17/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import CoreData

struct Song {
    var songName:String!
}

class ViewController: UIViewController, MPMediaPickerControllerDelegate
{
    //CORE DATA VARIABLES START HERE
    
    
    
    
    
    var saveSongsList:[Song] = [Song]()
    
    
    
    
    //NORMAL APP VARIABLES START HERE
    // var loopingSongBackground is for playing the music in the background without changing the seekbar value.
    var loopingSongBackground = false
    
    var isBackgroundPlayerPlaying = false
    
    // var playing is for the play button and the stop button.
    var playing = false
    
    //var playingLoop = false
    
    var loopData = [TimeInterval]()
    
    // var loopLeftChanging is used for checking if the loopLeft label is changing or not and storing the value at the point Start button is pressed.
    var loopLeftChanging = false
    
    // var loopRightChanging is used for checking if the rightLoop label is changing or not and storing the value at the point End button is pressed.
    var loopRightChanging = false
    
    //var isPlayingLoopedSong = false
    
    var trackElapsed:TimeInterval!
    
    // not used atm.
    var time1Elapsed:TimeInterval!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveLoopedSongButton: UIButton!
    @IBOutlet weak var endLoopButton: UIButton!
    @IBOutlet weak var startLoopButton: UIButton!
    @IBOutlet weak var playLoopedbutton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var songPickButton: UIButton!
    @IBOutlet weak var playbutton: UIButton!
    @IBOutlet var sliderTime: UISlider!
    @IBOutlet weak var timeDuration: UILabel!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var timeElapsed: UILabel!
    @IBOutlet weak var nameOfTheSong: UILabel!
    @IBOutlet weak var loopLeft: UILabel!
    @IBOutlet weak var loopRight: UILabel!
    
    @IBAction func loopLeftBackwards(_ sender: UIButton)
    {
        if loopData[0] > 0.0
        {
            secondsToTimeLeftLoop(seconds: loopData[0] - 0.1)
        }
    }
    @IBAction func loopLeftForwards(_ sender: UIButton)
    {
        if loopData[0] > 0.0
        {
            secondsToTimeLeftLoop(seconds: loopData[0] + 0.1)
        }
    }
    @IBAction func loopRightBackwards(_ sender: UIButton)
    {
        if loopData[1] > 0.0
        {
            secondsToTimeRightLoop(seconds: loopData[1] - 0.1)
        }
        
    }
    @IBAction func loopRightForwards(_ sender: UIButton)
    {
        if loopData[1] > 0.0
        {
            secondsToTimeRightLoop(seconds: loopData[1] + 0.1)
        }
        
    }
    @IBAction func play(_ sender: UIButton)
    {
        loopingSongBackground = false
        if(!playing)
        {
            playbutton.setImage(UIImage(named:"ic_action_pausesong.png"), for: .normal)
            mp.play()
            playing = true
            playLoopedbutton.setImage(UIImage(named: "ic_action_playsong.png"), for: .normal)
            loopingSongBackground = false
        }
            
        else
        {
            playbutton.setImage(UIImage(named:"ic_action_playsong.png"), for: .normal)
            mp.pause()
            playing = false
        }
    }
    
    @IBAction func stop(_ sender: Any)
    {
        mp.currentPlaybackTime = trackElapsed
        mp.skipToBeginning()
        mp.pause()
        playbutton.setImage(UIImage(named: "ic_action_playsong.png"), for: .normal)
        playing = false
        
        loopLeftChanging = false
        loopRightChanging = false
    }
    
    
    var mediapicker1 : MPMediaPickerController!
    let mp = MPMusicPlayerController.systemMusicPlayer()
    var timer = Timer()
    
    
    //CORE DATA STUFF HERE
    //    private let persistentContainer = NSPersistentContainer(name: "SongTableViewCell")
    
    
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
        
        //COREDATA STUFF
        
        
        
        
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
        playbutton.setImage(UIImage(named: "ic_action_playsong.png"), for: .normal)
        playing = false
        
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection)
    {
        self.dismiss(animated: true, completion: nil)
        let selectedSongs = mediaItemCollection
        mp.setQueue(with: selectedSongs)
        mp.play()
        mp.pause()
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
            
            if(loopingSongBackground == false)
            {
                sliderTime.minimumValue = 0;
                sliderTime.value = Float(mp.currentPlaybackTime);
                sliderTime.maximumValue = Float(trackDuration)
                trackElapsed = mp.currentPlaybackTime
                time1Elapsed = mp.currentPlaybackTime
                
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
                if(trackElapsedSeconds < 10 && trackElapsedMilliseconds < 10)
                {
                    //add a 0 if the number of seconds is less than 10
                    timeDuration.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
                else if(trackElapsedSeconds > 10 && trackElapsedMilliseconds < 10)
                {
                    //if more than 10, display as is
                    timeDuration.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
                else
                {
                    timeDuration.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
                
            }
                
            else
                // just change the loopLeft.text and loopRight.text
            {
                time1Elapsed = mp.currentPlaybackTime
                
                if time1Elapsed.isNaN
                {
                    return
                }
                //Repeat same steps to display the elapsed time as we did with the duration
                
                let time1ElapsedMinutes = Int(time1Elapsed / 60)
                
                let time1ElapsedSeconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 60))
                
                let time1ElapsedMilliseconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 1) * 1000)
                
                //Find remaining time by subtraction the elapsed time from the duration
                if(time1ElapsedSeconds < 10 && time1ElapsedMilliseconds < 10)
                {
                    //add a 0 if the number of seconds is less than 10
                    loopLeft.text = "\(time1ElapsedMinutes):0\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else if(time1ElapsedSeconds > 10 && time1ElapsedSeconds < 10)
                {
                    //if more than 10, display as is
                    loopLeft.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else
                {
                    loopLeft.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                
                //loop()
            }
            
            if (loopLeftChanging == true)
            {
                time1Elapsed = mp.currentPlaybackTime
                
                if time1Elapsed.isNaN
                {
                    return
                }
                //Repeat same steps to display the elapsed time as we did with the duration
                
                let time1ElapsedMinutes = Int(time1Elapsed / 60)
                
                let time1ElapsedSeconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 60))
                
                let time1ElapsedMilliseconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 1) * 1000)
                
                //Find remaining time by subtraction the elapsed time from the duration
                if(time1ElapsedSeconds < 10 && time1ElapsedMilliseconds < 10)
                {
                    //add a 0 if the number of seconds is less than 10
                    loopLeft.text = "\(time1ElapsedMinutes):0\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else if(time1ElapsedSeconds > 10 && time1ElapsedSeconds < 10)
                {
                    //if more than 10, display as is
                    loopLeft.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else
                {
                    loopLeft.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                
                
            }
            
            if (loopRightChanging == true)
            {
                time1Elapsed = mp.currentPlaybackTime
                
                if time1Elapsed.isNaN
                {
                    return
                }
                //Repeat same steps to display the elapsed time as we did with the duration
                
                let time1ElapsedMinutes = Int(time1Elapsed / 60)
                
                let time1ElapsedSeconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 60))
                
                let time1ElapsedMilliseconds = Int(time1Elapsed.truncatingRemainder(dividingBy: 1) * 1000)
                
                //Find remaining time by subtraction the elapsed time from the duration
                if(time1ElapsedSeconds < 10 && time1ElapsedMilliseconds < 10)
                {
                    //add a 0 if the number of seconds is less than 10
                    loopRight.text = "\(time1ElapsedMinutes):0\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else if(time1ElapsedSeconds > 10 && time1ElapsedSeconds < 10)
                {
                    //if more than 10, display as is
                    loopRight.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):00\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                else
                {
                    loopRight.text = "\(time1ElapsedMinutes):\(time1ElapsedSeconds):\(time1ElapsedMilliseconds < 0 ? 0 : time1ElapsedMilliseconds)"
                    loop()
                }
                
            }
            
            if loopingSongBackground == true
            {
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
        
        
        loopData.append(time1Elapsed)
        print(loopData[0])
    }
    
    @IBAction func end(_ sender: UIButton)
    {
        loopRightChanging = false
        
        
        loopData.append(time1Elapsed)
        if(loopLeft.text != nil && loopRight.text != nil)
        {
            playbutton.setImage(UIImage(named: "ic_action_pausesong.png"), for: .normal)
            playing = true
        }
        print(loopData[1])
        if(loopRightChanging && !loopLeftChanging)
        {
            createAlert()
        }
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
        
        var song = Song()
        song.songName = nameOfTheSong.text
        saveSongsList.append(song)
        
        tableView.reloadData()
    }
    
    // change functionality of this
    @IBAction func stopLoopedSong(_ sender: UIButton)
    {
        loopLeft.text = String(loopData[0])
        loopingSongBackground = true
        mp.currentPlaybackTime = loopData[0]
        mp.pause()
        playLoopedbutton.setImage(UIImage(named: "ic_action_playsong.png"),for: .normal)
    }
    
    @IBAction func resetLoopedSong(_ sender: UIButton)
    {
        
        //connect some functionality to reset the data so that it can change labels again.
        mp.skipToBeginning()
        mp.pause()
        loopLeft.text = String(sliderTime.minimumValue)
        loopRight.text = String(sliderTime.minimumValue)
        loopData.removeAll()
        //isPlayingLoopedSong = false
        playLoopedbutton.setImage(UIImage(named: "ic_action_playsong.png"), for: .normal)
        loopingSongBackground = false
        loopData.removeAll()
        loopLeftChanging = true
        loopRightChanging = true
    }
    
    @IBAction func playLoopedSong(_ sender: UIButton)
    {
        
        loopingSongBackground = true
        
        if playLoopedbutton.currentImage == UIImage(named:"ic_action_playsong.png")
        {
            if (isBackgroundPlayerPlaying == false)
            {
                isBackgroundPlayerPlaying = true
                
                let change = Double(loopData[0])
                //mp.currentPlaybackTime = loopData[0]
                
                mp.currentPlaybackTime = change
                let trackElapsedMinutes = Int(change / 60)
                let trackElapsedSeconds = Int(change.truncatingRemainder(dividingBy: 60))
                let trackElapsedMilliseconds = Int(change.truncatingRemainder(dividingBy: 1) * 1000)
                
                if(trackElapsedSeconds < 10 && trackElapsedMilliseconds < 10)
                {
                    //add a 0 if the number of seconds is less than 10
                    loopLeft.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
                else if(trackElapsedSeconds > 10 && trackElapsedMilliseconds < 10)
                {
                    //if more than 10, display as is
                    loopLeft.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
                else
                {
                    loopLeft.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
                }
            }
            mp.play()
            playLoopedbutton.setImage(UIImage(named:"ic_action_pausesong.png"), for: .normal)
            playbutton.setImage(UIImage(named:"ic_action_playsong.png"), for: .normal)
            loop()
            playing = false
        }
        else
        {
            playLoopedbutton.setImage(UIImage(named:"ic_action_playsong.png"), for: .normal)
            mp.pause()
        }
        
    }
    func loop()
    {
        //need to make change in this to prevent the slider from changing its position while the loop is being played.
        if (loopData.count == 2 && loopingSongBackground == true)
        {
            if(mp.currentPlaybackTime >= loopData[1])
            {
                mp.currentPlaybackTime = loopData[0]
            }
        }
    }
    
    func paused()
    {
        mp.pause()
    }
    
    func createAlert()
    {
        let alert = UIAlertController(title : "Alert", message : "Select the Start Time before choosing the End time", preferredStyle : .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated : true, completion : nil)
    }
    
    func secondsToTimeLeftLoop(seconds : Double)
    {
        loopData[0] = seconds
        let trackElapsedMinutes = Int(seconds / 60)
        let trackElapsedSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        let trackElapsedMilliseconds = Int(seconds.truncatingRemainder(dividingBy: 1) * 1000)
        
        if(trackElapsedSeconds < 10 && trackElapsedMilliseconds < 10)
        {
            //add a 0 if the number of seconds is less than 10
            loopLeft.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
        else if(trackElapsedSeconds > 10 && trackElapsedMilliseconds < 10)
        {
            //if more than 10, display as is
            loopLeft.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
        else
        {
            loopLeft.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
        
    }
    
    func secondsToTimeRightLoop(seconds : Double)
    {
        loopData[1] = seconds
        let trackElapsedMinutes = Int(seconds / 60)
        let trackElapsedSeconds = Int(seconds.truncatingRemainder(dividingBy: 60))
        let trackElapsedMilliseconds = Int(seconds.truncatingRemainder(dividingBy: 1) * 1000)
        
        if(trackElapsedSeconds < 10 && trackElapsedMilliseconds < 10)
        {
            //add a 0 if the number of seconds is less than 10
            loopRight.text = "\(trackElapsedMinutes):0\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
        else if(trackElapsedSeconds > 10 && trackElapsedMilliseconds < 10)
        {
            //if more than 10, display as is
            loopRight.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):00\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
        else
        {
            loopRight.text = "\(trackElapsedMinutes):\(trackElapsedSeconds):\(trackElapsedMilliseconds < 0 ? 0 : trackElapsedMilliseconds)"
        }
    }
    
    //COREDATA STUFF AND FUNCTIONS ARE DECLARED HERE
    
    
}
extension ViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        //guard let quotes = fetchedResultsController.fetchedObjects else { return 0 }
        return saveSongsList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //        let person = songName[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongTableViewCell.reuseIdentifier, for: indexPath) as? SongTableViewCell else
        {
            fatalError("Unexpected Index Path")
        }
        //configure(cell, at: indexPath)
        
        let song = saveSongsList[indexPath.row]
        
        cell.lblSongName.text = song.songName
        
        return cell
        
    }
}


//EXTENSION FOR THE CORE DATA STUFF IS HERE


