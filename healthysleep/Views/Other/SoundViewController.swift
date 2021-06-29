//
//  SoundController.swift
//  healthysleep
//
//  Created by Mac on 25/06/2021.
//

import UIKit

class SoundViewController: UIViewController {
    
    private var viewModel: SoundViewModel?
    
    private var soundConfigView = SoundConfigView()
    
    private  var soundControlView = SoundControlView()
    
    init(viewModel: SoundViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(soundConfigView)
        view.addSubview(soundControlView)
        soundConfigView.delegate = self
        soundConfigView.dataSource = self.viewModel
        soundControlView.delegate = self
        soundControlView.dataSource = self.viewModel
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        soundConfigView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.width * 1.25)
        soundControlView.frame = CGRect(x: 0 , y: soundConfigView.bottom, width: view.width, height: view.height - soundConfigView.height)
    }

}

extension SoundViewController: SoundConfigViewDelegate {
    
    func didTapAlarmButton(_ configView: SoundConfigView) {
        let alertView = UIAlertController(title: "Select", message: "", preferredStyle: .alert)
        let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: alertView.view.width, height: 100))
        pickerView.datePickerMode = .time
        alertView.view.contentMode = .center
        alertView.view.addSubview(pickerView)
        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: {
            pickerView.frame.size.width = alertView.view.frame.size.width
            
        })
    }
    
    func didTapFadeButton(_ configView: SoundConfigView) {
        let alertView = UIAlertController(
            title: "Fade Out",
            message: "The Fade Out feature helps baby gently drift off to sleep. Customize to suit baby's needs. Your sound will fade out from full volume to 0 over a gradual, custom period of time without waking baby up.",
            preferredStyle: .alert
        )
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            let alertView = UIAlertController(
                title: "Fade Out",
                message: "",
                preferredStyle: .alert
            )
            let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
            alertView.view.addSubview(pickerView)
            alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alertView, animated: true, completion: nil)
        }))
        
        self.present(alertView, animated: true, completion: nil)
            
    }
    
    func didTapFavoriteButton(_ configView: SoundConfigView, from: Bool) {
        viewModel?.toggleFavorite(from: from, completion: { result in
            DispatchQueue.main.async {
                if result {
                    configView.reloadData()
                }
            }
        })
    }
    
}

extension SoundViewController: PlaybackPresenterDelegate {
    func audioPlayer(_ audioPlayer: AudioPlayer, didChangeStateFrom from: AudioPlayerState, to state: AudioPlayerState) {
        print(from, state)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didFindDuration duration: TimeInterval, for item: AudioItem) {
//        print(duration)
    }
    
    func audioPlayer(_ audioPlayer: AudioPlayer, didUpdateProgressionTo time: TimeInterval, percentageRead: Float) {
        soundControlView.reloadData()
    }
    
    
}

extension SoundViewController: SoundControlViewDelegate {
    
    func didChangeDuration(_ controllView: SoundControlView, value: DurationValue, completion: @escaping (Bool) -> Void) {
        viewModel?.changeDuration(value: value, completion:completion)
    }
    
    func didTapPlay(_ controllView: SoundControlView, completion: @escaping (Bool) -> Void) {
        viewModel?.play(completion: completion)
    }
    
    func didTapStop(_ controllView: SoundControlView, completion: @escaping (Bool) -> Void) {
        viewModel?.pause(completion: completion)
    }
    
    func didChangeVolume(_ controllView: SoundControlView, value: Float, completion: @escaping (Bool) -> Void) {
        viewModel?.changeVolume(value: value, completion: completion)
    }
}
