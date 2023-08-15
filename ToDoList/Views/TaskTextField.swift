//
//  TextField.swift
//  ToDoList
//
//  Created by Мария  on 7.08.23.
//

import UIKit

class TaskTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder =  placeholder
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius =  9
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        leftViewMode = .always
        textColor = .label
        tintColor = .label
        textAlignment = .left
        
        autocorrectionType = .no
        returnKeyType = .go
        clearButtonMode = .whileEditing
    }
}
