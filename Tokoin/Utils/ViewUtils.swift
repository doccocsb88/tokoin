//
//  ViewUtils.swift
//  Tokoin
//
//  Created by Anh Hai on 2/17/20.
//  Copyright © 2020 Anh Hai. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIView {
    func forAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func rounded(color: UIColor = .darkGray, radius: CGFloat = 4, borderWidth: CGFloat = 1) {
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = borderWidth
        layer.masksToBounds = true
    }
}

extension UIImageView {
    func loadImage(with urlToImage: String?) {
        guard let imageURL = urlToImage, let url = URL(string: imageURL) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
