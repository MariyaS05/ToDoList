//
//  NewTaskViewController.swift
//  ToDoList
//
//  Created by Мария  on 7.08.23.
//

import UIKit

class NewTaskViewController: UIViewController {
    var storage = Storage()
    let titleLabel =  TaskLabel(label: "Task")
    let contentLabel = TaskLabel(label: "Content")
    let titleTextField =  TaskTextField(placeholder: "Enter the title of the task")
    let contentTextField =  TaskTextField(placeholder: "Enter your task")
    let dateLabel =  TaskLabel(label: "Date")
    
    let date : UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = .date
        date.calendar = .current
        date.preferredDatePickerStyle = .compact
        date.minimumDate = .now
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let time : UIDatePicker = {
        let time = UIDatePicker()
        time.datePickerMode = .time
        time.locale = Locale(identifier: "en_gb")
        time.preferredDatePickerStyle = .inline
        time.translatesAutoresizingMaskIntoConstraints =  false
        return time
    }()
    
    var isTitleLabelEntered : Bool { return !titleTextField.text!.isEmpty}
    
    public var completionHandler : (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        addSubview()
        addConstraint()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chekTextfield()
    }
    
    private func configureNavBar() {
        title = "New task"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(createTask))
        
    }
    private func chekTextfield() {
        titleTextField.delegate =  self
        guard isTitleLabelEntered else {
            navigationItem.rightBarButtonItem?.tintColor = .gray
            return
        }
        navigationItem.rightBarButtonItem?.tintColor = .red
    }
    
    //    MARK: Set constraints
    private func addSubview() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
        view.addSubview(dateLabel)
        view.addSubview(date)
        view.addSubview(time)
    }
    
    private func addConstraint(){
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding/2),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            contentLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: padding),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            contentLabel.heightAnchor.constraint(equalToConstant: 30),
            
            contentTextField.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: padding/2),
            contentTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            contentTextField.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.topAnchor.constraint(equalTo: contentTextField.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            
            date.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding/2),
            date.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            date.widthAnchor.constraint(equalToConstant: 150),
            date.heightAnchor.constraint(equalToConstant: 50),
            
            time.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding/2),
            time.leadingAnchor.constraint(equalTo: date.trailingAnchor),
            time.widthAnchor.constraint(equalToConstant: 100),
            time.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func createTask(){
        guard let titleTextfieldText = titleTextField.text else {return}
        guard let contentTextfieldText =  contentTextField.text else {return}
        let date = date.date
        let time  =  time.date
        let timeString = date.convertToDayMonthYearFormat()+" "+time.convertToHourMinute()
        storage.createTask(name: titleTextfieldText, date: timeString, content: contentTextfieldText,isCompleted: NSNumber(value: false))
        completionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension NewTaskViewController : UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        chekTextfield()
    }
}
