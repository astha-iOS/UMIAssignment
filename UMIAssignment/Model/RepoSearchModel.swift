//
//  RepoSearchModel.swift
//  UMIAssignment
//
//  Created by Astha yadav on 30/06/21.
//

import Foundation

struct RepoSearchModel {
    var totalRepo:Int = 0
    var repoItems:[RepoModel] = []
    
    init(repoCount:Int,repoItems:[RepoModel]) {
        self.totalRepo = repoCount
        self.repoItems = repoItems
    }
    
}
