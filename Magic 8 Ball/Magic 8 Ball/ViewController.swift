//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by ritu sharma on 15/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var randomBallNumber : Int = 0
    
    var ballArray = ["ball1","ball2","ball3","ball4","ball5"]
    
    @IBOutlet weak var ImageView: UIImageView!
    
   
    @IBOutlet weak var ggh: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBallImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        updateBallImage()
    }

    func updateBallImage()
    {
        randomBallNumber = Int(arc4random_uniform(5))
        ImageView.image = UIImage(named: ballArray[randomBallNumber])
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateBallImage()
    }
}
