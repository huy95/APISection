//
//  ViewController1.swift
//  URLSectionAPI
//
//  Created by Huy on 5/28/20.
//  Copyright © 2020 Huy. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController1: UIViewController {

     var previewUrl: String?
     
     var videoView: UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       return view
     }()
     
     var player: AVPlayer?
     
     var played: Bool = true
     
     var playButton: UIButton = {
       let button = UIButton()
       button.translatesAutoresizingMaskIntoConstraints = false
       button.setTitle("Pause", for: .normal)
       button.setTitleColor(.systemBlue, for: .normal)
       button.setTitleColor(.systemRed, for: .highlighted)
       button.backgroundColor = .white
       return button
     }()
     
     override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = .white
       
       addComponent()
       setupLayout()
       setupButton()
       setupNavigation()
     }
     
     override func viewDidAppear(_ animated: Bool) {
       let videoURL = URL(string: previewUrl ?? "")
       player = AVPlayer(url: videoURL!)
       let playerLayer = AVPlayerLayer(player: player)
       playerLayer.frame = videoView.bounds
       videoView.layer.addSublayer(playerLayer)
       player?.play()
     }
     
     func addComponent() {
       view.addSubview(videoView)
       view.addSubview(playButton)
     }
     
     func setupLayout() {
       [videoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        videoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
        videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        videoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100)].map { (anchor) in anchor.isActive = true}
       
       [playButton.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 16),
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        playButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        playButton.heightAnchor.constraint(equalToConstant: 48)].map { (anchor) in anchor.isActive = true}
     }
     
     func setupButton() {
       playButton.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
     }
     
     @objc func playVideo() {
       played = played == true ? false : true
       switch played {
         case true:
           player?.play()
           playButton.setTitle("Pause", for: .normal)
         case false:
           player?.pause()
           playButton.setTitle("Play", for: .normal)
       }
     }
     
     func setupNavigation() {
       let backItem = UIBarButtonItem()
       backItem.title = "Back"
       navigationItem.backBarButtonItem = backItem
       backItem.action = #selector(backButton)
     }
     
     @objc func backButton() {
       player?.pause()
     }

}
