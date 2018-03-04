# Methods
## Instance Methods
```javascript
var animalSchema = new Schema({name: String, type: String});
animalSchema.methods.instanceMethod = function(callback){
	return this.model('Animal').find({type: this.type}, callback)
};
```
- All of "Animal" instances have `instanceMethod`
```javascript
var Animal = mongoose.model('Animal', animalSchema);
var dog = new Animal({type: 'dog'});
dog.instanceMethod(function(err, dogs){
	console.log(dogs);
});
```

## Static Methods
```javascript
animalSchema.statics.findByName = function(name, callback){
    return this.find({name: new RegExp(name, 'i')}, callback);
};
var Animal = mongoose.model('Animal', animalSchema);
Animal.findByName('fido', function(err, foundAnimal){
    console.log(foundAnimal);
});
```

## Virtual
```javascript
var personSchema = new Schema({
    first: String,
    last: String
});
personSchema.virtual('fullName').get(function(){
    return this.first + ' ' + this.last;
})
var Person = mongoose.model('Person', personSchema);
var axl = new Person({first: 'Quan', last: "Luu"});
console.log(axl.fullName);
```
