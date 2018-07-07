//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    let story =
        [
        "Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\".",
        "He nods slowly, unphased by the question.",
        "As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.",
        "What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?",
        "As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.",
        "You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\""
    ]
    
    let answer =
        [
        "I\'ll hop in. Thanks for the help!",
        "Better ask him if he\'s a murderer first.",
        "At least he\'s honest. I\'ll climb in.",
        "Wait, I know how to change a tire.",
        "I love Elton John! Hand him the cassette tape.",
        "It\'s him or me! You take the knife and stab him."
    ]
    //    For debug purpose
    //    let story = ["story1","story2","story3","story4","story5","story6"]
    //    let answer = ["asnwer1a","answer1b","answer2a","answer2b","answer3a","answer3b"]
    //
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!         // Has TAG = 1
    @IBOutlet weak var bottomButton: UIButton!      // Has TAG = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    // TODO Step 5: Initialise instance variables here
    var storyIndex = 1
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // TODO Step 3: Set the text for the storyTextView, topButton, bottomButton, and to T1_Story, T1_Ans1, and T1_Ans2
        restart()
    }
        
    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton)
    {
        
        if sender.tag == 1 && (storyIndex == 1 || storyIndex == 2)
        {
            storyTextView.text = story[2]
            topButton.setTitle(answer[4], for: .normal)
            bottomButton.setTitle(answer[5], for: .normal)
            storyIndex = 3
            
        }
        else if sender.tag == 2 && storyIndex == 1
        {
            
            storyTextView.text = story[1]
            topButton.setTitle(answer[2], for: .normal)
            bottomButton.setTitle(answer[3], for: .normal)
            storyIndex = 2
        }
        else if  sender.tag == 1 && storyIndex == 3
        {
            
            storyTextView.text = story[5]
            storyIndex = 6
        }
        else if  sender.tag == 2 && storyIndex == 3
        {
            
            storyTextView.text = story[4]
            storyIndex = 5
        }
        else if sender.tag == 2 && storyIndex == 2
        {
            storyTextView.text = story[3]
            storyIndex = 4
        }
        if  storyIndex <= 6 && storyIndex >= 4
        {
            topButton.setTitle("Restart", for: .normal)
            bottomButton.isHidden = true
            storyIndex = 7
        }
        else if sender.tag == 1 && storyIndex == 7
        {
            restart()
        }
    }
    
        // Restart function for the text view and button title
        
    func restart()
    {
        storyTextView.text = story[0]
        topButton.setTitle(answer[0], for: .normal)
        bottomButton.setTitle(answer[1], for: .normal)
        bottomButton.isHidden = false
        storyIndex = 1
    }
}

