//
//  AudioController.swift
//  FirstApplication
//
//  Created by aymane hachcham on 24/1/2021.
//

import UIKit
import AVFoundation

let screenWidth = UIScreen.main.bounds.width

class AudioRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    
    let asrController = ASRViewController()
    var audioRecorder: AVAudioRecorder!
    
    let logo: UIImageView = {
        let logoPng = UIImage(named: "conv-ai")?.resized(newSize: CGSize(width: screenWidth - 120, height: screenWidth - 120))
        let image = UIImageView(image: logoPng)
//        let tintedImage = image.image?.withRenderingMode(.alwaysTemplate)
//        image.image = tintedImage
//        image.tintColor = .label
        image.translatesAutoresizingMaskIntoConstraints = false
       return image
    }()
    
    lazy var recordingButton: RecordingButton = {
        var button = RecordingButton()
        button.setTitle("Start Recording", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageIcon = UIImage(named: "microphone")?.resized(newSize: CGSize(width: 25, height: 25))
        button.setImage(imageIcon, for: .normal)
        button.addTarget(self, action: #selector(recordAudio), for: .touchUpInside)
        return button
        
    }()
    
    lazy var stopRecordingButton: UIButton = {
        var button = UIButton()
        let imageIcon = UIImage(named: "stop")?.resized(newSize: CGSize(width: 50, height: 50))
        button.setImage(imageIcon, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopRecording), for: .touchUpInside)
        return button
    }()
    
    lazy var recordingLabel: UILabel = {
        let label = UILabel()
        label.text = "Recording in progress..."
        label.textColor = .gray
        label.font = UIFont(name: "Avenir-Heavy", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recordingProgressBar: UIProgressView = {
        var progressBar = UIProgressView()
        progressBar.setProgress(20, animated: true)
        return progressBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(recordingButton)
        view.addSubview(recordingLabel)
        view.addSubview(stopRecordingButton)
        view.addSubview(logo)
        
        constrainstInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingButton.isEnabled = false
        recordingLabel.isHidden = true
    }
    
    // Constraints setup for the button and the two text fields
    func constrainstInit(){
        NSLayoutConstraint.activate([
            
            // Constraints for the logo image:
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            // Constraints for the Recording Button:
            recordingButton.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            recordingButton.heightAnchor.constraint(equalToConstant: 60),
            recordingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordingButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: view.frame.height/6),
            
            // Constraints for the Label:
            recordingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordingLabel.topAnchor.constraint(equalTo: recordingButton.bottomAnchor, constant: 10),
            
            // Constraints for the Stop Recording Button:
            stopRecordingButton.widthAnchor.constraint(equalToConstant: view.frame.width - 60),
            stopRecordingButton.heightAnchor.constraint(equalToConstant: 60),
            stopRecordingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stopRecordingButton.topAnchor.constraint(equalTo: recordingButton.bottomAnchor, constant: 40)
        ])
    }
    
    @objc
    func recordAudio(){
        recordingButton.isEnabled = false
        recordingLabel.isHidden = false
        stopRecordingButton.isEnabled = true
        
        // Code for audio record:
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordedFileName = "recording.wav"
        let pathArray = [dirPath, recordedFileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let recordingSession = AVAudioSession.sharedInstance()
        try! recordingSession.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings:  [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    @objc
    func stopRecording() {
        stopRecordingButton.isEnabled = false
        recordingButton.isEnabled = true
        
        // Stop the recording and AVAudioRecord sesssion previously active:
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            asrController.recorderAudioURL = audioRecorder.url
            self.navigationController?.pushViewController(asrController, animated: true)
        }
        else {
            print("Your audio was not saved")
        }
    }


}



