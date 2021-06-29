//
//  TimeRemainingView.swift
//  healthysleep
//
//  Created by Mac on 29/06/2021.
//

import UIKit

protocol  TimeRemainingViewDataSource {
    
}

class TimeRemainingView: UIView {

    var dataSource: SoundControlViewDataSource?
    
    private let timeRemaining: UILabel = {
        let timeRemaining = UILabel()
        timeRemaining.text = "Time Remaining 0:00:30"
        timeRemaining.textAlignment = .center
        return timeRemaining
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(timeRemaining)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeRemaining.frame = CGRect(x: 0, y: 0, width: width, height: height )
    }
    
    func reloadData() {
        if let
    }
}