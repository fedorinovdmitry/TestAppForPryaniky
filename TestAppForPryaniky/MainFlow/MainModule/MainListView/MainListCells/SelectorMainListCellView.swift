//
//  SelectorMainListCellView.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

///делегат который будет показывать и закрывать список вариантов селектора
protocol CellPopoverDelegate: class {
    func showPopoverVC(vc: UIViewController)
    func closePopoverVC()
}

final class SelectorMainListCellView: UITableViewCell {
    
    static let reuseId = "SelectorMainListCellView"
    
    weak var delegate: CellPopoverDelegate? = nil
    
    private var content: SelectorType? = nil
    
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
        selectorPopVc.array = content?.data.variants ?? [Variant]()
        selectorPopVc.modalPresentationStyle = .popover
        selectorPopVc.delegate = self
        
        let popOver = selectorPopVc.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = self.selectorButton
        popOver?.sourceRect = CGRect(x: self.selectorButton.bounds.midX,
                                     y: self.selectorButton.bounds.maxY,
                                     width: 0,
                                     height: 0)
        selectorPopVc.preferredContentSize = CGSize(width: 250, height: 250)
        
        guard let delegate = delegate else {
            print("delegate nil")
            return
        }
        delegate.showPopoverVC(vc: selectorPopVc)
        
    }
    
    // MARK: - Set Data

    func set(content: SelectorType) {
        selectorLabel.text = content.name
        self.content = content
        
        let selectedId = content.data.selectedId
        for variant in content.data.variants {
            if variant.id == selectedId {
                selectorButton.setTitle(variant.text, for: .normal)
            }
        }
    }
    
    // MARK: - Create and set up Elements

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
        
        return label
    }()
    
    let selectorButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.appFont(type: .avenir)
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
        
        let leftInset = MainListConstants.cellContentLeftInset
        let rightInset = MainListConstants.cellContentRightInset
        
        // selectorLabel constraints
        selectorLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: MainListConstants.titleLabelTopInset).isActive = true
        selectorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
        selectorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
        selectorLabel.heightAnchor.constraint(equalToConstant: MainListConstants.titleLabelHeight).isActive = true
        
        // selectorButton constraints
        selectorButton.topAnchor.constraint(equalTo: selectorLabel.bottomAnchor, constant: MainListConstants.cellContentSpacing).isActive = true
        selectorButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
        selectorButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
        selectorButton.heightAnchor.constraint(equalToConstant: MainListConstants.selectorButtonHeight).isActive = true
        
    }
}


// MARK: - Extension

// MARK: - UIPopoverPresentationControllerDelegate

extension SelectorMainListCellView: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

// MARK: - PopTableEventDelegate

extension SelectorMainListCellView: PopTableEventDelegate {
    func dismissWith(variant: Variant) {
        selectorButton.setTitle(variant.text, for: .normal)
        delegate?.closePopoverVC()
    }
}
