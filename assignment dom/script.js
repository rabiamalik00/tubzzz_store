var inputBox = document.createElement("input");
console.log(inputBox)

var addButton = document.createElement("button");
addButton.innerText = "Add Task";
console.log(addButton)

var container = document.getElementById("task-container");
container.appendChild(inputBox);
container.appendChild(addButton);
console.log(container)


addButton.addEventListener("click", function () {
var taskValue = inputBox.value;
var newTask = document.createElement("li");
newTask.innerText = taskValue;


var taskList = document.getElementById("task-list");
taskList.appendChild(newTask);
console.log(taskList)


});