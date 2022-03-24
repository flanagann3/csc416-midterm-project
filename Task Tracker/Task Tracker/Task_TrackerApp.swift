
import SwiftUI

@main
struct Task_TrackerApp: App {

    @StateObject private var trackerTasks: TrackerTaskStore
    @State private var decoder: JSONDecoder
    

    init() {

        let trackerTasks: TrackerTaskStore
        do {
            trackerTasks = try TrackerTaskStore(check: true)
        } catch {
            print("Error loading saved tasks")
            trackerTasks = TrackerTaskStore()
        }
        _trackerTasks = StateObject(wrappedValue: trackerTasks)
        decoder = JSONDecoder()
        
    }

    var body: some Scene {
        WindowGroup {
            ContentView(/* decoder: $decoder */)
                    .environmentObject(trackerTasks)
                    
        }
    }
}
