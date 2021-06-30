//
//  Parser.swift
//  UMIAssignment
//
//  Created by Astha yadav on 30/06/21.
//

import Foundation
import UIKit

class Parser {
    
    static func convetToRepoSearchModel(json:Dictionary<String, Any>)-> RepoSearchModel{
        var repoList = [RepoModel]()
        let totalRepoCount = json["total_count"] as? Int ?? 0
        if let itemsList = json["items"] as? [Dictionary<String,Any>] {
            for repo in itemsList {
                let obj = RepoModel.init(dict: repo)
                repoList.append(obj)
            }
        }
        return RepoSearchModel(repoCount: totalRepoCount, repoItems: repoList)
    }
}
