//
//  DetailViewController.swift
//  UMIAssignment
//
//  Created by Astha yadav on 29/06/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    var repoDict:RepoModel?
    var detailURL = String()
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()

        getRepoDetail()
        scheduledTimerWithTimeInterval()
    }
    
    //MARK:- scheduledTimerWithTimeInterval
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.refreshRepo), userInfo: nil, repeats: true)
    }
    
    //MARK:- Refresh Repo
    @objc func refreshRepo(){
        getRepoDetail()
    }
    
    //MARK:- getMostPopularGitRepoApiCall
    func getRepoDetail(){
        
        RestClient.sharedInstance.getRepoDetail(detailURL, viewcontroller: self){ (dict) in
            if dict != nil {
                let obj = RepoModel.init(dict: dict!)
                self.repoDict = obj
                    DispatchQueue.main.async {
                        self.setData()
                    }
            }
        }
    }
    
    //MARK:- setData
    func setData(){
        if let data = repoDict {
            titleLabel.text = data.name
            descriptionLabel.text = data.description
            watchersLabel.text = "Watchers : \(data.watchers_count)"
            forksLabel.text = "Forks : \(data.forks_count)"
            openIssuesLabel.text = "Open issues : \(data.open_issues_count)"
            starsLabel.text = "Stars : \(data.stargazers_count)"
            language.text = "Langauge : \(data.language)"
        }
    }
}
