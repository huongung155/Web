function isEven(number){
	if(number % 2 == 0){
		return true;
	}
	return false;
}
function factorial(number){
	if(number === 1){
		return 1;			
	}
	return number * factorial(number - 1);
}
function kebabToSnake(yourString){
	var newStr = yourString.replace(/-/g, "_");
	return newStr;
}
var number = prompt("Input number");
console.log(isEven(number));
console.log(factorial(number));
var yourString = prompt("Input the string");
console.log(kebabToSnake(yourString));