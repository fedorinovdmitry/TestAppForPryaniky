//
//  UIView+addSub.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach{ self.addSubview($0) }
    }
}
