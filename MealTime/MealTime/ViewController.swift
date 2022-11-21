import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    var context: NSManagedObjectContext!
    @IBOutlet weak var tableView: UITableView!
    var array = [Date]()
    var person: Person!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let personName = "Max"
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", personName)
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.isEmpty {
                person = Person(context: context)
                person.name = personName
                try context.save()
            } else {
                person = results.first
            }
        } catch let error as NSError{
            print(error.userInfo)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My happy meal time"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let meals = person.meals else { return 1 }
        
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        guard let meal = person.meals?[indexPath.row] as? Meal, let mealDate = meal.date as Date? else {
            return cell!
        }
        
        
        cell!.textLabel!.text = dateFormatter.string(from: mealDate)
        return cell!
    }
    // удаление ячеек
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let mealToDelete = person.meals?[indexPath.row] as? Meal,editingStyle == .delete else {return}
        
        context.delete(mealToDelete)
        // пересохраняем наш контекст
        do {
            try context.save()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch let error as NSError {
            print("Error: \(error),description \(error.userInfo)")
        }
        
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        
        let meal = Meal(context: context)
        meal.date = NSDate() as Date
        
        let meals = person.meals?.mutableCopy() as? NSMutableOrderedSet
        meals?.add(meal)
        person.meals = meals
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Error: \(error), userInfo \(error.userInfo)")
        }
        tableView.reloadData()
    }
}

