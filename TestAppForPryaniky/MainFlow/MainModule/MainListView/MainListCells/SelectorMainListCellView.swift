//
//  SelectorMainListCellView.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

protocol CellPopoverDelegate: class {
    func showVC(vc: UIViewController)
    
}

final class SelectorMainListCellView: UITableViewCell {
    
    static let reuseId = "SelectorMainListCellView"
    
    weak var delegate: CellPopoverDelegate? = nil
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        selectorButton.addTarget(self, action: #selector(selectorButtonTouch), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectorButtonTouch() {
        let selectorPopVc = SelectorPopTableTableViewController()
        selectorPopVc.modalPresentationStyle = .popover
        
        let popOver = selectorPopVc.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = self.selectorButton
        popOver?.sourceRect = CGRect(x: self.selectorButton.bounds.midX, y: self.selectorButton.bounds.maxY, width: 0, height: 0)
        selectorPopVc.preferredContentSize = CGSize(width: 250, height: 250)
        
        guard let delegate = delegate else {
            print("delegate nil")
            return
        }
        delegate.showVC(vc: selectorPopVc)
        
        print("gg")
    }
    
    // MARK: - Set Data

    func set(content: SelectorType) {
        selectorLabel.text = content.name
        selectorButton.setTitle(content.name, for: .normal)
        
    }
    
    // MARK: - Create Elements

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8600171233)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let selectorLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.appFont(type: .avenirTitle)
        label.textAlignment = .center
        
        label.backgroundColor = .yellow
        
        return label
    }()
    
    let selectorButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.appFont(type: .avenirAnd(customScale: 1.3))
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit

        button.backgroundColor = #colorLiteral(red: 0.9110719562, green: 0.9056561589, blue: 0.9152351022, alpha: 1)
        
        button.layer.shadowOffset = CGSize(width: 2.5, height: 3)
        button.clipsToBounds = false
        button.layer.shadowOpacity = 0.2
        button.layer.shadowColor = UIColor.black.cgColor

        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()
    
    // MARK: - Constraints

    func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubviews(views: [selectorLabel,
                                          selectorButton])
        
        // containerView constraints
        containerView.fillSuperview(padding: MainListConstants.containerViewInsets)
        
        // selectorLabel constraints
        selectorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        selectorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        selectorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        selectorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // selectorButton constraints
        selectorButton.topAnchor.constraint(equalTo: selectorLabel.bottomAnchor, constant: 15).isActive = true
        selectorButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        selectorButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        selectorButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}


// MARK: - Extension

extension SelectorMainListCellView: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

