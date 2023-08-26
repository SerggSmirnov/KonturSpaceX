//
//  ViewController.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 26.08.2023.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }


}

//MARK: - setConstraints

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
//            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
//            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}
