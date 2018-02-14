var game = {};

game.init = function(){
	setupModeButtons();
	setupSquares();
	reset();
}

var numOfSquares = 6;
var colors = generateRandomColors(numOfSquares);

var squares = document.querySelectorAll(".square");
var pickedColor = pickColor();
var colorDisplay = document.getElementById("colorDisplay");
var messageDisplay = document.getElementById("message");
var h1 = document.querySelector("h1");
var resetButton = document.getElementById("reset");
var easyBtn = document.getElementById("easyBtn");
var hardBtn = document.getElementById("hardBtn");

game.init();

function setupModeButtons(){
	easyBtn.addEventListener("click", function(){
		easyBtn.classList.add("selected");
		hardBtn.classList.remove("selected");
		numOfSquares = 3;
		reset();
	})

	hardBtn.addEventListener("click", function(){
		easyBtn.classList.remove("selected");
		hardBtn.classList.add("selected");
		numOfSquares = 6;
		reset()
	});
}

function setupSquares(){
	for(var i = 0; i < colors.length; i++){
		squares[i].style.background = colors[i];
		squares[i].addEventListener("click", function(){
			var clickedColor = this.style.background;
			if(clickedColor === pickedColor){
				messageDisplay.textContent = "Correct";
				changeColor(pickedColor);
				h1.style.background = pickedColor;
				resetButton.textContent  = "Play Again";
			}else{
				messageDisplay.textContent = "Try Again";
				this.style.background = "#232323"
			}
		});
	}
}

resetButton.addEventListener("click", function(){
	reset();
});

function reset(){
	colors = generateRandomColors(numOfSquares);
	pickedColor = pickColor();
	colorDisplay.textContent = pickedColor;
	for(var i = 0; i < squares.length; i++){
		if(colors[i]){
			squares[i].style.background = colors[i]	;	
		}else{
			squares[i].style.display = "none";
		}
	}
	h1.style.background = "steelblue";
	resetButton.textContent = "New Colors";
}

function changeColor(color){
	for(var i = 0; i < squares.length; i++){
		squares[i].style.background = color;
	}
}

function pickColor(){
	var number = Math.floor(Math.random() * numOfSquares)
	return colors[number];
}

function generateRandomColors(numOfSquares){
	var arr = [];
	for(var i = 0; i < numOfSquares; i++){
		var r = Math.floor(Math.random() * 256);
		var g = Math.floor(Math.random() * 256);
		var b = Math.floor(Math.random() * 256);
		var value = "rgb(" + r + ", " + g + ", " + b + ")";
		arr.push(value);
	}
	return arr;
}