//
//  MainListViewController.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import UIKit

protocol MainListViewControllerProtocol: class {
    func setMainList(mainList: [CommonContentType])
}

class MainListViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var presenter: MainListPresenter!
    private var mainList: [CommonContentType]!
    
    
    // MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter = MainListPresenterImpl(view: self)
        presenter.configureView()
        
    }
    
    // MARK: - Public methods
    
    
    // MARK: - Private methods
    
    private func setupViews() {
        setupTable()
        
        setupView()
        
        setupConstraints()
    }
    
    
    // MARK: Setup View
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: Setup TableView

    private func setupTable() {
        mainList = [CommonContentType]()
        tableView = UITableView()
        
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    

}

// MARK: - Extensions

// MARK: - MainListViewControllerProtocol

extension MainListViewController: MainListViewControllerProtocol {
    
    func setMainList(mainList: [CommonContentType]) {
        DispatchQueue.main.async {
            self.mainList = mainList
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(mainList.count)
        return mainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(mainList[indexPath.row].name)
        cell.textLabel?.text = mainList[indexPath.row].name
        cell.backgroundColor = .orange
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mainList[indexPath.row])
        
    }
    
}

// MARK: - SwiftUI

import SwiftUI

struct MainListViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    struct ContainerView: UIViewControllerRepresentable {
        typealias UIViewControllerType = MainListViewController
        let viewController = MainListViewController()
        func makeUIViewController(context: Context) -> MainListViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: MainListViewController, context: Context) {}
    }
}
