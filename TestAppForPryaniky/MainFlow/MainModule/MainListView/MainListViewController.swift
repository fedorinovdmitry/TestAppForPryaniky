//
//  MainListViewController.swift
//  TestAppForPryaniky
//
//  Created by Дмитрий Федоринов on 28.09.2020.
//

import UIKit

protocol MainListViewControllerProtocol: class {
    func setMainListViewModel(mainListViewModel: MainListViewModel)
}

class MainListViewController: UIViewController {
    
    
    // MARK: - Public Properties
    
    var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var presenter: MainListPresenter!
    
    private var mainListViewModel: MainListViewModel!
    
    private weak var popoverVC: UIViewController? = nil
    
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
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6634957194, blue: 0, alpha: 1)
    }
    
    // MARK: Setup TableView

    private func setupTable() {
        mainListViewModel = MainListViewModel(content: [MainListContentModel]())
        tableView = UITableView()
        
        let topInset: CGFloat = 8
        tableView.contentInset.top = topInset
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(HzMainListCellView.self, forCellReuseIdentifier: HzMainListCellView.reuseId)
        tableView.register(PictureMainListCellView.self, forCellReuseIdentifier: PictureMainListCellView.reuseId)
        tableView.register(SelectorMainListCellView.self, forCellReuseIdentifier: SelectorMainListCellView.reuseId)
        
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    

}

// MARK: - Extensions

// MARK: - MainListViewControllerProtocol

extension MainListViewController: MainListViewControllerProtocol {
    func setMainListViewModel(mainListViewModel: MainListViewModel) {
        DispatchQueue.main.async {
            self.mainListViewModel = mainListViewModel
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
        return mainListViewModel.content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellContent = mainListViewModel.content[indexPath.row].objectForCell
        
        switch cellContent.type {
        case .hz:
            let cell = tableView.dequeueReusableCell(withIdentifier: HzMainListCellView.reuseId, for: indexPath) as! HzMainListCellView
            cell.set(content: cellContent as! SimpleType, textViewFrame: mainListViewModel.content[indexPath.row].cellSize.textFieldFrame)
            return cell
        case .picture:
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureMainListCellView.reuseId, for: indexPath) as! PictureMainListCellView
            cell.set(content: cellContent as! PictureType, textViewFrame: mainListViewModel.content[indexPath.row].cellSize.textFieldFrame)
            return cell
        case .selector:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectorMainListCellView.reuseId, for: indexPath) as! SelectorMainListCellView
            cell.set(content: cellContent as! SelectorType)
            cell.delegate = self
            return cell
        case .unknown:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = cellContent.name
            cell.backgroundColor = .clear
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mainListViewModel.content[indexPath.row].objectForCell.name)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return mainListViewModel.content[indexPath.row].cellSize.heightForCell
    }
    
}


// MARK: - CellPopoverDelegate

extension MainListViewController: CellPopoverDelegate {
    func showPopoverVC(vc: UIViewController) {
        present(vc, animated: true, completion: nil)
        popoverVC = vc
    }
    
    func closePopoverVC() {
        popoverVC?.dismiss(animated: true, completion: nil)
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
