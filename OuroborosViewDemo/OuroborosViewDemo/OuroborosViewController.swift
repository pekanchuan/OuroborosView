//
//  OuroborosViewController.swift
//  OuroborosViewDemo
//
//  Created by Chia on 2021/2/27.
//  Copyright © 2021 Chia. All rights reserved.
//

import UIKit

class OuroborosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ouroborosView = OuroborosView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.width * 3/4))
        view.addSubview(ouroborosView)
        ouroborosView.backgroundColor = .red
//        ouroborosView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate(
//            [ouroborosView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//             ouroborosView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//             ouroborosView.widthAnchor.constraint(equalTo: view.widthAnchor),
//             ouroborosView.heightAnchor.constraint(equalTo: ouroborosView.widthAnchor, multiplier: 3/4)])
        ouroborosView.images = ["1.jpg", "2.jpg", "3.jpg"]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
