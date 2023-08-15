//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Мария  on 7.08.23.
//
import UIKit
import CoreData

protocol TableViewCellProtocol: AnyObject {
    func checkButtonTapped(task:ToDoListItem,with cell: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    static var reuseIdentifier = "toDoCell"
    weak var delegate : TableViewCellProtocol?
    private var task: ToDoListItem?
    private let verticalLabelStack: UIStackView = {
        let stack =  UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints =  false
        return stack
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel : UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    private let contentLabel : UILabel = {
        let label = UILabel()
        label.font =  UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines  = 2
        return label
    }()
    
    private let checkButton: UIButton = {
        let check = UIButton()
        check.setImage(UIImage(systemName: "square"), for: .normal)
        check.setImage(UIImage(systemName: "checkmark.square"), for: .selected)
        check.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        check.translatesAutoresizingMaskIntoConstraints =  false
        return check
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        addConstraint()
    }
    
    func setFrom(task : ToDoListItem){
        nameLabel.text = task.name
        dateLabel.text = task.date
        contentLabel.text = task.content
        self.task =  task
        switch task.isCompleted {
        case true:
            checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        case false:
            checkButton.setImage(UIImage(systemName: "square"), for: .normal)
        case .none:
            return
        case .some(_):
            return
        }
    }
    
    private func addSubview(){
        contentView.addSubview(verticalLabelStack)
        verticalLabelStack.addArrangedSubview(nameLabel)
        verticalLabelStack.addArrangedSubview(contentLabel)
        verticalLabelStack.addArrangedSubview(dateLabel)
        contentView.addSubview(checkButton)
    }
    private func addConstraint() {
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: padding),
            checkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            checkButton.widthAnchor.constraint(equalToConstant: 30),
            checkButton.heightAnchor.constraint(equalToConstant: 30),
            
            verticalLabelStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            verticalLabelStack.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: padding),
            verticalLabelStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            verticalLabelStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func checkButtonTapped(){
        guard let task =  self.task else {
            return
        }
        delegate?.checkButtonTapped(task: task, with: self)
    }
}

