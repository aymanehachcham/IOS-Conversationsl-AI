//
//  CustomButton.swift
//  FirstApplication
//
//  Created by aymane hachcham on 6/2/2021.
//

import UIKit
import Foundation

class RecordingButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.backgroundColor = UIColor.systemBackground.cgColor
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.4
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowRadius = 10
        layer.masksToBounds = true
        clipsToBounds = false
        titleEdgeInsets.left = 15
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 100)
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        contentHorizontalAlignment = .center

        
        titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        setTitleColor(.black, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
}

extension UIImage {
    
    func resized(newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
