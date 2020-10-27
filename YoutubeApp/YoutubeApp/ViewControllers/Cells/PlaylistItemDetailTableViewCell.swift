//
//  PlaylistItemDetailTableViewCell.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-25.
//

import UIKit

class PlaylistItemDetailTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 16.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.textColor = UIColor(red: 31/255, green: 84/255, blue: 149/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 14.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 17/255, green: 56/255, blue: 116/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 14.0)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = UIColor(red: 17/255, green: 56/255, blue: 116/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func addViews(){
        backgroundColor = .white
        
        addSubview(thumbnailImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        stackView.addArrangedSubview(durationLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 120),
            thumbnailImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - (thumbnailImageView.frame.width + 20)),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
        ])
        
    }
}
