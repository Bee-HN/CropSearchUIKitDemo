//
//  RiskAssessmentViewController.swift
//  UIKitDemo
//
//  Created by Hoang Nguyen on 9/7/21.
//

import UIKit

class RiskAssessmentViewController: UIViewController {

    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let operationView = AssessmentOperationsView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var dataSource = ["Surrounding Areas / Adjacent Activities", "Building Grounds", "Building Structure", "Water System", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.view.backgroundColor = .white
        

        headerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerView)
        headerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        operationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(operationView)
        operationView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        operationView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        operationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        operationView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        operationView.delegate = self
        
        self.tableView.rowHeight = 50
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: operationView.topAnchor, constant: -5).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

extension RiskAssessmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomTableViewCell
        cell.title.text = dataSource[indexPath.row]
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
        }
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

extension RiskAssessmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else {
            return 50
        }
        if cell.commentTextField.isHidden {
            return 50
        } else {
            return 90
        }
    }
}

extension RiskAssessmentViewController: CellDelegate {
    func updateCellHeight() {
        self.tableView.delegate = self
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
}

extension RiskAssessmentViewController: AssessmentOperationsDelegate {
    func finishedChanges() {
        headerView.text.backgroundColor = .systemGreen
    }
}
