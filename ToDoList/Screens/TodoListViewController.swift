//
//  TodoListViewController.swift
//  ToDoList
//
//  Created by Мария  on 7.08.23.
//

import UIKit

class TodoListViewController: UIViewController {
    var storage = Storage()
    
    private lazy var tasksTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate =  self
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var noTaskLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints =  false
        label.text = "No tasks yet."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    var tasks = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addConstraint()
        checkTasks()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavController()
        checkTasks()
    }
    
    private func configureNavController(){
        self.view.backgroundColor = .systemBackground
        title = "ToDoList"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
    }
    
    @objc func addNew() {
        let newVC = NewTaskViewController()
        navigationController?.pushViewController(newVC, animated: true)
        newVC.completionHandler = { [weak self] in
            self?.refresh()
        }
    }
    
    private func configure() {
        tasks = storage.getAllTasks()
        view.addSubview(tasksTableView)
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            tasksTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tasksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tasksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tasksTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func refresh() {
        tasks = storage.getAllTasks()
        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }
    }
    
    private func checkTasks() {
        if tasks.isEmpty {
            view.addSubview(noTaskLabel)
            NSLayoutConstraint.activate([
                noTaskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                noTaskLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                noTaskLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
                noTaskLabel.heightAnchor.constraint(equalToConstant: 40)
            ])
        }else {
            noTaskLabel.removeFromSuperview()
        }
    }
}


// MARK: TableView Protocols
extension TodoListViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.reuseIdentifier) as? TaskTableViewCell else {return UITableViewCell()}
        cell.setFrom(task: tasks[indexPath.row])
        cell.delegate =  self
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            storage.deleteTask(task: tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            self.tasksTableView.deleteRows(at: [indexPath], with: .automatic)
            checkTasks()
        }
    }
}

extension TodoListViewController : TableViewCellProtocol {
    func checkButtonTapped(task: ToDoListItem, with cell: TaskTableViewCell) {
        guard let indexPath = tasksTableView.indexPath(for: cell) else {
            return
        }
        let task = tasks[indexPath.row]
        guard let isCompleted = task.isCompleted else {return}
        storage.update(task: task, isCompleted: !isCompleted.boolValue as NSNumber)
        DispatchQueue.main.async {
            self.tasksTableView.reloadData()
        }
    }
}
