import CoreData

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourDataModelName")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Unable to save context: \(error)")
            }
        }
    }
    
    func fetchObjects<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let context = persistentContainer.viewContext
        do {
            let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
            return try context.fetch(fetchRequest)
        } catch {
            print("Unable to fetch objects: \(error)")
            return []
        }
    }
    
    func deleteObject(_ object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(object)
        save()
    }
}
