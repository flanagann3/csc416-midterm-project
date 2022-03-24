
import SwiftUI

struct ContentView: View {

    @EnvironmentObject var trackerTasks: TrackerTaskStore
    @State private var showNewTaskMenu = false
    //@Binding var decoder: JSONDecoder

    var body: some View {

            VStack {
                HStack {
                    Text("Task Tracker")
                            .font(.largeTitle)
                            .frame(alignment: .leading)
                            .padding()
                    Spacer()
                    Button("New Task") {
                        trackerTasks.tasks.append(TrackerTask(subject: "New Task", description: "", dueDate: Date(),
                                                              isCompleted: false))
                        showNewTaskMenu.toggle()
                    }
                            .sheet(isPresented: $showNewTaskMenu) {
                                EditTrackerTaskView(task: $trackerTasks.tasks[trackerTasks.tasks.count - 1],
                                        showEditTrackerTaskView: $showNewTaskMenu)

                            }
                            .padding()
                }

                List($trackerTasks.tasks) {
                    TrackerTaskView(task: $0)
                }
                        .padding(.bottom)

            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
