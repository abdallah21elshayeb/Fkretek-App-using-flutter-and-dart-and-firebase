// const name = "ahmed";
// const birthdate = 1999;
// const faculty = "eng";


// const name1 = " mohammed";
// const birthdate1 = 1999;
// const faculty1 = "eng";

// function getAge(date) {
//   return new Date().getFullYear() - date;
// }


// class Person{
//     name;
//     date;
//     faculty;
//     constructor(name,date,faculty){
//         this.name = name
//         this.date = date
//         this.faculty = faculty
//     }
//     getAge = ()=>{
//         return new Date().getFullYear() - this.date;
//     }
// }

// const Ahmed =  new Person("Ahmed",1999,"ENG")
// const Mohammed =  new Person("Mohmmed",1999,"ENG")

// Ahmed.getAge()


class Shape{
    area(){
        return 1
    }
    printShape(){
        console.log("this is shape");
    }
}

class Square extends Shape{
    width;
    constructor(width){
        super()
        this.width = width
    }

    area(){
        return this.width * this.width 
    }
    // printShape(){
    //     console.log("this shape is square"); 
    // }
}
class Circle{
    radius;
    constructor(radius){
        this.radius = radius
    }

    area(){
        return Math.PI * this.radius ^ 2 
    }
    printShape(){
        console.log("this shape is cirlce"); 
    }
}
class Triangle{
    base;
    height;
    constructor(base,height){
        this.base = base
        this.height = height
    }

    getArea(){
        return 0.5 * this.base * this.height 
    }
    printShapeName(){
        console.log("this shape is triangle"); 
    }
}

const s1  = new Square(10)

console.log(s1.area());

s1.printShape()
const sh1  = new Shape()

console.log(s1.area());

s1.printShape()