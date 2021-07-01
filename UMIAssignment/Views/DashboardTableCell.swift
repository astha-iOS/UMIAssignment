//
//  DashboardTableCell.swift
//  UMIAssignment
//
//  Created by Astha yadav on 28/06/21.
//

import UIKit

class DashboardTableCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var watcherLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var starLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(with repo: RepoModel? = nil, indexPath:IndexPath) {
        if let data = repo {
            titleLabel.text = data.name
            descLabel.text = data.description
            watcherLabel.text = data.watchers_count
            starLabel.text = data.stargazers_count
        }
    }
}
