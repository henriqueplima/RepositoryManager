//
//  RepoTableCell.swift
//  RepositoryManager
//
//  Created by Henrique Pereira de Lima on 23/11/19.
//  Copyright (c) 2019 Henrique Pereira de Lima. All rights reserved.
//


import UIKit

class RepoTableCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupAccessibility(indexRow: Int) {
        repoNameLabel.isAccessibilityElement = true
        repoNameLabel.accessibilityLabel = repoNameLabel.text
        repoNameLabel.accessibilityHint = "Nome Repo"
        repoNameLabel.accessibilityTraits = .staticText
        
        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.accessibilityLabel = descriptionLabel.text
        descriptionLabel.accessibilityHint = "Descrição"
        descriptionLabel.accessibilityTraits = .staticText
        
        usernameLabel.isAccessibilityElement = true
        usernameLabel.accessibilityLabel = usernameLabel.text
        usernameLabel.accessibilityHint = "Nome do usuário"
        usernameLabel.accessibilityTraits = .staticText
        
        forkLabel.isAccessibilityElement = true
        forkLabel.accessibilityLabel = forkLabel.text
        forkLabel.accessibilityHint = "Quantidade de forks"
        forkLabel.accessibilityTraits = .staticText
        
        starsLabel.isAccessibilityElement = true
        starsLabel.accessibilityLabel = starsLabel.text
        starsLabel.accessibilityHint = "Quantidade de estreas"
        starsLabel.accessibilityTraits = .staticText
        
        self.contentView.isAccessibilityElement = true
        self.contentView.accessibilityLabel = "Item \(indexRow) da lista"
    }
    
    func setupCell(viewModel: RepositoryListModels.ViewModel, indexRow: Int) {
        clean()
        descriptionLabel.text = viewModel.description
        repoNameLabel.text = viewModel.name
        forkLabel.text = viewModel.forks
        starsLabel.text = viewModel.stars
        fullNameLabel.text = viewModel.userFullName
        ownerImageView.image = viewModel.photo
        usernameLabel.text = viewModel.username
        setupAccessibility(indexRow: indexRow)
    }
    
    func setImage(image: UIImage) {
        clean()
        ownerImageView.image = image
    }
    
    func clean() {
        ownerImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
