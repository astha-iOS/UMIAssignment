//
//  DashboardViewController.swift
//  UMIAssignment
//
//  Created by Astha yadav on 28/06/21.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var page = 1
    var totalPageNo = Int()
    var repoList = [RepoModel]()
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMostPopularGitRepoApiCall(page_number: page)
        
    }
    
    //MARK:- getMostPopularGitRepoApiCall
    func getMostPopularGitRepoApiCall(page_number:Int){
        let pageRequest = PageRequestModel (pageNumber: page, pageSize: PAGE_SIZE)
        
        RestClient.sharedInstance.getMostPopularGitRepo(pageRequest: pageRequest, viewcontroller: self){ (repoSearchModel) in
            
            self.repoList.append(contentsOf: repoSearchModel!.repoItems)
            self.totalPageNo = repoSearchModel!.totalRepo

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }
    
}

//MARK:- UITableViewDelegate,UITableViewDataSource
extension DashboardViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardTableCell") as! DashboardTableCell
        
        cell.configure(with: repoList[indexPath.row],indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = repoList[indexPath.row]
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            // vc.repoDict = repoList[indexPath.row]
        vc.detailURL = obj.detail_url
        self.navigationController?.pushViewController(vc, animated: false)
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (self.repoList.count-2) == indexPath.row && totalPageNo > page{
            page = page + 1
            getMostPopularGitRepoApiCall(page_number: page)
        }
        
    }
    
}
