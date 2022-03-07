//
//  ViewController.swift
//  Demo
//
//  Created by GoEun Jeong on 2022/03/07.
//

import UIKit
import GEAudioPlayer

class ViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    let player = GEAudioPlayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player.delegate = self
        player.setUpAudio(url: "https://grepp-programmers-challenges.s3.ap-northeast-2.amazonaws.com/2020-flo/music.mp3")
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

extension ViewController: GEAudioPlayerDelegate {
    func audioTimeDidChange(seconds: Int) {
        print("현재 \(seconds)초")
    }
    
    func audioDidEnd() {
        print("음악이 끝났습니다.")
    }
    
    func audioDidInterruptStart() {
        
    }
    
    func audioDidInterruptEnd() {
        
    }
}
