//
//  ViewController.swift
//  autoLayout
//
//  Created by ritu sharma on 17/7/18.
//  Copyright © 2018 Kush. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    // Avoids polluting the ViewDidLoad
    private let bearImageView : UIImageView =
    {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bearPaw"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionTextView : UITextView =
    {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSMutableAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you soon in one of our stores", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText

//        textView.text = "Join us today in our fun and games!"
//        textView.font = UIFont.boldSystemFont(ofSize: 18)

        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let prevButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pageControl: UIPageControl =
    {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    private let nextButton: UIButton =
    {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        let pinkColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        button.setTitleColor(pinkColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.addSubview(descriptionTextView)
        
        setupBottomControls()
        setupLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    fileprivate func setupBottomControls()
    {
        let bottomControlsContainer = UIStackView(arrangedSubviews: [prevButton, pageControl, nextButton])
        
        bottomControlsContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsContainer.distribution = .fillEqually
        
        view.addSubview(bottomControlsContainer)
      
        bottomControlsContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomControlsContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomControlsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomControlsContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    private func setupLayout()
    {
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        containerView.addSubview(bearImageView)
        
        bearImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        
        
        
        descriptionTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    


}

