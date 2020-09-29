//
//  MainListCellsLayoutCalculator.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

protocol MainListCellsLayoutCalculator {
    func getCellSize(content: CommonContentFromPryaniki) -> MainListCellSize
}

final class MainListCellsLayoutCalculatorImpl: MainListCellsLayoutCalculator {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    struct Size: MainListCellSize {
        
        var heightForCell: CGFloat
        var textFieldFrame: CGRect?
    }
    
    // MARK: - Calculate Sizes
    
    func getCellSize(content: CommonContentFromPryaniki) -> MainListCellSize {

        switch content.type {
        case .hz:
            return getHzCellSize(content as! SimpleType)
        case .picture:
            return getPictureCellSize(content as! PictureType)
        case .selector:
            return getSelectorCellSize(content as! SelectorType)
        case .unknown:
            return Size(heightForCell: 0, textFieldFrame: nil)
        }

    }
    
    // MARK: Calculate HzCellSize

    private func getHzCellSize(_ hzContent: SimpleType) -> MainListCellSize {

        let containerWidth = screenWidth - MainListConstants.containerViewInsets.left - MainListConstants.containerViewInsets.right

        let textViewFrameX = MainListConstants.cellContentLeftInset
        let textViewFrameY = MainListConstants.titleLabelTopInset + MainListConstants.titleLabelHeight + MainListConstants.cellContentSpacing
        var textViewFrame = CGRect(origin: CGPoint(x: textViewFrameX,
                                                   y: textViewFrameY),
                                   size: CGSize.zero)
        
        let text = hzContent.data.text
        if !text.isEmpty {
            let width = containerWidth - MainListConstants.cellContentLeftInset - MainListConstants.cellContentRightInset
            
            let height = text.height(width: width, font: UIFont.appFont(type: .avenir))
            
            textViewFrame.size = CGSize(width: width, height: height)
        }
        
        let cellHeight: CGFloat = textViewFrame.maxY + MainListConstants.cellContentBottomInset + MainListConstants.containerViewInsets.bottom
        
        return Size(heightForCell: cellHeight, textFieldFrame: textViewFrame)

    }

    // MARK: Calculate PictureCellSize

    private func getPictureCellSize(_ pictureContent: PictureType) -> MainListCellSize {

        let containerWidth = screenWidth - MainListConstants.containerViewInsets.left - MainListConstants.containerViewInsets.right

        let textViewFrameX = MainListConstants.cellContentLeftInset
        let textViewFrameY = MainListConstants.titleLabelTopInset + MainListConstants.titleLabelHeight + MainListConstants.cellContentSpacing + MainListConstants.pictureHeight + MainListConstants.cellContentSpacing
        var textViewFrame = CGRect(origin: CGPoint(x: textViewFrameX,
                                                   y: textViewFrameY),
                                   size: CGSize.zero)

        let text = pictureContent.data.text
        if !text.isEmpty {
            let width = containerWidth - MainListConstants.cellContentLeftInset - MainListConstants.cellContentRightInset
            
            let height = text.height(width: width, font: UIFont.appFont(type: .avenir))
            
            textViewFrame.size = CGSize(width: width, height: height)
        }
        
        let cellHeight: CGFloat = textViewFrame.maxY + MainListConstants.cellContentBottomInset + MainListConstants.containerViewInsets.bottom
        
        return Size(heightForCell: cellHeight, textFieldFrame: textViewFrame)
    }

    // MARK: Calculate SelectorCellSize

    private func getSelectorCellSize(_ selectorContent: SelectorType) -> MainListCellSize {

        let cellHeight: CGFloat = MainListConstants.titleLabelTopInset + MainListConstants.titleLabelHeight + MainListConstants.cellContentSpacing + MainListConstants.selectorButtonHeight + MainListConstants.cellContentBottomInset + MainListConstants.containerViewInsets.bottom

        return Size(heightForCell: cellHeight, textFieldFrame: nil)
    }
    
}
