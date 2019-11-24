//
//  PullTableCell.swift
//  testeResource
//
//  Created by Henrique Pereira de Lima on 12/03/2018.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class PullTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    func setupViewModel(viewModel: PullListModels.ViewModel.CellViewModel) {
        imgUser.image = nil
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
        usernameLabel.text = viewModel.userName
        typeLabel.text = viewModel.type
        statusLabel.text = viewModel.state
        imgUser.image = viewModel.photo
    }
    
    func setImage(image: UIImage) {
        imgUser.image = nil
        imgUser.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
