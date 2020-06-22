//
//  ViewController.swift
//  WeatherCombine
//
//  Created by Lilia on 6/16/20.
//  Copyright © 2020 Liliia. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    // MARK: - UI
    @IBOutlet weak var cityTextField: UITextField! {
        didSet {
            cityTextField.isEnabled = true
            cityTextField.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    // MARK: - View Model
    private let viewModel = TempViewModel()
    
    // MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.text = viewModel.city
       // binding()
    }
    
    //MARK: - Combine
    func binding() {
        cityTextField.textPublisher
            .assign(to: \.city, on: viewModel)
        .store(in: &cancellable)
        
        viewModel.$currentWeather
        .sink(receiveValue: {[weak self] currentWeather in
            
            self?.temperatureLabel.text = currentWeather.main?.temp != nil ?
                "\(Int((currentWeather.main?.temp!)!)) °C" : " "}
        )
        .store(in: &cancellable)
    }
    private var cancellable = Set<AnyCancellable>()
}

