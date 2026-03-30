
class Vehicle {

    constructor (make, model, year, color){
        this.make=make;
        this.model=model;
        this.year=year;
        this.color=color;
    }
    
    start() {
        console.log(`${this.make} car is starting. Model of car is ${this.model}. Color of car is ${this.color}.`);
    }
    
    stop() {
        console.log(`The ${this.make} ${this.model} is stopping.`);
    }
    
    reverse() {
        console.log(`The ${this.make} ${this.model} is reversing.`);
    }
    }
    
    var obj =new Vehicle("landcruiser", "Model Z", 2023, "Red")
    
    console.log("Vehicle Name:",obj.make)
    console.log("Model:",obj.model)
    console.log("Model of year is:", obj.year)
    console.log("Color of car is:", obj.color)

    
    console.log(obj.start())
    console.log(obj.stop())
    console.log(obj.reverse())