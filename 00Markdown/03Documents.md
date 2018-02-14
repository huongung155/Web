# Updating
- First way:
```javascript
Tank.findById(id, function(err, tank){
	if(err){
		console.log(err.message);
	}else{
		tank.size = 'large';
		tank.save(function(err, updatedTank){
			if(err){
				console.log(err.message);
			}else{
				console.log(updatedTank);
			}
		});
	}
})
```
- Second way: use `.set()` to modify documents
```javascript
Tank.findById(id, function(err, tank){
	if(err){
		console.log(err.message);
	}else{
		tank.set({size: 'large'});
		tank.save(function(err, updatedTank){
			if(err){
				console.log(err.message);
			}else{
				console.log(updatedTank);
			}		
		});
	}
})
```
- However, this approach first retrives the document from Mongo, then update(save). When we just want to update property db directly
```javascript
Tank.update({_id: id}, {$set: {size; large}}, callback)
```
- or
```javascript
Tank.findByIdAndUpdate(id, {$set: {size: 'large'}}, function(err, tank){
	if(err){
		console.log(err.message);
	}else{
		console.log(tank);
	}
});
```