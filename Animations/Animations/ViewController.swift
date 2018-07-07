//
//  ViewController.swift
//  Animations
//
//  Created by ritu sharma on 16/01/2018.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    // button outlets for both the button and image
    @IBOutlet weak var tap: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var currentAnimation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // action outlet for the button that animates the image when the button is tapped.
    @IBAction func tapped(_ sender: UIButton) {
        tap.isHidden = true
        
        UIView.animate(withDuration: 6, animations: {
            
        })
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
        animations: { [unowned self] in
        switch self.currentAnimation {
            // scales up the image to twice its size
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            // brings back the image to its original size
            case 1:
            self.imageView.transform = CGAffineTransform.identity
            // moves the image to the given x&y coordinates.
            case 2:
            self.imageView.transform = CGAffineTransform(translationX: 0, y: 1000)
            // CGAffineTransform used to scale back to its original state.
            case 3:
            self.imageView.transform = CGAffineTransform.identity
            // CGAffineTransform(rotationAngle:CGFloat.pi rotates the image by 3.14 radians
            case 4:
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            // CGAffineTransform used to scale back to its original state.
            case 5:
            self.imageView.transform = CGAffineTransform.identity
            // alpha used to set the transparency of the image
            // alpha = 0, means completely transparent
            // background color used to change the background color
            case 6:
            self.imageView.alpha = 0
            self.imageView.backgroundColor = UIColor.green
            // alpha = 1, means visible
            case 7:
            self.imageView.alpha = 1
            self.imageView.backgroundColor = UIColor.clear
            // the default case just breaks the code incase nothing works
            default:
                break
            }
            })
        {[unowned self] (finished: Bool) in
                self.tap.isHidden = false
        }
        currentAnimation += 1
        
        // if you tap more than 7 times, the case goes back to 0 and starts the program all over again.
        if currentAnimation > 7 {
            currentAnimation = 0
            }
        }
    }
