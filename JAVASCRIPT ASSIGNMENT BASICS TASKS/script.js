//QNo#1.........................Var And Data Types
//    Arithmetic operators

// var a= 5;
// var b= 2;

// console.log("a =", a, "& b =",b)
// console.log ("a + b =", a + b)
// console.log ("a - b =", a - b)
// console.log ("a * b =", a * b)
// console.log ("a / b =", a / b)
// console.log ("a % b =", a % b)
// console.log ("a ** b =", a ** b)

// unary operator
// let a =5;
// let b =2;

// a++;
// console.log("a =",a)

// b--;
// console.log("b =",b)



//QNo#2.........................Var And Data Types

// let firstName = "Tuba";
// let lastName = "Rabi";

// let fullName = firstName + " " + lastName;
// console.log(fullName);



//QNo#3.........................Var And Data Types

// var isRaining = true;           // true condition
// console.log(isRaining);

// var isRaining = false;         // false condition
// console.log(isRaining);


//QNo#4.........................Var And Data Types

// var undefinedVar;
// console.log(undefinedVar);


//QNo#5.........................Var And Data Types

// var x = null;
// console.log(x);



//QNo#6.........................Var And Data Types

// var isRaining = true;
// var undefinedVar;

// console.log(typeof isRaining);
// console.log( typeof undefinedVar)



// Display Information
//QNo#1.........................Display Information

// alert("HELLO, WELCOME TO TOOBA's WORLD!");
// console.log("Hello my world");
// document.write("Hello My Tutti Frutti Duniya");



// DECISION-MAKING STATEMENTS
//QNo#1.........................DECISION-MAKING STATEMENTS

// var age = 20;

// if (age > 18) {
//     console.log("older");
// }
// if (age < 18) {
//     console.log("younger");
// }



//QNo#2.........................DECISION-MAKING STATEMENTS


// var number = 7;

// if (number % 2 === 0) {
//     console.log("The number is Even");
// } else {
//     console.log("The number is Odd");
// }



//QNo#3.........................DECISION-MAKING STATEMENTS

// var sub1 = (prompt("Enter marks for subject 1: "));
// var sub2 = (prompt("Enter marks for subject 2: "));

// var obtainedMarks = sub1 + sub2;
// var totalMarks = 200;
// var percentage = (obtainedMarks / totalMarks) * 100;

// var grade;
// if (percentage >= 80) {
//     grade = 'A';
// } else if (percentage >= 70) {
//     grade = 'B';
// } else if (percentage >= 60) {
//     grade = 'C';
// } else if (percentage >= 50) {
//     grade = 'D';
// } else {
//     grade = 'Fail';
// }

// console.log(obtainedMarks);
// console.log(percentage + "%");
// console.log( grade);



// Loop
//For Loop
//QNo#1.........................Loop                       

// for (let i = 0; i < 10; i++) {
// console.log(i);
//  }


//while Loop
//  for (let i = 1; i <= 5; i++) {
//  console.log(i);
//  }

// Do...While Loop

// for (let i = 1; i <= 5; i++) {
// console.log(i);
// }



// ARRAY 


//    var fruits = ["Apple', 'Banana', 'Cherry', 'Date', 'Elderberry"];
//    console.log(fruits);


//    console.log("3rd fruit :", fruits[2]);


//    fruits[3] = "Pineapple";
//    console.log(" replacing the 4th fruit:", fruits);

//    fruits.push("Banana");
//    console.log(" adding a fruit at the end:", fruits);


//    fruits.unshift("Kiwi");
//    console.log(" adding a fruit at the start:", fruits);


//    fruits.shift();
//    console.log(" removing the fruit at the start:", fruits);


//    for (var i = 0; i < fruits.length; i++) {
//    console.log(fruits[i]);
// }


//  console.log("Length of fruits :", fruits.length);


// Functions
//QNo#1.........................Functions                             

// function printHelloWorld() {
// console.log("Hello World");
// }

// printHelloWorld();

//QNo#2.........................Functions 

// function square(number) {
// return number * number;
//  }

// var result = square(9);
// console.log(result);


//QNo#3.........................Functions 


// function celsiusToFahrenheit(celsius) {
// return (celsius * 9 / 5) + 32;
// }


// var F = celsiusToFahrenheit(25);
// console.log(F);


// Objects


// var car = {
//     color: 'Red',
//     model: 'Mercedes',
//     year: 2020
// };

// console.log("Car Properties:");
// console.log("Color:", car.color);
// console.log("Model:", car.model);
// console.log("Year:", car.year);

// let carModel = car.model;

// console.log("The model of the car is:", carModel);




                              //DOM


// document.getElementById('greetButton').addEventListener('click', function () {
//     document.getElementById('message').textContent = "Hello! This is an Element, Node, and Event example.";
// });

// document.getElementById('scrollButton').addEventListener('click', function () {
//     const target = document.getElementById('target');
//     const targetPosition = target.getBoundingClientRect().top + window.scrollY;

//     window.scrollTo({
//         top: targetPosition,
//         behavior: 'smooth'
//     });
// });
















