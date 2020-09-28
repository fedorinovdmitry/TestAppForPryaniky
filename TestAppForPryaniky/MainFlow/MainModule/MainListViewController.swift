//
//  MainListViewController.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import UIKit

class MainListViewController: UIViewController {

    var tableView: UITableView {
        var tView = UITableView()
        tView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tView.dataSource = self
        tView.delegate = self
        tView.backgroundColor = UIColor.white
        
        tView.separatorStyle = .none
        tView.contentInset.top = 20
        
        tView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tView
    }
    
    var viewsArray = [CommonContentType]()
    let networkService: MainModuleNetworkService = MainModuleNetworkServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        
        networkService.getMainList { [weak self] (mainResponce) in
            guard let mainResponce = mainResponce,
                  let self = self else {
                print("error responce")
                return
            }
            self.viewsArray = self.listBuilder(responce: mainResponce)
            print(self.viewsArray)
        }
        
    }
    
    func listBuilder(responce: MainResponce) -> [CommonContentType] {
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
    

}

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewsArray[indexPath.row])
        
    }
    
}
