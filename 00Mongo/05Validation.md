# Built-in validators
- Number has `min and max` validators
- Strings has `enum, match, maxlength and minlength` validators
- Date has `default: Date.now()`
```javascript
var breakfastSchema = new Schema({
	eggs: {
		type: Number,
		min: 5,
		max: 12
	},
	bacon: {
		type: Number,
		required: true
	},
	drink: {
		type: String,
		enum: ['Coffee', 'Tea'],
		required: function(){
			return this.bacon > 3;
		}
	}
})
```
# `unique` is not validators
```javascript
var uniqueUsernameSchema = new Schema({
	username: {
		type: String,
		unique: true
	}
});
```

# Custom Validators
```javascript
var campgroundSchema = new Schema({
	name: String,
	imageURL: {
		type: String,
		validate: {
			validator: function(url){
				return /^https:\/\/images\.unsplash\.com\/.*/.test(url);
			},
			message: '{VALUE} is not unsplash image'
		}
	}
});
```