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
    
    var filterData:[People] = []
    var dataInfo:People?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callViewDidLoad()
    }
    
    func callViewDidLoad(){
        self.viewModel.delegate(delegate: self)
        self.viewModel.getPeople()
        self.viewModel.getPhotos()
        self.configSearchBar()
    }
    
    
    func configSearchBar(){
        self.searchBar.delegate = self
        self.filterData = self.viewModel.data
        self.tableView.reloadData()
        self.searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
        self.searchBar.searchTextField.textColor = UIColor.white
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""{
            filterData = viewModel.data
            self.tableView.reloadData()
        } else{
            for people in viewModel.data {
                if people.name.contains(searchText){
                    filterData.append(people)
                    self.tableView.reloadData()
                }
            }
        }
        self.tableView.reloadData()
    }
    
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        tableView.reloadData()
        self.tableView.separatorColor = UIColor.white
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
        if filterData.isEmpty {
            return self.viewModel.data.count
        }else{
            return self.filterData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if filterData.isEmpty{
            let imageURLStrings = viewModel.data[indexPath.row].image
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
            cell?.setupCell(data: self.viewModel.loadData(indexPath: indexPath))
            cell?.configure(with: imageURLStrings)
            return cell ?? UITableViewCell()
        }else{
            let imageURLStrings = self.filterData[indexPath.row].image
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
            cell?.setupCell(data: filterData[indexPath.row])
            cell?.configure(with: imageURLStrings)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.dataInfo = self.filterData[indexPath.row]
            let storyBoard = UIStoryboard(name: "PersonViewController", bundle: nil)
            let vC = storyBoard.instantiateViewController(identifier: "PersonViewController")
            self.present(vC, animated: true, completion: nil)
        }
    
}
