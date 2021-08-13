//
//  DogeTableViewCell.swift
//  DodgeCoinTracker
//
//  Created by Asad on 04/06/2021.
//

import UIKit

struct DogeTableViewCellModel{
    let title: String
    let value: String
    
}

class DogeTableViewCell: UITableViewCell {
    
    static let identifier = "DogeTableViewCell"
    private let label: UILabel = {
        let label = UILabel()
        
        
        
        return label
        
        
    }()
    
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        
        return label
        
        
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(valueLabel)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.sizeToFit()
        valueLabel.sizeToFit()
        
        label.frame = CGRect(x: 15, y: 5, width: label.frame.size.width, height: label.frame.size.height)
        
        
        valueLabel.frame = CGRect(x: contentView.frame.size.width - 15 - valueLabel.frame.size.width, y: 5, width: valueLabel.frame.size.width, height: valueLabel.frame.size.height)
    }
    
    
    public func  configure(with viewModels: DogeTableViewCellModel){
        
        label.text = viewModels.title
        valueLabel.text = viewModels.value
        
        
    }
    

}
