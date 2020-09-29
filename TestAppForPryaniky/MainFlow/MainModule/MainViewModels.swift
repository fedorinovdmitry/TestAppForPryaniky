//
//  MainViewModels.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 29.09.2020.
//

import UIKit

struct MainListViewModel {
    var content: [MainListContentModel]
}

struct MainListContentModel {
    var objectForCell: CommonContentFromPryaniki
    var cellSize: MainListCellSize
}

protocol MainListCellSize {
    var heightForCell: CGFloat { get }
    var textFieldFrame: CGRect? { get }
}
