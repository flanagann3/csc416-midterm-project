
import Foundation

class TrackerTaskStore: ObservableObject {
    @Published var tasks: [TrackerTask] = []

    init(check: Bool) throws {
        #if DEBUG
        //createDemoTrackerTasks()
        #endif

        do {
            try loadSaveData()
        } catch {
            print("An error occurred: ", error)
        }
    }

    init() {}

    func loadSaveData() throws {
        
        guard let saveLocation = getSaveLocation() else {
            throw StoreError.getSaveLocationError
        }
        
        
        
        do {
            let data = try Data(contentsOf: saveLocation as URL)
            let plistSaveData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
            let convertedPlistSaveData = plistSaveData as? [[Any]] ?? []
            tasks = convertedPlistSaveData.map {
                TrackerTask(subject: $0[1] as! String, description: $0[2] as! String,
                            dueDate: $0[3] as? Date ?? Date(), isCompleted: $0[4] as! Bool)
            }
            print("loadSaveData Succeeded")
        } catch {
            print(error)
            throw StoreError.loadSaveDataError
        }
         
        
    }

    func getSaveLocation() -> NSURL? {
        
        guard let url = FileManager.default.urls(
                for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent("SavedTasks.plist") as NSURL

         

        //let url = FileManager.default.urls(for: .documentDirectory,
          //      in: .userDomainMask)[0].appendingPathComponent("SavedTasks.plist")
        //return url
         
        //return NSURL(fileURLWithPath: "SavedTasks.plist")

        
        ///file://
    }

    func save() throws {
        guard let url = getSaveLocation() else {
            throw StoreError.getSaveLocationError
        }

        /*
        var saveData: [[Any]] = []
        for task in tasks {
            saveData.append(([
                task.id.uuidString,
                task.subject,
                task.description,
                task.dueDate,
                task.priority,
                task.isCompleted
            ]))
        }

         */
         


        let saveData = tasks.map {
            [$0.id, $0.subject, $0.description, $0.dueDate, /* $0.priority, */ $0.isCompleted]
        }

        do {
            let data = try PropertyListSerialization.data(
                    fromPropertyList: saveData, format: .binary, options: .zero)
            try data.write(to: url as URL, options: .atomic)
        } catch {
            throw StoreError.saveError
        }

        print("save() completed")
    }

    func createNewTrackerTask(subject: String, description: String, dueDate: Date, /* priority: TrackerTask.Priority,
                            */  isCompleted: Bool) {
        tasks.append(TrackerTask(subject: subject, description: description, dueDate: dueDate, /* priority: priority, */
                isCompleted: isCompleted))

        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    enum StoreError: Error {
        case saveError
        case getSaveLocationError
        case loadSaveDataError
    }
}
