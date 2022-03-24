
import SwiftUI

struct TrackerTaskView: View {

    @Binding var task: TrackerTask
    //@Binding var trackerTasks: TrackerTaskStore
    @EnvironmentObject var trackerTasks: TrackerTaskStore
    @State var showEditMenu = false

    var body: some View {

        VStack {

            HStack {
                Text(task.stringDate())
                        .frame(alignment: Alignment.leading)
                Spacer()
                //Text(task.priority.rawValue)
            }
                    .frame(alignment: Alignment.leading)

            HStack {
                if (task.isCompleted) {
                    Circle()
                            .stroke(Color.black)
                            .onTapGesture {
                                task.toggleIsCompleted()
                            }
                            .frame(alignment: Alignment.leading)
                            .frame(width: 20)
                            .overlay(
                                    Circle()
                                            .fill(Color.gray)
                                            .frame(width: 10)
                                            .onTapGesture { task.toggleIsCompleted() }
                            )
                } else {
                    Circle()
                            .stroke(Color.black)
                            .onTapGesture {
                                task.toggleIsCompleted()
                            }
                            .frame(alignment: Alignment.leading)
                    .frame(width: 20)
                }

                Text(task.subject)
                        .frame(width: 200, alignment: Alignment.leading)

            }
                    .frame(alignment: Alignment.leading)

            Image(systemName: "ellipsis.rectangle")
                    .frame(width: 250, alignment: Alignment.bottomTrailing)
                    .onTapGesture(perform: {showEditMenu.toggle()})
                    .sheet(isPresented: $showEditMenu) {
                        EditTrackerTaskView(task: $task, showEditTrackerTaskView: $showEditMenu)
                    }

        }
                .padding(.bottom)


    }
}

/*
struct TrackerTaskView_Previews: PreviewProvider {
    static var previews: some View {
        TrackerTaskView(task: .constant(TrackerTask(subject: "Demo Task Subject",
                description: "Used for TrackerTaskView Preview", dueDate: Date(),
                priority: TrackerTask.Priority.undefined, isCompleted: false)))
    }
}

 */

