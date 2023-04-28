// const name = "ahmed";
// const birthdate = 1999;
// const faculty = "eng";

// const name1 = " mohammed";
// const birthdate1 = 1999;
// const faculty1 = "eng";

// function getAge(date) {
//   return new Date().getFullYear() - date;
// }

class Person{
    name;
    date;
    faculty;
    constructor(name,date,faculty){
        this.name = name
        this.date = date
        this.faculty = faculty
    }
    get Age(){
        return new Date().getFullYear() - this.date;
    }
    set Date(date){
        if(date <1950) return;
        if(date > new Date().getFullYear()) return
        this.date = date
    }
    static getCounter(){
        console.log(1);
    }
}

const Ahmed =  new Person("Ahmed",1999,"ENG")
Ahmed.Date = 1998
console.log(Ahmed.Age)

// class Shape{

//     constructor(color,typesahpe){
//     }
//     area(){
//         return 1
//     }
//     printShape(){
//         console.log(`this is shape ${this.typesahpe}`);
//     }

// }

// class Square extends Shape{
//     width;
//     constructor(width,color){
//         super(color,'square')
//         this.width = width
//     }

//     area(){
//         return this.width * this.width
//     }

// }
// class Circle extends Shape{
//     radius;
//     constructor(radius){
//         this.radius = radius
//     }

//     area(){
//         return Math.PI * this.radius ^ 2
//     }

// }
// class Triangle{
//     base;
//     height;
//     constructor(base,height){
//         this.base = base
//         this.height = height
//     }

//     getArea(){
//         return 0.5 * this.base * this.height
//     }

// }

// const s1  = new Square(10)

// console.log(s1.area());

// s1.printShape()
// const sh1  = new Shape()

// console.log(s1.area());

// s1.printShape()


