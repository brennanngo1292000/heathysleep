//
//  FavoriteButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol FavoriteButtonViewDelegate {
    func didTapFavoriteButton(_ view: FavoriteButtonView, fromValue: Bool)
}

class FavoriteButtonView: UIView {

    var delegate: FavoriteButtonViewDelegate?
    
    private var favoriteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(favoriteButton)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favoriteButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        
    }
    
    @objc func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(self, fromValue: false)
    }


}
