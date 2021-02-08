//
//  ASRViewController.swift
//  FirstApplication
//
//  Created by aymane hachcham on 3/2/2021.
//

import UIKit
import Foundation
import AVFoundation


class ASRViewController: UIViewController {
    
    var recorderAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    lazy var upButton: UIButton = {
       
        var button = UIButton()
        button.setTitle("First", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleUpButton), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomButton: UIButton = {
       
        var button = UIButton()
        button.setTitle("Second", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(upButton)
        view.addSubview(bottomButton)
        
        setupAudio()
        constrainstInit()
        
    }
        
    // Constraints setup for the button and the two text fields
    func constrainstInit(){
        NSLayoutConstraint.activate([
            upButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            bottomButton.topAnchor.constraint(equalTo: upButton.bottomAnchor, constant: 20),
            bottomButton.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor, constant: 20),
            bottomButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc
    func handleUpButton(){
        playSound()
    }

}
