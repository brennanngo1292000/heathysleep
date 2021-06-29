//
//  PlaybackPresenter.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

protocol PlaybackPresenterDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState)
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem)
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float)
}

final class PlaybackPresenter {
    
    static let shared = PlaybackPresenter()
    private(set) var player: AudioPlayer?
    private(set) var sound: Sound?
    private(set) var fadeOut: FadeValue?
    private(set) var isPlaying = false
    private(set) var timeRemaining: Float = 30
    private(set) var duration: Float = 30
    
    private var delegate: PlaybackPresenterDelegate?
    
    func resgister(_ delegate: PlaybackPresenterDelegate) {
        self.delegate = delegate
    }
    
    func confiure(sound: Sound?) {
        if let sound = sound,  self.sound?.name_key != sound.name_key {
            stop()
            self.sound = sound
        }
    }
    
    func play () {
        if player != nil {
            self.resume()
        } else {
            player = AudioPlayer()
            player?.delegate = self
            guard let url = Bundle.main.url(forResource: sound?.audio_loop, withExtension: "m4a") else {
                return
            }
            guard let item = AudioItem(mediumQualitySoundURL: url) else { return }
            player?.play(item: item)
        }
        
        isPlaying = true
    }
    
    func resume() {
        if let player = player, player.state.isPaused {
            player.resume()
            isPlaying = true
        }
    }
    
    func pause() {
        guard let player = player, !player.state.isPaused else {
            return
        }
        player.pause()
        isPlaying = false
    }
    
    func stop() {
        guard let player = player, !player.state.isStopped else {
            return
        }
        player.stop()
        isPlaying = false
    }
    
    func changeVolume(value: Float) {
        player?.volume = value
    }
    
    func changeDuration(value: DurationValue) {
        self.timeRemaining = value.seconds
    }
    
    func changeFade(value: FadeValue) {
        self.fadeOut = value
    }
    
}

extension PlaybackPresenter: AudioPlayerDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        switch state {
        case .playing:
            isPlaying = true
        default:
            isPlaying = false
        }
        delegate?.audioPlayer(audioPlayer, didChangeStateFrom: from, to: state)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
        delegate?.audioPlayer(audioPlayer, didFindDuration: duration, for: item)
        self.duration = Float(duration.toSeconds())
        timeRemaining = Float(duration.toSeconds())
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        delegate?.audioPlayer(audioPlayer, didUpdateProgressionTo: time, percentageRead: percentageRead)
        timeRemaining = duration - Float(time.toSeconds())
    }
}
