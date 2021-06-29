//
//  SoundControlView.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import UIKit

protocol SoundControlViewDataSource {
    var isPlaying: Bool { get }
    var duration: Float? { get }
    var volume: Float { get }
    var soundName: String { get }
    var timeRemaining: Float { get }
}

protocol SoundControlViewDelegate {
    func didTapPlay(_ controllView: SoundControlView, completion: @escaping (Bool) -> Void)
    func didTapStop(_ controllView: SoundControlView, completion: @escaping (Bool) -> Void)
    func didChangeDuration(_ controllView: SoundControlView, value: DurationValue, completion: @escaping (Bool) -> Void)
    func didChangeVolume(_ controllView: SoundControlView, value: Float, completion: @escaping (Bool) -> Void)
}

class SoundControlView: UIView {
    
    var delegate: SoundControlViewDelegate?
    var dataSource: SoundControlViewDataSource?
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    private let durationSlider: DurationSliderView = {
        let durationSlider = DurationSliderView()
        return durationSlider
    }()
    
    private let volumeSlider: UISlider = {
        let volumeSlider = UISlider()
        volumeSlider.minimumValueImage = UIImage(systemName: "speaker.fill")
        volumeSlider.maximumValueImage = UIImage(systemName: "speaker.wave.2.fill")
        volumeSlider.thumbTintColor = .systemPink
        volumeSlider.value = 0.3
        return volumeSlider
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let timeRemaining: UILabel = {
        let timeRemaining = UILabel()
        timeRemaining.text = "Time Remaining 0:00:30"
        timeRemaining.textAlignment = .center
        return timeRemaining
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(durationSlider)
        addSubview(volumeSlider)
        addSubview(playButton)
        addSubview(stopButton)
        addSubview(timeRemaining)
        
        durationSlider.delegate = self
        volumeSlider.addTarget(self, action: #selector(didChangeValue(slider:)), for: .valueChanged)
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(didTapStop), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
        let spacing: CGFloat = 10
        nameLabel.frame = CGRect(x: 0, y: spacing, width: width - spacing * 2, height: 30)
        durationSlider.frame = CGRect(x: spacing, y: nameLabel.bottom + spacing, width:width - spacing * 2, height: 50 )
        volumeSlider.frame = CGRect(x: spacing, y: durationSlider.bottom + spacing, width:width - spacing * 2, height: 50 )
        playButton.frame = CGRect(x: spacing, y: volumeSlider.bottom + spacing, width:(width - spacing * 3)/2, height: 50 )
        stopButton.frame = CGRect(x: playButton.right + spacing, y: playButton.top, width:(width - spacing * 3)/2, height: 50 )
        timeRemaining.frame = CGRect(x: spacing, y: stopButton.bottom + spacing, width: width - spacing * 2, height: 50 )
    }
    
    func reloadData() {
        if let isPlaying = dataSource?.isPlaying {
            if isPlaying {
                playButton.backgroundColor = .systemPink
                stopButton.backgroundColor = .red
            } else {
                playButton.backgroundColor = .red
                stopButton.backgroundColor = .systemPink
            }
        }
        if let duration = dataSource?.duration {
            volumeSlider.value = duration
        }
        if let volume = dataSource?.volume {
            volumeSlider.value = volume
        }
        if let soundName = dataSource?.soundName {
            nameLabel.text = soundName
        }
        if let time = dataSource?.timeRemaining {
            hmsFrom(seconds: Int(time), completion: { hours, minutes, seconds in
                
                let hours = getStringFrom(seconds: hours)
                let minutes = getStringFrom(seconds: minutes)
                let seconds = getStringFrom(seconds: seconds)
                
                DispatchQueue.main.async {
                    self.timeRemaining.text = "Time Remaining \(hours):\(minutes):\(seconds)"
                }
                
            })
        }
    }
    
    @objc func didTapPlay () {
        delegate?.didTapPlay(self) { result in
            if result {
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
    
    @objc func didTapStop() {
        delegate?.didTapStop(self) { result in
            if result {
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
    
    @objc func didChangeValue (slider: UISlider) {
        let value = slider.value
        delegate?.didChangeVolume(self, value: value) { result in
            if result {
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
}

extension SoundControlView: DurationSliderViewDelegate {
    func didChangeDuration(_ durationSliderView: DurationSliderView, value: DurationValue) {
        hmsFrom(seconds: Int(value.seconds), completion: { hours, minutes, seconds in
            
            let hours = getStringFrom(seconds: hours)
            let minutes = getStringFrom(seconds: minutes)
            let seconds = getStringFrom(seconds: seconds)
            
            DispatchQueue.main.async {
                self.timeRemaining.text = "Time Remaining \(hours):\(minutes):\(seconds)"
            }
            
        })
        
        delegate?.didChangeDuration(self, value: value) { result in
            if result {
                DispatchQueue.main.async {
                    self.reloadData()
                }
            }
        }
    }
}
