<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Math and Functions</title>
</head>
<body>
    <h1>PHP Math Functions</h1>
    <p>
        <?php
        // Math Methods
        echo "The value of PI is: " . pi() . "<br>";
        echo "The Min value is: " . min(10, 150, 30, 20, -8, -200) . "<br>";
        echo "The Max value is: " . max(10, 150, 30, 20, -8, -200) . "<br>";
        echo "The absolute value is: " . abs(-25) . "<br>";
        echo "The square root of 16 is: " . sqrt(16) . "<br>";
        echo "Random number between 1 and 50: " . rand(1, 50) . "<br>";
        ?>
    </p>

    <h1>PHP Custom Functions</h1>
    <p>
        <?php
        // Include custom functions
        include 'functions.php';

        // Call a custom function
        echo sayHello(); // Output: Hello, World! <br>

        // Call a function with parameters
        echo "Sum of 5 and 10 is: " . add(5, 10); // Output: 15 <br>

        // Call a function with default value
        greet(); // Output: Hello, Guest! <br>
        greet("John"); // Output: Hello, John! <br>
        ?>
    </p>
</body>
</html>
