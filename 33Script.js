var answer = prompt('Are we there?');

while(answer.indexOf('yes') === -1){//yes does not exist in answer
	answer = prompt('Are we there?');
}
alert("Yay, we made it");