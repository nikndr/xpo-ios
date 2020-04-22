//
//  EditExpoViewController.swift
//  Expo
//
//  Created by Nikandr Marhal on 14.04.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import Alamofire
import UIKit

enum ManageScreenMode: String {
    case create
    case edit
}

class ManageExpoViewController: UIViewController {
    // MARK: - Properties
    
    var files = [(marker: String, model: String)]() // [(marker: "red-cat.jpg", model: "red-cat.scn"), (marker: "black-cat.jpg", model: "black-cat.scn")]
    
    var session = AppSession.shared
    var expo: Expo! {
        didSet {
            mode = .edit
        }
    }
    
    var mode: ManageScreenMode!
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
    
    var allFieldsFilled: Bool {
        [nameTextField, locationTextField, startDateTextField, endDateTextField]
            .allSatisfy { $0.text != nil }
            && descriptionTextView.text != nil
    }
    
    // MARK: - Outlets
    
    @IBOutlet var titleImage: UIImageView!
    @IBOutlet var selectTitleImageButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var filePickerTableView: UITableView!
    @IBOutlet var saveButton: UIButton!
    
    // MARK: - Actions
    
    @IBAction func selectTitleImageButtonPressed(_ sender: UIButton) {
        showImagePicker()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if mode == .edit {
            updateExpo()
        } else {
            createNewExpo()
        }
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        
//        filePicketTableView.register(FileSelectorTableViewCell.self, forCellReuseIdentifier: CellIdentifiers.selectFileCell.rawValue)
        
        filePickerTableView.delegate = self
        filePickerTableView.dataSource = self
        filePickerTableView.tableFooterView = UIView()
        
        filePickerTableView.reloadData()
        
        manageTextFieldEditing()
    }
    
    // MARK: - UI configuration
    
