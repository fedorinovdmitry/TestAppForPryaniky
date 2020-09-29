//
//  Presenter.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

protocol MainListPresenter: class {
    func configureView()
    
}

class MainListPresenterImpl: MainListPresenter {
    
    // MARK: - Custom types
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    
    private var mainListViewModel = MainListViewModel(content: [MainListContentModel]())
    
    // MARK: - Private Properties
    
    private weak var view: MainListViewControllerProtocol!
    
    private let networkService: MainModuleNetworkService = MainModuleNetworkServiceImpl()
    
    private let mainListCellsLayoutCalculator: MainListCellsLayoutCalculator = MainListCellsLayoutCalculatorImpl()
    
    // MARK: - Init
    
    required init(view: MainListViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - LifeStyle ViewController
    
    // MARK: - IBAction
    
    // MARK: - Public methods
    
    func configureView() {
        
        
        networkService.getMainList { [weak self] (mainResponce) in
            guard let mainResponce = mainResponce,
                  let self = self else {
                print("error responce")
                return
            }
            self.mainListViewModel = self.buildViewModel(responce: mainResponce)
            self.sendActualData()
        }
    }
    
    // MARK: - Private methods
    
    private func sendActualData() {
        view.setMainListViewModel(mainListViewModel: self.mainListViewModel)
    }
    
    private func buildViewModel(responce: MainResponce) -> MainListViewModel {
        let viewsArray = listBuilder(responce: responce)
        var mainListContentModelArray = [MainListContentModel]()
        for view in viewsArray {
            let cellSizes = mainListCellsLayoutCalculator.getCellSize(content: view)
            let contentModel = MainListContentModel(objectForCell: view, cellSize: cellSizes)
            mainListContentModelArray.append(contentModel)
        }

        let mainlistModel: MainListViewModel = MainListViewModel(content: mainListContentModelArray)
        return mainlistModel

    }
    
    private func listBuilder(responce: MainResponce) -> [CommonContentFromPryaniki] {
        var viewsArray = [CommonContentFromPryaniki]()
        let views = responce.view
        let content = responce.content
        for view in views {
            for type in content {
                if view.rawValue == type.name {
                    viewsArray.append(type)
                }
            }
        }
        return viewsArray
    }
    
    
    
}
