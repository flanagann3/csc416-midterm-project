
import SwiftUI

struct EditTrackerTaskView: View {

    @Binding var task: TrackerTask
    @Binding var showEditTrackerTaskView: Bool
    @EnvironmentObject var trackerTasks: TrackerTaskStore
    //@Binding var trackerTasks: TrackerTaskStore

    var body: some View {
        Form {
            TextField(text: $task.subject, prompt: Text("Subject")) {
                Text("Subject")
            }

            TextField(text: $task.description, prompt: Text("Optional Description")) {

            }

            DatePicker("Due Date", selection: $task.dueDate, displayedComponents: [.date])

            /*
            Picker("Priority", selection: $task.priority) {
                Text("").tag(TrackerTask.Priority.undefined)
                Text("Low").tag(TrackerTask.Priority.low)
                Text("Medium").tag(TrackerTask.Priority.medium)
                Text("High").tag(TrackerTask.Priority.high)
            }
                    .pickerStyle(.segmented)

             */

        }

        HStack {
            Button("Delete") {
                showEditTrackerTaskView.toggle()
                trackerTasks.tasks.removeAll(where: { $0.id == task.id })
            }
                    .padding()

            Spacer()

            Button("Done") {
                showEditTrackerTaskView.toggle()
            }
                    .padding()
        }
    }
}

/*
struct EditTrackerTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTrackerTaskView()
    }
}

 */
