//
//  ViewController.swift
//  OuroborosViewDemo
//
//  Created by Chia on 2020/5/12.
//  Copyright © 2020 Chia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

//  MARK:   Private
    
    private var dataSource: [Int] = Array(repeating: 0, count: 30)
    
    private var loadMoreStatus = false
    
    private func loadMore() {
        if !loadMoreStatus {
            loadMoreStatus = true
            DispatchQueue.global().async {
                
                self.loadMoreStatus = false
                
                self.dataSource.append(contentsOf: Array(repeating: 0, count: 20))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.panGestureRecognizer.translation(in: self.view)
        
        if point.y > 0 {
            
        } else {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
            
            let deltaOffset = maximumOffset - currentOffset
            
            if deltaOffset < 30 {
                loadMore()
            }
            
        }
    }
}
