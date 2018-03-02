# Objectives
* Define what the keyword `this`
* 4 ways to figure out what keyword `this` is
* Try the best not to use `this`

# What's `this`
* 4 rules: global, object/implicit, explicit, new

# Global object
* When `this` is not inside declared object, its value is the global object
```javascript
console.log(this)
```
> Window

# Global with `Strict` in ES5
* Easily make a mistake when declaring global var inside function
```javascript
function mistake(){
	this.badIdea = 'oops'
}
mistake()
badIdea
```
> oops
```javascript
//in Strict Mode
function variablesInThis(){
	this.person = 'Elle'
}
variablesInThis()	//TypeError, can't set person on undefined
```

# Implicit/Object
* When `this` is found inside of a declared object, the value `this` is the closest parent object
```javascript
var person = {
	firstName: 'Elle',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	}
}
person.sayHi()
```
> Hi Elle
```javascript
var person = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	},
	dog:{
		sayHello: function(){
			return 'Hello ' + this.firstName;
		}	
	}
}
person.dog.sayHello()
person.sayHi()
```
> Hello undefined  
> Hi Colt

# Explicit Binding
|Name of method|Parameters|Invoke immediately|
|----------|-------------------|---|
|Call|thisArg, a, b, c, d, ..|Yes|
|Apply|thisArg, [a, b, c, d, ..]|Yes|
|Bind|thisArg, a, b, c, d, ..|No|

## `Call`
* Fix above code with `call`
```javascript
var person = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	},
	dog:{
		sayHello: function(){
			return 'Hello ' + this.firstName;
		}	
	}
}
person.dog.sayHello.call(person)
person.sayHi()
```
> Hello Colt  
> Hello Colt
* `call` will get `this` from `person`
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	}
}

var elie = {
	firstName: 'Elle',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	}
}

colt.sayHi()
elle.sayHi()
```
> Hi Colt  
> Hi Elle
* How can we succint the code with `call`
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	}
}

var elle = {
	firstName: 'Elle'
}

colt.sayHi()
colt.sayHi.call(elle)
```
> Hi Colt  
> Hi Elle

## `Apply`
* It's almost identical to call - except parameters
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName
	},
	addNumbers: function(a, b, c, d){
		return this.firstName + ' just calculated ' + (a + b + c + d)
	}
}

var elle = {
	firstName: 'Elle'
}
// With call
colt.sayHi.call(elle)
colt.addNumbers.call(elle, 1, 2, 3, 4)

colt.sayHi.apply(elle)
colt.addNumbers.apply(elle, [1, 2, 3, 4])
```
> Hi Elle  
> Elle just calculated 10  
> Hi Elle  
> Elle just calculated 10

## `Bind`
* The parameter work like call, but `bind` returns a function with the context of `this` bound already
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		return 'Hi ' + this.firstName;
	},
	addNumbers: function(a, b, c, d){
		return this.firstName + ' just calculated ' + (a + b + c + d);
	}
}

var elle = {
	firstName: 'Elle'
}

var elleCalc = colt.addNumbers.bind(elle, 1, 2, 3, 4);
elleCalc();

var elleCalc2 = colt.addNumbers.bind(elle, 1, 2)
elleCalc(3, 4)
```
> Elle just calculated 10  
> Elle just calculated 10

### Tricky about `Bind`
* More correct, value `this` will get the object that `this` closest function belongs to. Check below
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		setTimeout(function(){
			console.log('Hi ' + this.firstName);
		}, 1000)
	}
}

colt.sayHi()
```
> Hi undefined  
* Clear that `this` will get object `window` that `this` closest function `setTimeout()` belongs to
* to rectify it: use `bind`
```javascript
var colt = {
	firstName: 'Colt',
	sayHi: function(){
		setTimeout(function(){
			console.log('Hi ' + this.firstName);
		}.bind(this), 1000)
	}
}

colt.sayHi()
```
> Hi Colt
* We use `bind` because `bind` will return function and `this` in `bind(this)` will get object `colt` that `this` in `bind(this)` closest function `sayHi` belongs to

# `new` keyword
```javascript
function Person(firstName. lastName){
	this.firstName = firstName;
	this.lastName = lastName;
}
```
* it's bad practice when compard to above part because it declares glabally `firstName` and `lastName` in function
* But with `new`, it's whole differnet
```javascript
var elle = new Person('Elle', 'Schoppik');

elle.firstName;
elle.lastName;
```
> Elle  
> Schoppik

# Recap
* The keyword `this` is a reserved keyword in JS and its value is determined at execution
* It's either set using the global context, object binding, explicit binding or `new` keyword
* When set i nthe global context in a function, it's either the global object (`window`) or undefined (if we use strict mode)
* To explicitly set the value of the keyword `this`, we use `call`, `apply`, `bind`
* We can also use the `new` keyword to set context of `this`, which is discussed in OOP