    /// Put your custom UI code here:
    /// rounded corners, shadows, corders etc.
    func configureUIElements() {
        configureDatePicker()
        makeRoundedCorners()
        
        if mode == .edit {
            initWithExpoData()
        } else {
            navigationItem.title = localizedString(for: .createNewExpo)
            saveButton.titleLabel?.text = localizedString(for: .create)
        }
        
        saveButton.setEnabled(false)
        
        descriptionTextView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2470588235)
        descriptionTextView.makeRoundedCorners(withRadius: 5)
    }
    
    func makeRoundedCorners() {
        selectTitleImageButton.makeRoundedCorners()
        saveButton.makeRoundedCorners()
        descriptionTextView.makeRoundedCorners(withRadius: 5.0)
        titleImage.makeRoundedCorners(withRadius: 5.0)
        filePickerTableView.makeRoundedCorners(withRadius: 5.0)
    }
    
    func initWithExpoData() {
        titleImage.setImageFrom(url: expo.imageURL)
        nameTextField.text = expo.name
        locationTextField.text = expo.locationName
        startDateTextField.text = DateFormatter.formattedDateTime(from: expo.startTime)
        endDateTextField.text = DateFormatter.formattedDateTime(from: expo.endTime)
        descriptionTextView.text = expo.description
        saveButton.titleLabel?.text = localizedString(for: .save)
        navigationItem.title = "\(localizedString(for: .edit)) \(expo.name)"
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
        focusedDateTextField?.text = DateFormatter.formattedDateTime(from: datePicker.date)
    }
    
    @objc func viewTapped(_ gestureRecognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - Expo creation and editing
    
    func createNewExpo() {
        guard case .loggedIn(let user) = session.state else { return }
        let alertTitle = localizedString(for: .pleaseWait)
        let alertBody = localizedString(for: .creatingNewExpo)
        let alert = UIAlertController.loadingView(withTitle: alertTitle, message: alertBody)
        present(alert, animated: true, completion: nil)
        
        let name = nameTextField.text!
        let description = descriptionTextView.text!
        let imageURL = "https://i.imgur.com/qcVM19M.jpg" // get from imgur
        let startTime = DateFormatter.date(from: startDateTextField.text!)!
        let endTime = DateFormatter.date(from: endDateTextField.text!)!
        let locationName = locationTextField.text!
        let userID = user.id
        
        Expo.createNewExpo(name: name, description: description, imageURL: imageURL, startTime: startTime, endTime: endTime, locationName: locationName, userID: userID) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let expo):
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .savedExc)
                        let alertBody = localizedString(for: .youHaveCreated)
                        let alert = UIAlertController(title: alertTitle, message: alertBody, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.expo = expo
                        self.configureUIElements()
                        let when = DispatchTime.now() + 1.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                case .failure(let error):
                    debugPrint("In createNewExpo(): \(error)")
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .creatingFailed)
                        let alertBody = localizedString(for: .couldNotCreateExpo)
                        let alert = UIAlertController(title: alertTitle, message: alertBody, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
            }
        }
    }
    
    func updateExpo() {
        let alertTitle = localizedString(for: .pleaseWait)
        let alertBody = localizedString(for: .savingExpo)
        let alert = UIAlertController.loadingView(withTitle: alertTitle, message: alertBody)
        present(alert, animated: true, completion: nil)
        
        let name = nameTextField.text!
        let description = descriptionTextView.text!
        let imageURL = expo.imageURL //"https://i.imgur.com/qcVM19M.jpg" // get from imgur
        let startTime = DateFormatter.date(from: startDateTextField.text!)!
        let endTime = DateFormatter.date(from: endDateTextField.text!)!
        let locationName = locationTextField.text!
        
        expo.updateExpo(name: name, description: description, imageURL: imageURL, startTime: startTime, endTime: endTime, locationName: locationName) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let expo):
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .savedExc)
                        let alertBody = localizedString(for: .youHaveUpdated)
                        let alert = UIAlertController(title: alertTitle, message: alertBody, preferredStyle: .alert)
                        self.present(alert, animated: true, completion: nil)
                        self.expo = expo
                        self.configureUIElements()
                        let when = DispatchTime.now() + 1.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            alert.dismiss(animated: true, completion: nil)
                        }
                    }
                case .failure(let error):
                    debugPrint("In updateExpo(): \(error)")
                    alert.dismiss(animated: true) { [weak self] in
                        guard let self = self else { return }
                        let alertTitle = localizedString(for: .updatingFailed)
                        let alertBody = localizedString(for: .couldNotCreateExpo)
                        let alert =
                            UIAlertController(title: alertTitle, message: alertBody, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
            }
        }
    }
    
    // MARK: - Field data validation
    
    func manageTextFieldEditing() {
        [nameTextField, locationTextField, startDateTextField, endDateTextField]
            .forEach { $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged) }
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        eraseSpaces(from: textField)
        restrictEmptyText(for: textField)
    }
    
    func eraseSpaces(from textField: UITextField) {
        if textField.text?.count == 1, textField.text?.first == " " {
            textField.text = ""
            return
        }
    }
    
    // TODO: additional validation of whether there are any models and markers
    func restrictEmptyText(for textField: UITextField) {
        debugPrint(allFieldsFilled)
        saveButton.setEnabled(allFieldsFilled)
    }
}

// MARK: - Conformation to UITableViewDelegate

extension ManageExpoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        filePickerTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Conformation to UITableViewDataSource

extension ManageExpoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        files.count + 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < files.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.selectFileCell.rawValue, for: indexPath) as! FileSelectorTableViewCell
            
            cell.pickMarkerLabel.text = files[indexPath.row].marker
            cell.pickModelLabel.text = files[indexPath.row].model
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.addModel.rawValue, for: indexPath)
            return cell
        }
    }
}

// MARK: - Cell identifiers

extension ManageExpoViewController {
    enum CellIdentifiers: String {
        case selectFileCell
        case addModel
    }
}
// MARK: - Conformation to UIImagePickerControllerDelegate
extension ManageExpoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showImagePicker() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        if let editedImage = info[.editedImage] as? UIImage {
//            titleImage.image = editedImage
//        } else if let originalImage = info[.originalImage] as? UIImage {
//            titleImage.image = editedImage
//        }
    }
}
