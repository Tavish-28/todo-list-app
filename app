import { useState, useEffect } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";
import { Checkbox } from "@/components/ui/checkbox";
import { Trash, Edit } from "lucide-react";

export default function TodoListApp() {
  const [tasks, setTasks] = useState([]);
  const [taskTitle, setTaskTitle] = useState("");
  const [taskDescription, setTaskDescription] = useState("");
  const [editIndex, setEditIndex] = useState(null);

  useEffect(() => {
    const storedTasks = JSON.parse(localStorage.getItem("tasks")) || [];
    setTasks(storedTasks);
  }, []);

  useEffect(() => {
    localStorage.setItem("tasks", JSON.stringify(tasks));
  }, [tasks]);

  const addTask = () => {
    if (!taskTitle.trim()) return;
    const newTask = { title: taskTitle, description: taskDescription, completed: false };
    if (editIndex !== null) {
      const updatedTasks = [...tasks];
      updatedTasks[editIndex] = newTask;
      setTasks(updatedTasks);
      setEditIndex(null);
    } else {
      setTasks([...tasks, newTask]);
    }
    setTaskTitle("");
    setTaskDescription("");
  };

  const deleteTask = (index) => {
    setTasks(tasks.filter((_, i) => i !== index));
  };

  const toggleTaskCompletion = (index) => {
    const updatedTasks = [...tasks];
    updatedTasks[index].completed = !updatedTasks[index].completed;
    setTasks(updatedTasks);
  };

  const editTask = (index) => {
    setTaskTitle(tasks[index].title);
    setTaskDescription(tasks[index].description);
    setEditIndex(index);
  };

  return (
    <div className="p-4 max-w-md mx-auto">
      <h1 className="text-xl font-bold mb-4">To-Do List</h1>
      <div className="mb-4">
        <Input
          placeholder="Task Title"
          value={taskTitle}
          onChange={(e) => setTaskTitle(e.target.value)}
        />
        <Textarea
          placeholder="Task Description (optional)"
          value={taskDescription}
          onChange={(e) => setTaskDescription(e.target.value)}
          className="mt-2"
        />
        <Button onClick={addTask} className="mt-2">{editIndex !== null ? "Update Task" : "Add Task"}</Button>
      </div>
      <div>
        {tasks.map((task, index) => (
          <Card key={index} className="mb-2 p-2 flex justify-between items-center">
            <div className="flex items-center">
              <Checkbox
                checked={task.completed}
                onCheckedChange={() => toggleTaskCompletion(index)}
              />
              <div className="ml-2">
                <p className={task.completed ? "line-through" : ""}>{task.title}</p>
                <p className="text-sm text-gray-500">{task.description}</p>
              </div>
            </div>
            <div className="flex gap-2">
              <Button variant="ghost" size="icon" onClick={() => editTask(index)}>
                <Edit size={16} />
              </Button>
              <Button variant="ghost" size="icon" onClick={() => deleteTask(index)}>
                <Trash size={16} />
              </Button>
            </div>
          </Card>
        ))}
      </div>
    </div>
  );
}
