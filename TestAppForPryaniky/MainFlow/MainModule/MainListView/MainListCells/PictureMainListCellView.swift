//
//  PictureMainListCellView.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

final class PictureMainListCellView: UITableViewCell {
    
    static let reuseId = "PictureMainListCellView"
    
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

    func set(content: PictureType, textViewFrame: CGRect?) {
        pictureLabel.text = content.name
        pictureImageView.set(imageURL: content.data.url)
        pictureTextView.text = content.data.text
        pictureTextView.frame = textViewFrame ?? CGRect.zero
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
    
    let pictureLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.appFont(type: .avenirTitle)
        label.textAlignment = .center
        
        return label
    }()
    
    let pictureImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let pictureTextView: UITextView = {
        let textView = UITextView()
         textView.font = UIFont.appFont(type: .avenir)
         textView.isScrollEnabled = false
         textView.isSelectable = true
         textView.isUserInteractionEnabled = true
         textView.isEditable = false
//         textView.translatesAutoresizingMaskIntoConstraints = false
         
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
        containerView.addSubviews(views: [pictureLabel,
                                          pictureImageView,
                                          pictureTextView])
        
        // containerView constraints
        containerView.fillSuperview(padding: MainListConstants.containerViewInsets)
        
        let leftInset = MainListConstants.cellContentLeftInset
        let rightInset = MainListConstants.cellContentRightInset
        
        // pictureLabel constraints
        pictureLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: MainListConstants.titleLabelTopInset).isActive = true
        pictureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
        pictureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
        pictureLabel.heightAnchor.constraint(equalToConstant: MainListConstants.titleLabelHeight).isActive = true
        
        // pictureImageView
        pictureImageView.topAnchor.constraint(equalTo: pictureLabel.bottomAnchor, constant: MainListConstants.cellContentSpacing).isActive = true
        pictureImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: MainListConstants.pictureHeight).isActive = true
        
        // pictureTextView constraints
//        pictureTextView.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: MainListConstants.cellContentSpacing).isActive = true
//        pictureTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: leftInset).isActive = true
//        pictureTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -rightInset).isActive = true
//        pictureTextView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -MainListConstants.cellContentBottomInset).isActive = true
        
    }
    
}
