//
//  ViewController.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel:ViewModel = ViewModel()
    let tableViewCell:TableViewCell = TableViewCell()
    let service:Service = Service()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate(delegate: self)
        self.viewModel.getPeople()
        self.viewModel.getPhotos()
        self.searchBar.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.layer.filters = 
    }

    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        tableView.reloadData()
        self.tableView.separatorColor = UIColor.black
        self.tableView.separatorStyle = .singleLine
    }
}

extension ViewController:ViewModelDelegate{
    func success() {
        DispatchQueue.main.async {
            self.configTableView()
            self.tableView.reloadData()
        }
    }
    func error() {
        print("Erro ao carregar tableView")
    }
}

extension ViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.rowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageURLStrings = viewModel.data[indexPath.row].image
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        cell?.setupCell(data: self.viewModel.loadData(indexPath: indexPath))
        cell?.configure(with: imageURLStrings)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRow
    }
    
}
