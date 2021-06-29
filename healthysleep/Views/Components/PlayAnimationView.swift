//
//  StatusPlayerViewBarItem.swift
//  healthysleep
//
//  Created by Mac on 28/06/2021.
//

import UIKit
import Lottie

protocol PlayAnimationViewDataSource {
    var isPlaying: Bool { get }
    var isPaused: Bool { get }
    var isStoped: Bool { get }
}

class PlayAnimationView: UIView {
    
    var dataSource: PlayAnimationViewDataSource?
    
    private var animationView: AnimationView = {
        let animationView = AnimationView(name: "playing_anim_st")
        animationView.contentMode = .scaleAspectFit
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        animationView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        animationView.center = self.center
        animationView.play()
        animationView.loopMode = .loop
    }
    
}
