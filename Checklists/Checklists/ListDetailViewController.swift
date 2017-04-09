//
//  ListDetailViewControllerTableViewController.swift
//  Checklists
//
//  Created by michael qian on 2017/4/9.
//  Copyright © 2017年 mqstack. All rights reserved.
//

import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishAdding checklist: Checklist)
    
    func listDetailViewController(_ controller: ListDetailViewController,
                                  didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var cancel: UIBarButtonItem!
    
    @IBOutlet weak var done: UIBarButtonItem!
    
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: ListDetailViewControllerDelegate?
    
    var listToEdit: Checklist?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let list = listToEdit {
            title = "Edit Checklist"
            textField.text = list.name
            done.isEnabled = true
            
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        done.isEnabled = (newText.length > 0)
        return true
    }


    @IBAction func cancel(_ sender: Any) {
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        if let list = listToEdit {
            list.name = textField.text!
            delegate?.listDetailViewController(self, didFinishEditing: list)
        }else {
            let list = Checklist(name: textField.text!)
            delegate?.listDetailViewController(self, didFinishAdding: list)
        }
    }
    

}
