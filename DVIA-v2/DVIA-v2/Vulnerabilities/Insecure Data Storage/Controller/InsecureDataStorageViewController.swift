//
//  InsecureDataStorageViewController.swift
//  DVIA
//
//  Created by Prateek Gianchandani on 23/11/17.
//  Copyright © 2017 HighAltitudeHacks. All rights reserved.
//

import UIKit

enum segueIdentifier: Int {
    case plist = 0
    case userDefaults
    case keychain
    case coreData
    case webKit
    case realm
    case couchbase
    case yapDatabase
    
    var identifier: String {
        switch self {
        case .plist:
            return "plistSegueIdentifier"
        case .userDefaults:
            return "userDefaultsSegueIdentifier"
        case .keychain:
            return "keychainSegueIdentifier"
        case .coreData:
            return "coreDataSegueIdentifier"
        case .webKit:
            return "webkitSegueIdentifier"
        case .realm:
            return "realmSegueIdentifier"
        case .couchbase:
            return "couchbaseSegueIdentifier"
        case .yapDatabase:
            return "yapDatabaseSegueIdentifier"
        }
    }
}

fileprivate var vulnerabilities = ["Plist","UserDefaults","Keychain","Core Data","Webkit Caching","Realm","Couchbase Lite","YapDatabase"]

class InsecureDataStorageViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "menu.png"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(menuTapped(_:)), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        button.widthAnchor.constraint(equalToConstant: 28).isActive = true
        button.heightAnchor.constraint(equalToConstant: 28).isActive = true
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = barButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Local Data Storage"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.navigationItem.title = " "
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        mainViewController?.toogle()
    }
    
    @IBAction func readArticleTapped(_ sender: Any) {
        let url = UrlLinks.insecureDataStorageArticle.url
        DVIAUtilities.loadWebView(withURL: url, viewController: self)
    }
    
}

extension InsecureDataStorageViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vulnerabilities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "vulnerabilitiesCell", for: indexPath)
        cell.textLabel?.text = vulnerabilities[indexPath.item]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        performSegueWith(indexPath: indexPath)
    }
    
    func performSegueWith(indexPath: IndexPath) {
        guard let identifier = segueIdentifier(rawValue: indexPath.item) else { return }
        
        switch identifier {
        case .plist:
            performSegue(withIdentifier: segueIdentifier.plist.identifier, sender: indexPath.item)
        case .userDefaults:
            performSegue(withIdentifier: segueIdentifier.userDefaults.identifier, sender: indexPath.item)
        case .keychain:
            performSegue(withIdentifier: segueIdentifier.keychain.identifier, sender: indexPath.item)
        case .coreData:
            performSegue(withIdentifier: segueIdentifier.coreData.identifier, sender: indexPath.item)
        case .webKit:
            performSegue(withIdentifier: segueIdentifier.webKit.identifier, sender: indexPath.item)
        case .realm:
            performSegue(withIdentifier: segueIdentifier.realm.identifier, sender: indexPath.item)
        case .couchbase:
            performSegue(withIdentifier: segueIdentifier.couchbase.identifier, sender: indexPath.item)
        case .yapDatabase:
            performSegue(withIdentifier: segueIdentifier.yapDatabase.identifier, sender: indexPath.item)
        }

    }
}
