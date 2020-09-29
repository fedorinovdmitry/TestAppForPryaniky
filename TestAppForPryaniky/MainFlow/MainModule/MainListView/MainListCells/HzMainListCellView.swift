//
//  HzMainListCellView.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

final class HzMainListCellView: UITableViewCell {
    
    static let reuseId = "HzMainListCellView"
    
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Set Data

    func set(content: SimpleType, textViewFrame: CGRect?) {
        hzLabel.text = content.name
        contentTextView.text = content.data.text
        contentTextView.frame = textViewFrame ?? CGRect.zero
        
    }
    
    // MARK: - Create Elements

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let hzLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.appFont(type: .avenirTitle)
        label.textAlignment = .center
        
        return label
    }()
    
    let contentTextView: UITextView = {
       let textView = UITextView()
        textView.font = UIFont.appFont(type: .avenir)
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        textView.backgroundColor = #colorLiteral(red: 0.9110719562, green: 0.9056561589, blue: 0.9152351022, alpha: 1)
        textView.layer.shadowOffset = CGSize(width: 2.5, height: 3)
        textView.clipsToBounds = false
        textView.layer.shadowOpacity = 0.2
        textView.layer.shadowColor = UIColor.black.cgColor
        
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    
    // MARK: - Constraints

    func setupConstraints() {
        addSubview(containerView)
        containerView.addSubviews(views: [hzLabel, contentTextView])
        
        let leftInset = MainListConstants.cellContentLeftInset
        let rightInset = MainListConstants.cellContentRightInset
        
        // containerView constraints
        containerView.fillSuperview(padding: MainListConstants.containerViewInsets)
        
        // hzLabel constraints
        hzLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: MainListConstants.titleLabelTopInset).isActive = true
        hzLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
        hzLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
        hzLabel.heightAnchor.constraint(equalToConstant: MainListConstants.titleLabelHeight).isActive = true
        
        // contentTextView constraints
        // this view support autosizing ... look in MainListCellsLayoutCalculator
        
    }
}
