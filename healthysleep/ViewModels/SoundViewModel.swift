//
//  File.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import Foundation

final class SoundViewModel {
    
    init(sound: Sound) {
        PlaybackPresenter.shared.confiure(sound: sound)
    }
    
    func play(completion : @escaping (Bool) -> Void) {
        PlaybackPresenter.shared.play()
        completion(true)
    }
    
    func pause(completion : @escaping (Bool) -> Void) {
        PlaybackPresenter.shared.pause()
        completion(true)
    }
    
    func stop(completion : @escaping (Bool) -> Void) {
        PlaybackPresenter.shared.stop()
        completion(true)
    }
    
    func toggleFavorite (from: Bool, completion: @escaping (Bool) -> Void) {
        guard let nameKey = PlaybackPresenter.shared.sound?.name_key else {
            completion(false)
            return
        }
        if from {
            FavoriteSounds.shared.delete(nameKey: nameKey, completion: completion )
        } else {
            FavoriteSounds.shared.add(nameKey: nameKey, completion: completion)
        }
    }
    
    func changeVolume (value: Float, completion : @escaping (Bool) -> Void) {
        PlaybackPresenter.shared.changeVolume(value: value)
        completion(true)
    }
    
    func changeDuration (value: DurationValue, completion : @escaping (Bool) -> Void) {
        self.stop(completion: { _ in })
        PlaybackPresenter.shared.changeDuration(value: value)
        completion(true)
    }
    
}

extension SoundViewModel: SoundConfigViewDataSource {
    var imageName: String? {
        return PlaybackPresenter.shared.sound?.image
    }
    
    var isFavories: Bool {
        guard let nameKey = PlaybackPresenter.shared.sound?.name_key else {
            return false
        }
        return FavoriteSounds.shared.has(with: nameKey)
    }
    
    var alarm: Date? {
        return Date()
    }
    
    var fadeOut: FadeValue? {
        return PlaybackPresenter.shared.fadeOut
    }
}

extension SoundViewModel: SoundControlViewDataSource {
    var timeRemaining: Float {
        return PlaybackPresenter.shared.timeRemaining
    }
    
    var soundName: String {
        return PlaybackPresenter.shared.sound?.name ?? ""
    }
    
    var volume: Float {
        return PlaybackPresenter.shared.player?.volume ?? 0.3
    }
    
    var isPlaying: Bool {
        return PlaybackPresenter.shared.isPlaying
    }
    
    var duration: Float? {
        return 0.3
    }
}
