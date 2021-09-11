//
//  CustomView.swift
//  UIKitDemo
//
//  Created by Hoang Nguyen on 9/7/21.
//

import UIKit

class HeaderView: UIView {
    var title : UILabel = {
        let label = UILabel()
        label.text = "    Cooler Facility Risk Assessment"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    var text : UILabel = {
        let label = UILabel()
        label.text = "    Areas of Observation - please note concern(s) if any, as well as corrective action(s)"
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = UIColor.darkGray
        label.textColor = .white
        return label
    }()
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.stackView.addArrangedSubview(self.title)
        self.stackView.addArrangedSubview(self.text)
    }
}

protocol AssessmentOperationsDelegate {
    func finishedChanges()
}

class AssessmentOperationsView: UIView {
    
    var delegate: AssessmentOperationsDelegate?
    
    var saveBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Save Changes", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    var submitBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Final Submit", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    var stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addButtonsAction()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addButtonsAction()
        setupConstraints()
    }
    
    private func addButtonsAction() {
        self.saveBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)
        self.submitBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        self.stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.stackView.addArrangedSubview(self.saveBtn)
        self.stackView.addArrangedSubview(self.submitBtn)
    }
    
    @objc func buttonsPressed(sender: UIButton) {
        print("Save Button Pressed")
        delegate?.finishedChanges()
    }
}
