//
//  HomeViewController.swift
//  HackathonCCR
//
//  Created by Lucas Antevere Santana on 14/06/20.
//  Copyright © 2020 Equipe261. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    enum Segues: String {
        case qrCode = "qrScan"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.AppColors.label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureNavBar()
    }

    func configureNavBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "logo")))
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        self.navigationItem.rightBarButtonItems = [ UIBarButtonItem(image: UIImage(named: "profile"), style: .plain,
                                                                    target: nil, action: nil),
                                                    UIBarButtonItem(image: UIImage(named: "qr"), style: .plain,
                                                                    target: self, action: #selector(handleQrCodeTapped))]
        
        _ = self.navigationController?.navigationBar.sizeThatFits(self.view.frame.size)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func handleQrCodeTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: Segues.qrCode.rawValue, sender: nil)
    }
}
