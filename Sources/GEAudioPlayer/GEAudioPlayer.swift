import Foundation
import AVFoundation

#if os(iOS)
public final class GEAudioPlayer {
    public let shared = GEAudioPlayer()
    public var delegate = GEAudioPlayerDelegate?
    
    private var player = AVPlayer()
    
    private init() {
        self.observerTime()
        self.addPlayerEndObserver()
        self.addAudioInterruptionObserver()
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
        self.player.play()
    }
    
    public func pause() {
        self.player.pause()
    }
    
    public func getDuration() -> Double {
        return self.player.currentItem?.duration.seconds ?? 0
    }
    
    public func getCurrentTime() -> Double {
        return self.player.currentTime().seconds
    }
    
    private func observerTime() {
        self.player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil, using: { time in
            delegate?.currentTimeDidChange(seconds: Int(time.seconds))
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

public protocol GEAudioPlayerDelegate {
    func audioTimeDidChange(seconds: Int)
    func audioDidEnd()
    func audioDidInterruptStart()
    func audioDidInterruptEnd()
}

#endif
