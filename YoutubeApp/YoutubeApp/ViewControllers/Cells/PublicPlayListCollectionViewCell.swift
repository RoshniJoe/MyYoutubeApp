//
//  PublicPlayListCollectionViewCell.swift
//  YoutubeApp
//
//  Created by Roshni Varghese on 2020-10-24.
//

import UIKit

class PublicPlayListCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "GoogleSign")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 16.0)
        label.textColor = UIColor(red: 31/255, green: 84/255, blue: 149/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let videoCountView: UIView = {
        let view = UIImageView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.alpha = 0.6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let videoCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BwModelicaSS01-Medium", size: 14.0)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func addViews(){
        backgroundColor = .white
        
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(videoCountView)
        addSubview(videoCountLabel)
        
        NSLayoutConstraint.activate([
            
            thumbnailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            videoCountView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                 
            videoCountView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            videoCountView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            videoCountView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            videoCountView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
            videoCountLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            videoCountLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            videoCountLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            videoCountLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            
        ])
    }
}
