//
//  a.swift
//  Demo
//
//  Created by GoEun Jeong on 2022/03/07.
//

import Foundation
import AVFoundation

#if os(iOS)
public protocol GEAudioPlayerDelegate: AnyObject {
    func audioTimeDidChange(seconds: Int)
    func audioDidEnd()
    func audioDidInterruptStart()
    func audioDidInterruptEnd()
}

public final class GEAudioPlayer {
    public let shared = GEAudioPlayer()
    public var delegate: GEAudioPlayerDelegate?
    
    private var player: AVPlayer?
    private var timeObserver: Any?
    
    private init() {
        self.observerTime()
        self.addPlayerEndObserver()
        self.addAudioInterruptionObserver()
    }
    
    deinit {
        self.player?.pause()
        self.timeObserver = nil
        NotificationCenter.default.removeObserver(self)
        self.player = nil
    }
    
    public func setUpAudio(url: String) {
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        } catch {
            print("Audio Setting Error" )
        }
        
        guard let url = URL(string: url) else {
            print("urlString Error")
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        self.player = AVPlayer(playerItem: playerItem)
        
        self.observerTime()
    }
    
    public func play() {
        guard let player = player else { return }
        
        player.play()
    }
    
    public func pause() {
        guard let player = player else { return }
        
        player.pause()
    }
    
    public func getDuration() -> Double {
        guard let player = player else { return 0 }
        
        return player.currentItem?.duration.seconds ?? 0
    }
    
    public func getCurrentTime() -> Double {
        guard let player = player else { return 0 }
        
        return player.currentTime().seconds
    }
    
    private func observerTime() {
        guard let player = player else { return }
        
        self.timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil, using: { [weak self] time in
            self?.delegate?.audioTimeDidChange(seconds: Int(time.seconds))
        })
    }
    
    private func addPlayerEndObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    private func addAudioInterruptionObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruptionOccured(notification:)), name: AVAudioSession.interruptionNotification, object: AVAudioSession.sharedInstance())
    }
    
    @objc private func playerItemDidReachEnd() {
        self.delegate?.audioDidEnd()
    }
    
    @objc private func handleInterruptionOccured(notification: Notification) {
        guard let interruptionType = notification.userInfo?[AVAudioSessionInterruptionTypeKey] as? AVAudioSession.InterruptionType else { return }
        
        if interruptionType == .began {
            self.delegate?.audioDidInterruptStart()
        } else {
            guard let options = notification.userInfo?[AVAudioSessionInterruptionOptionKey] as? AVAudioSession.InterruptionOptions else { return }
            if options == .shouldResume {
                self.delegate?.audioDidInterruptEnd()
            }
        }
    }
}

#endif
