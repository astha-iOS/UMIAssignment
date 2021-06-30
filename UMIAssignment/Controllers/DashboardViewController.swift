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
        
        RestClient.sharedInstance.getMostPopularGitRepo(SUB_URL,page:page_number,per_page_count: PER_PAGE_COUNT, viewcontroller: self){ (dict) in
            if let response = dict {
                print(response)
                self.totalPageNo = response["total_count"] as? Int ?? 0
                if let itemsList = response["items"] as? [Dictionary<String,Any>] {
                    for repo in itemsList {
                        let modal = RepoModel.init(dict: repo)
                        self.repoList.append(modal)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            
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
