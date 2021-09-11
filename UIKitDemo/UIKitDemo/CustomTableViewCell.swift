//
//  CustomTableViewCell.swift
//  UIKitDemo
//
//  Created by Hoang Nguyen on 9/7/21.
//

import UIKit

protocol CellDelegate {
    func updateCellHeight()
}

class CustomTableViewCell: UITableViewCell {
    
    var delegate : CellDelegate?
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userComment : UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addNoteBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "AddNoteImage"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 0
        return button
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0).cgColor
        stackView.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        stackView.layer.cornerRadius = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let acceptableBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Acceptable", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag = 1
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let unacceptableBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Unacceptable", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.tag = 2
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let naBtn : UIButton = {
        let button = UIButton()
        button.setTitle("N/A", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
        button.setTitleColor(.black, for: .normal)
        button.tag = 3
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentTextField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = UIFont.systemFont(ofSize: 20)
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addButtonsAction()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func addButtonsAction() {
        self.addNoteBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)
        self.acceptableBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)
        self.unacceptableBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)
        self.naBtn.addTarget(self, action: #selector(buttonsPressed(sender:)), for: .touchUpInside)

    }
    
    private func setupConstraints() {
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.addNoteBtn)
        self.contentView.addSubview(self.buttonsStackView)
        
        self.title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
        self.title.trailingAnchor.constraint(equalTo: self.addNoteBtn.leadingAnchor).isActive = true
        self.title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.addNoteBtn.trailingAnchor.constraint(equalTo: self.buttonsStackView.leadingAnchor, constant: -2).isActive = true
        self.addNoteBtn.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.addNoteBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.addNoteBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.contentView.addSubview(self.buttonsStackView)
        self.buttonsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5).isActive = true
        self.buttonsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
        self.buttonsStackView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        self.buttonsStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        for count in 1 ... 3 {
            if self.buttonsStackView.arrangedSubviews.count > 0 {
                let separator = UIView()
                separator.backgroundColor = .lightGray
                separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
                self.buttonsStackView.addArrangedSubview(separator)
                separator.heightAnchor.constraint(equalTo: self.buttonsStackView.heightAnchor, multiplier: 0.7).isActive = true
            }
            
            if count == 1 {
                self.buttonsStackView.addArrangedSubview(self.acceptableBtn)
                self.acceptableBtn.heightAnchor.constraint(equalTo: self.buttonsStackView.heightAnchor).isActive = true
            } else if count == 2 {
                self.buttonsStackView.addArrangedSubview(self.unacceptableBtn)
                self.unacceptableBtn.widthAnchor.constraint(equalTo: self.acceptableBtn.widthAnchor).isActive = true
                self.unacceptableBtn.heightAnchor.constraint(equalTo: self.buttonsStackView.heightAnchor).isActive = true
            } else {
                self.buttonsStackView.addArrangedSubview(self.naBtn)
                self.naBtn.widthAnchor.constraint(equalTo: self.acceptableBtn.widthAnchor).isActive = true
                self.naBtn.heightAnchor.constraint(equalTo: self.buttonsStackView.heightAnchor).isActive = true
            }
        }
    }
    
    @objc func buttonsPressed(sender: UIButton) {
        switch sender.tag {
        case 0:
            presentCommentTextField()
        case 1:
            self.acceptableBtn.backgroundColor = .systemGreen
            self.acceptableBtn.setTitleColor(.white, for: .normal)
            self.unacceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.unacceptableBtn.setTitleColor(.black, for: .normal)
            self.naBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.naBtn.setTitleColor(.black, for: .normal)
        case 2:
            self.acceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.acceptableBtn.setTitleColor(.black, for: .normal)
            self.unacceptableBtn.backgroundColor = .systemRed
            self.unacceptableBtn.setTitleColor(.white, for: .normal)
            self.naBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.naBtn.setTitleColor(.black, for: .normal)
        case 3:
            self.acceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.acceptableBtn.setTitleColor(.black, for: .normal)
            self.unacceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.unacceptableBtn.setTitleColor(.black, for: .normal)
            self.naBtn.backgroundColor = .systemGray
            self.naBtn.setTitleColor(.white, for: .normal)
        default:
            self.acceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.acceptableBtn.setTitleColor(.black, for: .normal)
            self.unacceptableBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.unacceptableBtn.setTitleColor(.black, for: .normal)
            self.naBtn.backgroundColor = UIColor(red: 0.84, green: 0.84, blue: 0.84, alpha: 1.0)
            self.unacceptableBtn.setTitleColor(.black, for: .normal)
        }
    }
    
    private func presentCommentTextField() {
        if commentTextField.isHidden {
            if !self.userComment.isHidden {
                self.userComment.isHidden = true
                self.contentView.willRemoveSubview(self.userComment)
                self.userComment.removeFromSuperview()
            }
            self.contentView.addSubview(self.commentTextField)
            self.commentTextField.isHidden = false
            self.commentTextField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
            self.commentTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
            self.commentTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.commentTextField.topAnchor.constraint(equalTo: self.addNoteBtn.bottomAnchor, constant: 5).isActive = true
            self.addNoteBtn.setBackgroundImage(UIImage(named: "DeleteImage"), for: .normal)
            self.commentTextField.delegate = self
            delegate?.updateCellHeight()
        } else if self.userComment.isHidden && self.commentTextField.text?.count ?? 0 > 0{
            self.commentTextField.isHidden = true
            self.contentView.willRemoveSubview(self.commentTextField)
            self.commentTextField.removeFromSuperview()
            self.addNoteBtn.setBackgroundImage(UIImage(named: "AddNoteImage"), for: .normal)
            
            self.contentView.addSubview(self.userComment)
            self.userComment.isHidden = false
            self.userComment.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5).isActive = true
            self.userComment.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5).isActive = true
            self.userComment.topAnchor.constraint(equalTo: self.addNoteBtn.bottomAnchor, constant: 10).isActive = true
            self.userComment.text = "Hoang Nguyen on \(getTimestamp()): \(self.commentTextField.text ?? "")"
        } else {
            self.commentTextField.isHidden = true
            self.contentView.willRemoveSubview(self.commentTextField)
            self.commentTextField.removeFromSuperview()
            self.addNoteBtn.setBackgroundImage(UIImage(named: "AddNoteImage"), for: .normal)
            delegate?.updateCellHeight()
        }

    }
    
    private func getTimestamp() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm/dd/yyyy"
        return dateFormatter.string(from: Date())
    }
}

extension CustomTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.commentTextField.resignFirstResponder()
        return true
    }
}
