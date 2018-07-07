//
//  ViewController.swift
//  Dicee
//
//  Created by ritu sharma on 11/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    
    @IBOutlet weak var diceImageView1: UIImageView!

    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateDiceImage()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func rollButtonPressed(_ sender: UIButton)
    {
        updateDiceImage()
        //self.
    }

    func updateDiceImage(){
        // arc4random_uniform() used for generating random numbers
        randomDiceIndex1 = Int(arc4random_uniform(6))
        randomDiceIndex2 = Int(arc4random_uniform(6))
        
        // UIImage is a data type for managing image data
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
        
        // random tests for the diceImage
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
            updateDiceImage()
        }
}
