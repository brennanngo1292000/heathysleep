//
//  FadeOutButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol FadeOutButtonViewDelegate {
    mutating func didTapFadeButton(_ view: FadeOutButtonView)
    func didChangeFadeOut(_ view: FadeOutButtonView, value: FadeValue)
}

class FadeOutButtonView: UIView {
    
    var delegate: FadeOutButtonViewDelegate?
    
    private var fadeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "waveform", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(fadeButton)
        fadeButton.addTarget(self, action: #selector(didTapFadeButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fadeButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        
    }
    
    @objc func didTapFadeButton() {
        delegate?.didTapFadeButton(self)
    }

}
