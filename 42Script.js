var todos = [];

var input = prompt("What would you like to do?");

while(input !== "quit"){
	if(input === "list"){
		console.log("**************");
		todos.forEach(function(todo, i){
			console.log(i + ": " + todo);
		});
		console.log("**************");
	}else if(input === "new"){
		var newTodo = prompt("Enter new todo");
		todos.push(newTodo);
		console.log("Added Todo");
	}else if(input === "delete"){
		var index = prompt("Enter index of todo to delete");
		todos.splice(index, 1);// remove 1 item at index-index position
		console.log("Deleted Todo");
	}
	input = prompt("What would you like to do?");
}
console.log("OK, YOU QUIT");