//
//  UIView + Extensions.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ subViews: [UIView]) {
        subViews.forEach { addSubview($0) }
    }
}

extension String {
    func formattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, yyyy"

        if let formatDate = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: formatDate)
        } else {
            return self
        }
    }
}

extension UIImage {
    static func ==(lhs: UIImage, rhs: UIImage) -> Bool {
        lhs === rhs || lhs.pngData() == rhs.pngData()
    }
}
