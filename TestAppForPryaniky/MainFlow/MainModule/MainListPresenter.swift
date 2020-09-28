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
    
    private var viewsArray = [CommonContentType]()
    
    // MARK: - Private Properties
    
    private weak var view: MainListViewControllerProtocol!
    private let networkService: MainModuleNetworkService = MainModuleNetworkServiceImpl()
    
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
            self.viewsArray = self.listBuilder(responce: mainResponce)
            
            self.sendActualData()
        }
    }
    
    
    // MARK: - Private methods
    
    private func sendActualData() {
        view.setMainList(mainList: viewsArray)
    }
    
    private func listBuilder(responce: MainResponce) -> [CommonContentType] {
        var viewsArray = [CommonContentType]()
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
    
    // MARK: - Navigation
    
}
