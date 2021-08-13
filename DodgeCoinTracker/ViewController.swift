//
//  ViewController.swift
//  DodgeCoinTracker
//
//  Created by Asad on 03/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    var myViewModels = [DogeTableViewCellModel]()
    
    
    var viewModels: DogeCoinData?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DogeTableViewCell.self, forCellReuseIdentifier: DogeTableViewCell.identifier)
        
        return tableView
        
    }()
    
    static let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.numberStyle = .currency
        
        return formatter
        
        
    }()
    
    static let dateFormatter : ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFractionalSeconds
        formatter.timeZone = .current
        
        
        return formatter
    }()
    static let prettyDateFormatter : DateFormatter = {
        
        let formatter = DateFormatter()
        
        
        formatter.dateStyle = .medium
        
        
        
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
        title = "Dodge Coin"
        
        fetchData()
        
        

        
        
    }
    
    private func setUpTableViewModels(){
        guard let model = viewModels else {
            return
        }
        guard let date = Self.dateFormatter.date(from: model.date_added) else {
            return
        }
        print(Self.dateFormatter.string(from: date ))
        // creating viewmodels
        
        myViewModels = [DogeTableViewCellModel(title: "Name", value: model.name),DogeTableViewCellModel(title: "Symbol", value: model.symbol),DogeTableViewCellModel(title: "Date Added", value: Self.dateFormatter.string(from: date )),DogeTableViewCellModel(title: "Identifier", value: String(model.id)),DogeTableViewCellModel(title: "Total Supply", value: String(model.total_supply)),]
        
        setUpTable()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func fetchData(){
        APICaller.shared.getDodgeCoinData{ [weak self ] result in

            switch result{
            case .success(let data):
                self?.viewModels = data
                
                print(data)
                DispatchQueue.main.async {
                    
                    
                    self?.setUpTableViewModels()
                }
                
                
            case.failure(let error):
                print(error)
            }

    }
        
        
    }
    
    private func tableHeader(){
        
        guard let price = viewModels?.quote["USD"]?.price else {
            return
        }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width))
        header.clipsToBounds = true
        
        
        
        //image
        let imageView = UIImageView(image: UIImage(named: "dodgecoin"))
        imageView.contentMode = .scaleAspectFill
        
        let size = view.frame.size.width/4
        imageView.frame = CGRect(x: (view.frame.size.width-size)/2, y: 10, width: size, height: size)
        
        header.addSubview(imageView)
        
        
        
        //price label
        
let number = NSNumber(value: price)
        let string = Self.formatter.string(from: number)
        
        
        
        
        let label = UILabel()
        label.text = string
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 42,weight:.medium)
        label.frame = CGRect(x: 10, y: 20+size, width: view.frame.size.width - 20, height: 200)
        
        view.addSubview(label)
        
        tableView.tableHeaderView = header
        
    }
    
    private func setUpTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableHeader()


    }


}


extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(myViewModels.count)
        return myViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: DogeTableViewCell.identifier,for: indexPath) as? DogeTableViewCell else {
            fatalError()
        }
        
        cell.configure(with: myViewModels[indexPath.row])
        
        return cell
    }
    
    
    
}
