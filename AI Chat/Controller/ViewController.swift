//
//  ViewController.swift
//  AI Chat
//
//  Created by G2-216 on 10/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTxtVw: UITextView!
    @IBOutlet weak var tblVw: UITableView!
    
    var results = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Let's build an AI Chat here....")
        
        tblVw.dataSource = self
        tblVw.delegate = self
        inputTxtVw.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(false)
       }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            if let text = textView.text, !text.isEmpty {
                results.append(text)
                AIHelper.shared.getResponse(inputStr: text) { [weak self] result in
                    switch result {
                    case .success(let output):
                        self?.results.append(output)
                        DispatchQueue.main.async {
                            self?.tblVw.reloadData()
                            self?.inputTxtVw.text = nil
                        }
                    case .failure:
                        print("Failed")
                    }
                }
            }
            return false
        }
        return true
    }
}
