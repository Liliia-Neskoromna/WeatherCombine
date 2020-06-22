//
//  UITextField+Publisher.swift
//  WeatherCombine
//
//  Created by Lilia on 6/22/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .map { $0.text ?? "" }
            .eraseToAnyPublisher()
    }
}
