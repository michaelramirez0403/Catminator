//
//  BaseViewController.swift
//
//  Created by Macky Ramirez on 10/2/24.
//

import UIKit
class BaseViewController: UIViewController {
    var containerView: UIView!
    func configureUI() { }
    func makeConstrainst() { }
    func push() { }
    // MARK: - Loading View
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        activityIndicator.startAnimating()
    }
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
