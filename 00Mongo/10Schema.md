- `Model.prototype`: comment, req.campground
- `Model`: Comment, Campground

# Schema.prototype.add()
```javascript
var toySchema = new Schema({...});
toySchema.add({name: 'string', color; 'string', price: 'number'});
```

# Transform
- Sometimes, we need to transform the resulting object based on some criteria
```javascript
function(doc, ret, options){}
```
- `doc` The mongoose document is being converted
- `ret` The plain object representaiton has been converted
- `options` (either schema options or the options passed inline)
```javascript
var campgroundSchema = new Schema({
	name: Stirng,
	image: String
});

// specify the transform schema option
if(!campgroundSchema.options.toObject){
	campgroundSchema.options.toObject = {};
}
campgroundSchema.options.toObjet.transform = function(doc, ret, options){
	// remove the name of every document before returning the result
	delete ret.name;
	return ret;
}

// with the transformation
doc.toObject(); // {image: 'https://unsplash.com/...'}
```
- We can do a lot with transformation even return completely new objects
```javascript
var campgroundSchema = new Schema({
	name: Stirng,
	image: String
});

// specify the transform schema option
if(!campgroundSchema.options.toObject){
	campgroundSchema.options.toObject = {};
}
campgroundSchema.options.toObjet.transform = function(doc, ret, options){
	return {image: ret: image};
}
// with the transformation
doc.toObject(); // {image: 'https://unsplash.com/...'}
```

# Model.prototype.remove()
```javascript
router.delete('/:id', checkCampground, function(req, res) {
    Comment.remove({
        _id: {
            $in: req.campground.comments
        }
    }, function(err) {
        if(err) {
            req.flash('error', err.message);
            res.redirect('/');
        } else {
            req.campground.remove(function(err) {
                if(err) {
                    req.flash('error', err.message);
                    return res.redirect('/');
                }
                req.flash('error', 'Campground deleted!');
                res.redirect('/campgrounds');
            });
        }
    })
});
```
```javascript
Character.remove({name: 'Eddard Stark'}, function(err){});
```

# Model.deleteOne()
- Like `Model.remove()`, but just delete one element
```javascript
Character.deleteOne({name: 'Eddar Stark'}, function(err){})
```

# Model.deleteMany()
```javascript
Character.deleteMany({name: /Stark/, age: {$gte: 18}}, function(err){})
```

# Model.find()
```javascript
Campground.find({name: 'john', age: {$gte: 18}}, function(err, foundCAmpground){})

// name LIKE john and only selecting 'name' and 'image' fields
Campground.find({name: /john/i}, 'name image', function(err, foundCampground){})
```

# Model.findById()
```javascript
Campground.findById(id, 'name length', function(err, foundCampground){});
Campground.findById(id, 'name length').exec(callback);
Campground.findById(id, '-length').exec(function(err, foundCampground){})
```

# Model.findOne()
```javascript
CampgroundfindOne({type: iphone}, 'name', function(err, foundCampground){})
Campground.findOne({type: 'iphone'}).select('name').exec(callback);
```

# Model.count()
- Counts the number of matching documents in a database
```javascript
Campground.count({price: 2.23}, function(err, count){
	if(err){
		...
	}else{
		console.log('There are %d', count);
	}
})
```

# Model.where()
```javascript
Campground.find({price: {$gte: 2.23, $lte: 4.45}}, callback);
```
- We can instead write
```javascript
Campground.where('price').gte(2.23).lte(4.45).exec(callback);
```

```javascript
Users.where('age').equals(49)
// are equals
Users.where('age', 49)
```
# Model.findOneAndUpdate()

# Model.findByIdAndUpdate()

# Model.findOneAndRemove()

# Model.findByIdAndRemove()

# Model.update()
```javascript
Campground.update({id: req.params.id}, {$set: newData}, function(err, updatedCampground){})
```

# Model.aggregate()
- When we want to do multiple queries
```javascript
Users.aggregate(
	{$group: {_id: null, maxBalance: {$max: '$balance'}}},
	{$project: {_id: 0, maxBalance: 1}},
	function(err, users){
		if(err){
			console.log(err.message);
		}else{
			console.log(users);
		}
	}
)
```
- Or pipeline builder
```javascript
Users.aggregate()
.group({_id, maxBalance: ($max: '$balance')})
.select('-id maxBalance')
.exec(function(err, user){
	if(err){
		console.log(err.message);
	}else{
		console.log(users);
	}
})
```

# Query.prototype.or()
```javascript
Campground.find({name: /john/i}).or([{color: 'red', {status: 'emergency'}}]).exec(function(err, foundCampground){})
```

# Query.prototype.nor()

# Query.prototype.and()

# Query.prototype.gt()
```javascript
Campground.find().where('price').gt(2.23)
// or
Campground.find().gt('price', 2.23)
// or
Campground.find({price: {$gt: 2.23}})
```

# Query.prototype.gte()

# Query.prototype.lt()

# Query.prototype.lte()

# Query.prototype.ne()
## not equal
```javascript
Users.where('age').ne(49)
// or
Users.find().ne('age', 49)
// or
Users.find({age: {$ne: 49}})
```

# Query.prototype.in()
```javascript
User.where('age').in([49, 43, 45])
// or
Users.find().in('age', [49, 43, 45])
// or
Users.find({age: {$in: [49, 43, 45]}})
```

# Query.prototype.nin()
## not in

# Query.prototype.all()
- $all selects the documents where the value of a field is an array that coontains all the specified elememts
```javascript
User.where('age').all([49, 43, 45])
// or
User.find().all('age', [49, 43, 45])
// or
User.find({age: {$all: [49, 43, 45]}})
```

# Query.prototype.size()
```javascript
User.where('age').size(0).exec(function(err, foundUser){
	if(err){
		...
	}else{
		console.log('The user document is now has 0 user')
	}
});
// or
User.find().size('age', 0)
// or
User.find({age: {$size: 0}})
```

# Query.prototype.regex()
```javascript
User.where('name').regex(/acme.*corp/i).nin(['acmeblahcorp'])
User.find().regex('name', /acme.*corp/i).nin('name', ['acmeblahcorp'])
User.find({name: {$regex: /acme.*corp/i, $nin: ['acmeblahcorp']}})
```

# Query.prototype.sort()
```javascript
// sort by 'name' ascending and 'test' descending
User.sort({name: 'asc', test: -1})
// or
User.sort('name -test')
```

# Query.prototype.remove()
```javascript
User.remove({name: 'Anne Murray', callback})
```