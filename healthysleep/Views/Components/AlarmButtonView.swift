//
//  AlarmButtonView.swift
//  healthysleep
//
//  Created by Mac on 30/06/2021.
//

import UIKit

protocol AlarmButtonViewDelegate {
    mutating func didTapAlarmButton(_ View: AlarmButtonView)
    func didChangeAlarm(_ View: AlarmButtonView, value: Date)
}

class AlarmButtonView: UIView {
    
    var delegate: AlarmButtonViewDelegate?

    private var alarmButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "clock", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(alarmButton)
        alarmButton.addTarget(self, action: #selector(didTapAlarmButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alarmButton.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    func updateUIWith(state: PlaybackState, changed: [PSField]) {
        
    }
    
    @objc func didTapAlarmButton() {
        delegate?.didTapAlarmButton(self)
    }

}
