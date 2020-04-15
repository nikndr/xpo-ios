//
//  EditExpoViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class ManageExpoViewController: UIViewController {
    // MARK: - Properties
    
    var expo: Expo!
    var datePicker: UIDatePicker!
    
    // MARK: - Computed properties
    
    var focusedDateTextField: UITextField? {
        if startDateTextField.isFirstResponder {
            return startDateTextField
        } else if endDateTextField.isFirstResponder {
            return endDateTextField
        }
        return nil
    }
    
    // MARK: - Outlets
    
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var selectTitleImageButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var filePicketTableView: UITableView!
    
    // MARK: - Actions
    
    @IBAction func selectTitleImageButtonPressed(_ sender: UIButton) {}
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        configureDatePicker()
        makeRoundedCorners()
    }
    
    func makeRoundedCorners() {
        selectTitleImageButton.makeRoundedCorners()
        descriptionTextView.makeRoundedCorners(withRadius: 5.0)
        titleImage.makeRoundedCorners(withRadius: 5.0)
    }
    
    // MARK: - DatePicker configuration
    
    func configureDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        
        startDateTextField.inputView = datePicker
        endDateTextField.inputView = datePicker
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy, hh:mm"
        focusedDateTextField?.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func viewTapped(_ gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
}

// MARK: - Cell identifiers

extension ManageExpoViewController {
    enum CellIdentifiers: String {
        case fileCell
    }
}
