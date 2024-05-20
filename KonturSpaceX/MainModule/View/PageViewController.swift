//
//  PageViewController.swift
//  KonturSpaceX
//
//  Created by Sergei Smirnov on 29.08.2023.
//

import UIKit

class PageViewController: UIPageViewController {
    // MARK: - Init
    
    // MARK: - Private properties
    
    var rocketsViewControllers = [RocketViewController]()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rocketsViewControllers = [
            {
                let vc = RocketViewController()
                vc.view.backgroundColor = .red
                return vc
            }(),
            {
                let vc = RocketViewController()
                vc.view.backgroundColor = .yellow
                return vc
            }(),
            {
                let vc = RocketViewController()
                vc.view.backgroundColor = .blue
                return vc
            }(),
        ]
        
        setViewControllers(rocketsViewControllers, direction: .forward, animated: true)
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.addSubview(backgroundImageView)
    }
}

// MARK: - setConstraints

extension PageViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

// MARK: - UIPageViewControllerDelegate

extension PageViewController: UIPageViewControllerDelegate {}

// MARK: - UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? RocketViewController else { return nil }
        if let index = rocketsViewControllers.firstIndex(of: vc) {
            if index > 0 {
                return rocketsViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? RocketViewController else { return nil }
        if let index = rocketsViewControllers.firstIndex(of: vc) {
            if index > rocketsViewControllers.count - 1 {
                return rocketsViewControllers[index + 1]
            }
        }
        return nil
    }
}
