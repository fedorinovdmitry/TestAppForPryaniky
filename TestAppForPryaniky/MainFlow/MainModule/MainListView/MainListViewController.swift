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

class MainListViewController: UIViewController, CellPopoverDelegate {
    func showVC(vc: UIViewController) {
        present(vc, animated: true, completion: nil)
    }
    
    
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
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6634957194, blue: 0, alpha: 1)
    }
    
    // MARK: Setup TableView

    private func setupTable() {
        mainList = [CommonContentType]()
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
        return mainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch mainList[indexPath.row].name {
        case ContentType.hz.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: HzMainListCellView.reuseId, for: indexPath) as! HzMainListCellView
            cell.set(content: mainList[indexPath.row] as! SimpleType)
            return cell
        case ContentType.picture.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureMainListCellView.reuseId, for: indexPath) as! PictureMainListCellView
            cell.set(content: mainList[indexPath.row] as! PictureType)
            return cell
        case ContentType.selector.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectorMainListCellView.reuseId, for: indexPath) as! SelectorMainListCellView
            cell.set(content: mainList[indexPath.row] as! SelectorType)
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = mainList[indexPath.row].name
            cell.backgroundColor = .clear
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mainList[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
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
