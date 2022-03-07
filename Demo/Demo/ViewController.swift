//
//  ViewController.swift
//  Demo
//
//  Created by GoEun Jeong on 2022/03/07.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    
    private var player = AVPlayer()
    private var timeObserver: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp(urlString: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/music.mp3")
//        setDuration(duration: 250)
        addObserverToPlayer()
    }
    
    private func setUp(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("urlString Error" )
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        } catch {
            print("Audio Setting Error" )
        }
    }
    
//    private func setDuration(duration: Int) {
//        self.endTimeLabel.text = Double(duration).convertToTime()
//        self.progressSlider.maximumValue = Float(duration)
//    }
    
    private func updateTime() {
        self.currentTimeLabel.text = String(player.currentTime().seconds.convertToTime())
        self.progressSlider.value = Float(player.currentTime().seconds)
    }
    
    private func addObserverToPlayer() {
        self.timeObserver = self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil, using: { [weak self] _ in
            self?.updateTime()
        })
    }
    
    private func removeObserverToPlayer() {
        if let timeObserver = timeObserver {
            self.player.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            self.player.pause()
        } else {
            self.player.play()
        }
        
        sender.isSelected.toggle()
    }
    
}
