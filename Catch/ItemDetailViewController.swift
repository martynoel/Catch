//
//  ItemDetailViewController.swift
//  Catch
//
//  Created by Mimi Chenyao on 4/12/18.
//  Copyright © 2018 Mimi Chenyao. All rights reserved.
//
import UIKit

class ItemDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // MARK: Properties
    
    let itemStore = ItemStore.sharedInstance
    var item: Item!
    var itemImage: UIImage!
    var itemName: String!
    var dateAddedString = "<DATE>"
    var dateLastWornString = "<DATE>"
    
    // Describes states of buttons so that they can change color when pressed
    // 0 = unclicked
    // 1 = clicked
    var changePhotoButtonState = 0
    var cancelButtonState = 0
    var updateDateLastWornButtonState = 0
    
    // MARK: View instantiations by closure
    
    let scrollView: UIScrollView = {
        
        let scrolly = UIScrollView()
        
        scrolly.translatesAutoresizingMaskIntoConstraints = false
        
        return scrolly
    }()
    
    let contentView: UIView = {
        
        let content = UIView()
        
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    let itemImageView: UIImageView = {
        
        let itemImage = UIImage(named: "fadedCatchLogo_frame")
        let imageView = UIImageView(image: itemImage!)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Name:"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let nameTextField: UITextField = {
        
        let textField = UITextField()
        
        textField.placeholder = "What's your item called?"
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 10), for: .horizontal)
        
        return textField
    }()
    
    var nameStackView: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let dateLastWornLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dateAddedLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let changePhotoButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Change Photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let updateDateLastWornButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        button.setTitle("Update Date Last Worn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        button.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(updateDateLastWornButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    let cancelButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: View lifecycle methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavBar()
        
        itemImage = item.image
        
        view.backgroundColor = .white
        
        nameTextField.delegate = self
        
        view.addSubview(scrollView)
        
        setUpDateInfo()
        setUpScrollView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        // Clear first responder when user presses "back"
        view.endEditing(true)
        
        // TODO: Get item image too
        itemName = itemName ?? "New Item"
    }
    
    // MARK: View setup methods
    
    func setUpScrollView() {
        
        scrollView.addSubview(contentView)
        
        setUpContentView()
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func setUpContentView() {
        
        contentView.addSubview(itemImageView)
        contentView.addSubview(nameStackView)
        contentView.addSubview(dateLastWornLabel)
        contentView.addSubview(dateAddedLabel)
        contentView.addSubview(changePhotoButton)
        contentView.addSubview(updateDateLastWornButton)
        contentView.addSubview(cancelButton)
        
        setUpItemImageView()
        setUpNameStackView()
        setUpDateLastWornLabel()
        setUpDateAddedLabel()
        setUpChangePhotoButton()
        setUpUpdateDateLastWornButton()
        setUpCancelButton()
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func setUpNavBar() {
        self.navigationItem.title = item.name
        
        // Create and set right bar button item to "save"
        let saveItemButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = saveItemButton
    }
    
    func setUpItemImageView() {
        
        itemImageView.image = item.image
        
        itemImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        itemImageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    func setUpNameStackView() {
        
        nameTextField.placeholder = item.name
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        nameStackView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 20).isActive = true
        nameStackView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        nameStackView.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, constant: 15).isActive = true
    }
    
    func setUpDateLastWornLabel() {
        
        dateLastWornLabel.text = "Date Last Worn: \(dateLastWornString)"
        
        dateLastWornLabel.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 10).isActive = true
        dateLastWornLabel.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor).isActive = true
    }
    
    func setUpDateAddedLabel() {
        
        dateAddedLabel.text = "Date Added: \(dateAddedString)"
        
        dateAddedLabel.topAnchor.constraint(equalTo: dateLastWornLabel.bottomAnchor, constant: 3).isActive = true
        dateAddedLabel.leadingAnchor.constraint(equalTo: dateLastWornLabel.leadingAnchor).isActive = true
    }
    
    func setUpChangePhotoButton() {
        
        changePhotoButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        changePhotoButton.topAnchor.constraint(equalTo: dateAddedLabel.bottomAnchor, constant: 20).isActive = true
        changePhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        changePhotoButton.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, constant: -60).isActive = true
    }
    
    func setUpUpdateDateLastWornButton() {
        
        updateDateLastWornButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        updateDateLastWornButton.topAnchor.constraint(equalTo: changePhotoButton.bottomAnchor, constant: 5).isActive = true
        updateDateLastWornButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        updateDateLastWornButton.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, constant: -60).isActive = true
        
    }
    
    func setUpCancelButton() {
        
        cancelButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cancelButton.topAnchor.constraint(equalTo: updateDateLastWornButton.bottomAnchor, constant: 5).isActive = true
    }
    
    // MARK: Action methods
    
    @objc func changePhotoButtonPressed() {
        
        if changePhotoButtonState == 0 {
            changePhotoButtonState = 1
            changePhotoButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1)
        }
        else {
            changePhotoButtonState = 0
            changePhotoButton.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        }
        
        let alertController = UIAlertController(title: "Choose Photo Source", message: nil, preferredStyle: .actionSheet)
        
        // Check if device has camera before presenting camera as an option
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let chooseCameraAction = UIAlertAction(title: "Camera", style: .default) { (_) in
                
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(chooseCameraAction)
        }
        
        let choosePhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (_) in
            
            let imagePicker = self.imagePicker(for: .photoLibrary)
            
            // Apple wants photo library to be presented in popover, so be it ...
            if let popoverController = alertController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(choosePhotoLibraryAction)
        
        let chooseCancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(chooseCancelAction)
        
        // For iPad: this is where notifications pop up
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    // Dismisses first responder when user taps anywhere on screen
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    
    @objc func updateDateLastWornButtonPressed() {
        
        // Update date
        item.updateDateLastWorn()
        dateLastWornLabel.text = "Date Last Worn: \(item.dateLastWornString)"
        
        // Update visual indicators
        if updateDateLastWornButtonState == 0 {
            updateDateLastWornButtonState = 1
            updateDateLastWornButton.backgroundColor = UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1)
        }
        else {
            updateDateLastWornButtonState = 0
            updateDateLastWornButton.backgroundColor = UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1)
        }
    }
    
    @objc func cancelButtonPressed() {
        
        if cancelButtonState == 0 {
            cancelButtonState = 1
            cancelButton.setTitleColor(UIColor(red: 255/255, green: 127/255, blue: 102/255, alpha: 1), for: .normal)
        }
        else {
            cancelButtonState = 0
            cancelButton.setTitleColor(UIColor(red: 251/255, green: 62/255, blue: 24/255, alpha: 1), for: .normal)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveItem() {
        
        let saveAlert = UIAlertController(title: "Save Item?", message: "Are you sure you want to save this item? You can always edit it later.", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (saveItem) in
            
            // Saving an item
            if self.nameTextField.text != nil {
                self.itemName = self.nameTextField.text
            }
            else {
                self.itemName = "New Item"
            }
            self.item.name = self.itemName
            
            // Change user entered info is saved into data model
            self.item.image = self.itemImage
            self.item.dateLastWornString = self.dateLastWornString
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (clickCancel) in
            
            self.navigationController?.popViewController(animated: true)
        }
        
        saveAlert.addAction(saveAction)
        saveAlert.addAction(cancelAction)
        
        self.present(saveAlert, animated: true, completion: nil)
    }
    
    // MARK: Delegate methods
    
    // Text field delegate
    
    // Dismisses first responder when user taps Return key on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // Image picker delegate
    
    // Selects source of image picker
    func imagePicker(for sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        return imagePicker
    }
    
    // Called after photo has been selected
    // Adds photo to image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // Get image & put on image button
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Resize images properly
        let resizedImage = resizeImage(image: image)
        itemImage = resizedImage
        
        itemImageView.image = resizedImage
        
        // Dismiss image picker controller
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helper methods
    
    // Helper method to resize user-picked image to fit image button
    // Resizes to 500px x 500px
    func resizeImage(image: UIImage) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 500, height: 500))
        image.draw(in: CGRect(x: 0, y: 0, width: 500, height: 500))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
    
    func setUpDateInfo() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let dateAdded = Date()
        let dateLastWorn = Date()
        
        dateAddedString = dateFormatter.string(from: dateAdded)
        dateLastWornString = dateFormatter.string(from: dateLastWorn)
    }
}
