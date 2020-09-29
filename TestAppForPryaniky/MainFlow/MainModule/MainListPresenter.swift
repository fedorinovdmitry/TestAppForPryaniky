//
//  Presenter.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import Foundation

///он как бы и презентер и как бы итерактор, может даже и вью модел))),а вообще решил не городить полноценную сложную архитектру для тестового задания, чтобы было проще в читаемости, так как кода не много, и это просто MVC, а это просто делегат, который выполняет бизнес логику для view controller
protocol MainListPresenter: class {
    func configureView()
}

class MainListPresenterImpl: MainListPresenter {
    
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
