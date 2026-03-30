// Function to change first name to full name and change text color
function changeNameAndColor() {
  var fullName = "princess Malik";
  var nameElement = document.getElementById("fullName");
  nameElement.textContent = fullName;

  var textColorElement = document.getElementById("textColor");
  textColorElement.style.color = "red";
}

// Add event listener to the button
document.getElementById("nameButton").addEventListener("click", changeNameAndColor);

// Object for a house
var house = {
  houseNo: 123,
  location: "North Karachi",
  city: "Karachi"
};

// Array of fruits
var fruits = ["apple", "banana", "orange", "grapes"];
fruits.pop();
console.log(fruits)

// Delete the last item of the fruits array

// Print "no" 10 times using a for loop"
for (var i = 0; i < 10; i++) {
  console.log("no "+i);
}

// Function to print "Hello World" message
function printHelloWorld() {
  console.log("Hello World");
}

// Call the function to print "Hello World"
printHelloWorld();
