//
//  ViewController.swift
//  healthBarAutoLayout
//
//  Created by ritu sharma on 20/7/18.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private let healthBar: UIView =
    {
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.red
        return bar
    }()
    
    private let happinessBar: UIView =
    {
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = UIColor.yellow
        return bar
    }()

    private func setupLayout()
    {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        
        let bottomControlsContainer = UIStackView(arrangedSubviews: [healthBar, whiteView, happinessBar])
        
        bottomControlsContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsContainer.distribution = .fillEqually
        
        view.addSubview(bottomControlsContainer)
        
        bottomControlsContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        bottomControlsContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomControlsContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomControlsContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

