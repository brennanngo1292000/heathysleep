//
//  SoundConfigView.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import UIKit

protocol SoundConfigViewDelegate {
    func didTapAlarmButton(_ configView: SoundConfigView)
    
    func didTapFadeButton(_ configView: SoundConfigView)
    
    func didTapFavoriteButton(_ configView: SoundConfigView, from: Bool)
}

class SoundConfigView: UIView {
    
    var delegate: SoundConfigViewDelegate?

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private var alarmButton = AlarmButtonView()
    
    private var fadeButton = FadeOutButtonView()
    
    private var favoriteButton = FavoriteButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(alarmButton)
        addSubview(fadeButton)
        addSubview(favoriteButton)
        alarmButton.delegate = self
        fadeButton.delegate = self
        favoriteButton.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let buttonSize: CGFloat = 40
        let buttonSpacing: CGFloat = ( width - buttonSize *  3 ) / 4
        alarmButton.frame = CGRect(x: buttonSpacing, y: height - buttonSpacing / 2 - buttonSize, width: buttonSize, height: buttonSize)
        fadeButton.frame = CGRect(x: alarmButton.right + buttonSpacing, y: alarmButton.top, width: buttonSize, height: buttonSize)
        favoriteButton.frame = CGRect(x: fadeButton.right + buttonSpacing, y: fadeButton.top, width: buttonSize, height: buttonSize)
        
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        if let fileName = state.sound?.image,  changed.contains(.sound) {
            imageView.image = UIImage(named: fileName)
        }
        if changed.contains(.fadeOut) {
            fadeButton.updateUIWith(state: state, changed: changed)
        }
        if changed.contains(.alarm) {
            alarmButton.updateUIWith(state: state, changed: changed)
        }
    }

}

extension SoundConfigView: AlarmButtonViewDelegate {
    func didTapAlarmButton(_ View: AlarmButtonView) {
        //
    }
    
    func didChangeAlarm(_ View: AlarmButtonView, value: Date) {
        //
    }
    
    
}

extension SoundConfigView: FavoriteButtonViewDelegate {
    func didTapFavoriteButton(_ view: FavoriteButtonView, fromValue: Bool) {
        //
    }
}

extension SoundConfigView: FadeOutButtonViewDelegate {
    func didTapFadeButton(_ view: FadeOutButtonView) {
        //
    }
    
    func didChangeFadeOut(_ view: FadeOutButtonView, value: FadeValue) {
        //
    }
    
    
}
