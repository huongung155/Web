# OOP in Javascript
* But JS does not have "classes" build into it
* We use functions and objects

# Object Creation
* Imagine we want to make a few house objects which all will have bedrooms, bathrooms and sqFeet

## Constructor functions
```javascript
functions House(bedrooms, bathrooms, numSqft){
	this.bedrooms = bedrooms;
	this.bathrooms = bathrooms;
	this.numSqft = numSqft;
}
```
* So what soes `new` actually do? A lot more than we thik
	* It first creates an empty object
	* It then sets the `this` to be that empty object
	* It adds the line `return this` to the end of the function, which follows it
	* It adds a property onto the empty object call `__proto__` which links the prototype property on the constructor funciton to empty object

## Exercise
```javascript
function Dog(name, age){
	this.name = name;
	this.age = age;
	this.bark = function(){
		console.log(this.name + ' just barked')
	}
}
var rusty = new Dog('Rusty', 3)
rusty.bark()
```
> Rusty just barked
* Now `rusty` has object
```javascript
var rusty = {
	name = 'Rusty',
	age = 2,
	bark: function(){
		console.log(this.name + ' just barked')
	}
}
```
* And `this` is in `rusty`
## Abstract for Car and Motorcycle
```javascript
function Car(make, model, year){
	this.make = make;
	this.model = model;
	this.year = year;
	this.numWheels = 4;
}

function Motorcycle(make, model, year){
	Car(make, model, year);
	this.numWheels = 2;
}
```
* That's the wrong way because when we call `Car(make, model, year)`, `this` will be in `Car`, we need it in `Motorcycle`
```javascript
function Car(make, model, year){
	this.make = make;
	this.model = model;
	this.year = year;
	this.numWheels = 4;
}

function Motorcycle(make, model, year){
	Car.call(this, make, model, year);
	this.numWheels = 2;
}
```
* Now we call `Car.call(this, make, model, year)` with `this` in `Motorcycle`
* Or we can do it with `apply`
```javascript
function Car(make, model, year){
	this.make = make;
	this.model = model;
	this.year = year;
	this.numWheels = 4;
}

function Motorcycle(make, model, year){
	Car.apply(this, arguments);
	
```
* Here we use `arguments` as list of `[make, model, year]`, we can use either of them

# Prototype
![alt text](https://746lia.ch.files.1drv.com/y4mNhZ-JwyimR7VydBJ-994y6HytECuJIQsrPs2yStd1RF3poknm95ZJZLno7DF6pcYtK-OQ6ue538oDyN7qg9muc87rfmB1Ng5KQ3gEqZSoUmPuFQgWDTiBznk92V9TnZu50ifVftxY1aNfAsz5TXKsM4Ng_8XVOTHDyJ2lj6FiJvU0iiyup-dicIP62vPR5DSZ0b577KE48pF8nFSvW5lrg/Capture17.PNG?psid=1)
* Every constructor function has a property on it called `prototype` which is an object
* The prototype object has a property on it called `contructor` which points back to the constructor function
* Anytime an object is created using `new`, a prototype called `__proto__` gets created, linking the object and the prototype property of the constructor function
```javascript
function Person(name){
	this.name = name
}
Person.prototype
```
![alt text](https://woz0iq.ch.files.1drv.com/y4m16IKLqWNOyOK25r6lFeRCurz1_MQlRPYR7kgq_wCwVKR7rw7XriDpBFDtep_L0A-qdMEvD9JmAHEso4wrcZc2tfCF9nUiXiZtlUiUoClq49mc_x7hDL9UFOdzbTndOC32_HpUhoHjzS9Nao7IagspeRBTAJip3pCCy_wSier1Mr05lrBrAOEFwUuY-BPssWjiJ7HpbSGzzyu3cCfxxKnzA/Capture18.PNG?psid=1)
```javascript
var elle = new Person('Elle');
```
* Since we used `new`, we have set up a link between the object and the prototype property
```javascript
elle.__proto__ === Person.prototype
Person.prototype.constructor === Person
```
> True  
> True
```javascript
function Person(name){
	this.name = name;
}

var elle = new Person('Elle');

Person.prototype.isInstructor = true;

elle.isInstructor;
```
> true
* JS will find property or method inside object, next it finds inside the `prototype` of this object
* This is how JS find methods and properties
![alt text](https://woxzrq.ch.files.1drv.com/y4mdxOvj7SUhXnghcrYbauyqj0AJT65prLDSQTozVigwL3nH0T5WcTYPeFA19-sjormiyFDFIaUDQaQ1zdZDmv1VVSVWV34VqsfH57BbuZ4PcEOFgMelY8sPLp4-PQO2cdBcknCBbxjLm329qqLdz5Lonm8CmwBj0o5NlX_gI10BdzosAb0pD1Z_Xtp3bue9LN8bLEvgNUAclpzPDT_hMDATQ/Capture19.PNG?psid=1)
* Again circles are functions and squares are objects
* Let analyze the above nearest JS code
	* This is `dir(elle)`
* ![alt text](https://wowqcw.ch.files.1drv.com/y4mlpao-kZTkF9Zm7aGSinwmqiF1WGBwCSKVGlNDdiO9CGVxyZhoqYXDc4LvPNFHudg9wJ-7vlJ0ycG_TvJrq2VOMVHF7iV1bHf0-gDcWaEAE-ZS70dozdSZVgDVLHopNg7N8yxw2HeE6kDR3uXT6h8n5Ny1AA4myAfMFQnehox5YJ6wLnYXFOWXigOmOw4tmHDuap5rVN24pW47mSUzBM4Tw/Capture20.PNG?psid=1)
	* See that `elle.__proto__` = `Person.prototype` and this is:
* ![alt text](https://woyplg.ch.files.1drv.com/y4mry5hQp94JWGi6Y-YtOESmoknIL-eF4S6usqWPS9l3stHtGN4gYSMmm7KnefHcV5uR0b6H496IWz6hpBzJCveMDsPg2vNwhb36JlO3bImIUPjHVsG65ZX8a7BOIGTD99unRd-fPGRtcS9Fj_amjkiFcE2NaOefyY5hDMUFV4Tp0ndRBUK7WJy7ZuI-VK_KlpeBurmwuHlFRNkDj9kIqmvOw/Capture21.PNG?psid=1)
	* Inside it, we also have `__proto__`
* ![alt text](https://woyitw.ch.files.1drv.com/y4mTzMfL9ghMsznwq4mOR2poIzRcobgheHeKAH_PLzfjx_JDFYcxQhYuCrmxVtJ3N9yzAbqmXoOYYFtn_011v1f3GSzAimjOyllmgnbdIATc2LfTQYEjEG4vHHoxckQAVdHL77Gw1csOIMknnMYDUqcTp7oT6qZ9xKfhLCjqjgOHfePBCDTFre61fpDtjhxQvt-jDJA3DppSQUwgPu2ZNiaAA/Capture22.PNG?psid=1)