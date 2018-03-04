# Global plugins
- Schemas are pluggable, that is, they allows for integrating external functions to extend schemas functionality
- Suppose we want to add last-modified function
```javascript
// lastMod.js
module.exports = exports = function lastModifiedPlugin(schema, options){
	schema.add({lastMod: Date});

	schema.pre('save', function(next){
		this.lastMod = new Date();
		next();
	});

	if(options && options.index){
		schema.path('lastMod').index(option.index);
	}
}

// gameSchema.js
var lastMod = require('./lastMod');
var gameSchema = new Schema({...});
gmaeSchema.plugin(lastMod, {index: true});

// playSchema.js
var lastMod = require('./lastMod');
var playerSchema = new Schema({...});
playerSchme.plugin(lastMod);
```

# Global plugins
- Want to apply plugin to all schema
``javascript
var mongoose = require('mongoose');
mongoose.plugin(require(./lastMod));
// Now this plugin get attached to all schema
var gameSchema = new Schema({...});
var playerSchema = new Schema({...});
```