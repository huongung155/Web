secretNo = 4;

//ask user for guess
guess = prompt('Guess a number');

//check if guess is right
if(Number(guess) === secretNo){
	alert('You guess right');
}else if(Number(guess) > secretNo){
	alert('Too high. Guess again');
}else{
	alert('Too low. Guess again');
}