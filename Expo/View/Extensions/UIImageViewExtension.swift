//
//  UIImageViewExtension.swift
//  Expo
//
//  Created by Nikandr Marhal on 29.03.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

extension UIImageView {
    //// Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.lightGray
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        addConstraints([centerX, centerY])
        return activityIndicator
    }

    /// Asynchronous downloading and setting the image from the provided urlString
    func setImageFrom(url urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)
        let activityIndicator = self.activityIndicator

        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }

        let downloadImageTask = session.dataTask(with: url) { data, _, error in
            guard let imageData = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                return
            }
            DispatchQueue.main.async { [weak self] in
                var image = UIImage(data: imageData)
                self?.image = nil
                self?.image = image
                image = nil
                completion?()
            }

            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            session.finishTasksAndInvalidate()
        }
        downloadImageTask.resume()
    }
}
