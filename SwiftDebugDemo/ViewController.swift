//
//  ViewController.swift
//  SwiftDebugDemo
//
//  Created by 林子鑫 on 2021/11/8.
//

import UIKit
import SwiftDebug
class ViewController: UIViewController {
    @IBAction func sendMsg(_ sender: Any) {
        let len = arc4random_uniform(100) + 1
        var msg = ""
        for i in 1...len {
            msg.append("\(i)")
        }
        print(msg)
    }
    
    @IBAction func crashAction(_ sender: Any) {
        let url = URL(string: "https://www.baidu.com/index.html")!
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
        }.resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SwiftDebug.install()
    }
}
