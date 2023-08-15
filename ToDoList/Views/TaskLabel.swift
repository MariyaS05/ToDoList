//
//  Label.swift
//  ToDoList
//
//  Created by Мария  on 7.08.23.
//

import UIKit

class TaskLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    convenience init(label: String){
        self.init(frame: .zero)
        text = label
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .title3)
    }
}
