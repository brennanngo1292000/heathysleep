//
//  SoundConfigView.swift
//  healthysleep
//
//  Created by Mac on 27/06/2021.
//

import UIKit

protocol SoundConfigViewDataSource {
    var imageName: String? { get }
    var isFavories: Bool { get }
    var alarm: Date? { get }
    var fadeOut: FadeValue? { get }
}
protocol SoundConfigViewDelegate {
    func didTapAlarmButton(_ configView: SoundConfigView)
    
    func didTapFadeButton(_ configView: SoundConfigView)
    
    func didTapFavoriteButton(_ configView: SoundConfigView, from: Bool)
}

class SoundConfigView: UIView {
    
    var delegate: SoundConfigViewDelegate?
    var dataSource: SoundConfigViewDataSource?

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()
    
    private var alarmButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var fadeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "waveform", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI () {
        backgroundColor = .red
        addSubview(imageView)
        addSubview(alarmButton)
        addSubview(fadeButton)
        addSubview(favoriteButton)
        
        alarmButton.addTarget(self, action: #selector(didTapAlarmButton), for: .touchUpInside)
        fadeButton.addTarget(self, action: #selector(didTapFadeButton), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let buttonSize: CGFloat = 40
        let buttonSpacing: CGFloat = ( width - buttonSize *  3 ) / 4
        alarmButton.frame = CGRect(x: buttonSpacing, y: height - buttonSpacing / 2 - buttonSize, width: buttonSize, height: buttonSize)
        fadeButton.frame = CGRect(x: alarmButton.right + buttonSpacing, y: alarmButton.top, width: buttonSize, height: buttonSize)
        favoriteButton.frame = CGRect(x: fadeButton.right + buttonSpacing, y: fadeButton.top, width: buttonSize, height: buttonSize)
        
    }
    
    func reloadData() {
        let iconSize:CGFloat = 34
        if let image = dataSource?.imageName {
            imageView.image = UIImage(named: image)
        }
        if let alarm = dataSource?.alarm {
            // do something
        }
        if let isFavorites = dataSource?.isFavories, isFavorites {
            let image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular))
            self.favoriteButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: iconSize, weight: .regular))
            self.favoriteButton.setImage(image, for: .normal)
        }
        if let fadeOut = dataSource?.fadeOut {
            // do something
        }
        
    }
    
    @objc func didTapAlarmButton() {
        delegate?.didTapAlarmButton(self)
    }
    
    @objc func didTapFadeButton() {
        delegate?.didTapFadeButton(self)
    }
    
    @objc func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(self, from: dataSource?.isFavories ?? false)
    }

}
