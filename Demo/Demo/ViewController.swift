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
