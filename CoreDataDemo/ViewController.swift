//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Gajender Jangir on 14/04/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    //referenec to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var items = [TodoListitem]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource=self
        tableView.delegate=self
        
        //data for the table
        
        fetchItems()
    }

    func fetchItems()
    {
        do{
        
            self.items=try! context.fetch(TodoListitem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            //
        }
    }
    func addItem(name:String)
    {
        let newItem = TodoListitem(context: context)
        newItem.name = name
        newItem.createdAt=Date()
        
        do {
            try context.save()
            fetchItems()
        } catch {
            
        }
    }
    func deleteItem(item:TodoListitem)
    {
        context.delete(item)
        
        do {
            try context.save()
            fetchItems()
        } catch {
            
        }
    }
    
    func updateItem(item:TodoListitem,newName:String)
    {
        item.name=newName
        do {
            try context.save()
            fetchItems() 
        } catch {
            
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        let alert=UIAlertController(title: "Add Note", message: "enter", preferredStyle: .alert)
        alert.addTextField()
        
        let submitBtn=UIAlertAction(title: "Add", style: .default){(action) in
            let textfield = alert.textFields![0]
            self.addItem(name: textfield.text ?? "none")
        }
        //add button
        alert.addAction(submitBtn)
        
        //show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        //return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NotesTableViewCell
        
        cell.cellLabel.text=model.name
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        let sheet=UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        let item = items[indexPath.row]
        //add button
            // sheet.addAction(null)
        sheet.addAction(UIAlertAction (title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction (title: "Edit", style: .default, handler: {_ in
                      
            
            // to update by alert
            
            let alert=UIAlertController(title: "Edut item", message: "enter", preferredStyle: .alert)
            alert.addTextField()
            alert.textFields?.first?.text=item.name
            
            let submitBtn=UIAlertAction(title: "Edit", style: .default){(action) in
                let textfield = alert.textFields?.first?.text
        
                
                self.updateItem(item: item, newName: textfield ?? "nothing")
            }
            //add button
            alert.addAction(submitBtn)
            
            //show alert
            self.present(alert, animated: true, completion: nil)
        }))
        sheet.addAction(UIAlertAction (title: "Delete", style: .destructive, handler:{ _ in
            self.deleteItem(item: item)
        } ))
        //show alert
        self.present(sheet, animated: true, completion: nil)
    }
    

    
}
