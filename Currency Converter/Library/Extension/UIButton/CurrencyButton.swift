//
//  CurrencyButton.swift
//  Currency Converter
//
//  Created by USER on 08.11.2022.
//

import UIKit

struct ModelButton {
    let image: UIImage?
}

class CurrencyButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            
            if isHighlighted {
                touchDown()
            } else {
                touchUp()
            }
        }
    }

    private let imageForButton = UIImageView()
        .setMyStyle()
        .setShadow(color: Colors.shadow)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarhies()
        setConstaints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setHierarhies() {
        self.addSubview(imageForButton)
    }
    
    private func setConstaints() {
        NSLayoutConstraint.activate([
            imageForButton.topAnchor.constraint(equalTo: self.topAnchor),
            imageForButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageForButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageForButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func touchDown() {
        let scaleX = 0.96
        let scaleY = 0.96
        self.imageForButton.alpha = 0.5
        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        
    }
    
    private func touchUp() {
        let scaleX = 1.0
        let scaleY = 1.0
        
        UIView.animateKeyframes(withDuration: 0.4,
                                delay: 0,
                                options: [.beginFromCurrentState,
                                          .allowUserInteraction],
                                animations: {
            self.imageForButton.alpha = 1
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        })
    }
}
extension CurrencyButton: ConfigurableView {
    
    typealias Model = ModelButton
    
    func configure(with model: ModelButton) {
        self.imageForButton.image = model.image
    }
}
