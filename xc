#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Task {
protected:
    string taskName;
    string taskDescription;
    bool completed;

public:
    Task(string name, string description) : taskName(name), taskDescription(description), completed(false) {}

    virtual void displayTask() {
        cout << "Task: " << taskName << "\nDescription: " << taskDescription << "\nStatus: " << (completed ? "Completed" : "Incomplete") << endl;
    }

    void markComplete() {
        completed = true;
    }

    bool isCompleted() {
        return completed;
    }

    virtual ~Task() {}
};

class PriorityTask : public Task {
private:
    int priorityLevel;

public:
    PriorityTask(string name, string description, int priority) : Task(name, description), priorityLevel(priority) {}

    void displayTask() override {
        cout << "Priority Task: " << taskName << "\nDescription: " << taskDescription << "\nPriority: " << priorityLevel << "\nStatus: " << (completed ? "Completed" : "Incomplete") << endl;
    }

    ~PriorityTask() {}
};

int main() {
    vector<Task*> tasks;

    char choice;
    do {
        cout << "Menu:\n";
        cout << "1. Add Task\n";
        cout << "2. Delete Task\n";
        cout << "3. Mark Task as Complete\n";
        cout << "4. Display Tasks\n";
        cout << "5. Exit\n";
        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice) {
            case '1': {
                string name, description;
                int priority;

                cout << "Enter task name: ";
                cin.ignore();
                getline(cin, name);

                cout << "Enter task description: ";
                getline(cin, description);

                cout << "Enter priority level (1-5): ";
                cin >> priority;

                Task* newTask;
                if (priority > 0 && priority <= 5) {
                    newTask = new PriorityTask(name, description, priority);
                } else {
                    newTask = new Task(name, description);
                }

                tasks.push_back(newTask);
                cout << "Task added successfully.\n";
                break;
            }

            case '2': {
                int index;
                cout << "Enter the index of the task to delete: ";
                cin >> index;

                if (index >= 0 && index < tasks.size()) {
                    delete tasks[index];
                    tasks.erase(tasks.begin() + index);
                    cout << "Task deleted successfully.\n";
                } else {
                    cout << "Invalid index.\n";
                }
                break;
            }

            case '3': {
                int index;
                cout << "Enter the index of the task to mark as complete: ";
                cin >> index;

                if (index >= 0 && index < tasks.size()) {
                    tasks[index]->markComplete();
                    cout << "Task marked as complete.\n";
                } else {
                    cout << "Invalid index.\n";
                }
                break;
            }

            case '4': {
                cout << "Tasks:\n";
                for (size_t i = 0; i < tasks.size(); ++i) {
                    cout << "Task #" << i << ":\n";
                    tasks[i]->displayTask();
                    cout << "-------------------\n";
                }
                break;
            }

            case '5':
                cout << "Exiting...\n";
                break;

            default:
                cout << "Invalid choice. Please enter a valid option.\n";
        }
    } while (choice != '5');

    // Clean up memory
    for (Task* task : tasks) {
        delete task;
    }
    tasks.clear();

    return 0;
}
