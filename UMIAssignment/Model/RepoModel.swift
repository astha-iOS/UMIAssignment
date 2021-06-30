//
//  RepoModel.swift
//  UMIAssignment
//
//  Created by Astha yadav on 29/06/21.
//

import Foundation
import UIKit

struct RepoModel {
    var repoId:String = ""
    var full_name:String = ""
    var name:String = ""
    var description:String = ""
    var fork:String = ""
    var forks_count:String = ""
    var watchers_count:String = ""
    var stargazers_count:String = ""
    var open_issues_count:String = ""
    var language:String = ""
    var detail_url:String = ""
    
    init(dict:Dictionary<String,Any>) {
        
        if let repoId = dict["id"] as? Int {
            self.repoId = String(repoId)
        }
        
        if let full_name = dict["full_name"] as? String {
            self.full_name = full_name
        }
        
        if let name = dict["name"] as? String {
            self.name = name
        }
        
        if let description = dict["description"] as? String {
            self.description = description
        }
        
        if let fork = dict["fork"] as? Int {
            self.fork = String(fork)
        }
        
        if let forks_count = dict["forks_count"] as? Int {
            self.forks_count = String(forks_count)
        }
        
        if let watchers_count = dict["watchers_count"] as? Int {
            self.watchers_count = String(watchers_count)
        }
        
        if let stargazers_count = dict["stargazers_count"] as? Int {
            self.stargazers_count = String(stargazers_count)
        }
        
        if let open_issues_count = dict["open_issues_count"] as? Int {
            self.open_issues_count = String(open_issues_count)
        }
        
        if let language = dict["language"] as? String {
            self.language = language
        }
        
        if let detail_url = dict["url"] as? String {
            self.detail_url = detail_url
        }
    }
}

