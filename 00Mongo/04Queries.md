# 2 types of queries
- JSON Object
```javascript
// selecting the `name` and `occupation` fields
Person.findOne({'name.last': 'Ghost'}, 'name occupation', function(err, person){
	if(err){
		console.log(err.message);
	}else{
		console.log('%s %s is a %s', person.name.first, person.name.last, person.occupation)
	}
})
```
- Chaining Syntax
```javascript
// With a JSON doc
Person.find({
	occupation: /host/,
	'name.last': 'Ghost',
	age: {$gt: 17, $lt: 66},
	likes: {$in: ['vaporizing', 'talking']}
}).
limit(10).
sort({occupation: -1}).
select({name: 1, occupation: 1}).
exec(callback);

// Using query builder
Person.find({occupation: /host/}).
where('name.last').equals('Ghost').
where('age').gt(17).lt(66).
where('likes').in(['vaporizing', 'talking']).
limit(10).
sort('-occupation').
select('name occupation').
exec(callback)
```