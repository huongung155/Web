//https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=10d2cc9fb914a4869b8b5cd6b400041cc&authkey=AWQHjtCsxEzI2_b93Y3BcW0
//https://mphcmiuedu-my.sharepoint.com/personal/ititiu15033_student_hcmiu_edu_vn/_layouts/15/guestaccess.aspx?docid=18a75bee6949b499f9a82a384c702f2d4&authkey=AXbtPpLhDdf83FGsiqPJKr0

var colors = [
	"rgb(255, 0, 0)",
	"rgb(255, 255, 0)",
	"rgb(0, 255, 0)",
	"rgb(0, 255, 255)",
	"rgb(0, 0, 255)",
	"rgb(255, 0, 255)"
];

var squares = document.querySelectorAll(".square");
var pickedColor = colors[3];
var colorDisplay = document.getElementById("colorDisplay");

colorDisplay.textContent = pickedColor;

for(var i = 0; i < squares.length; i++){
	// add initial colors to squares
	squares[i].style.background = colors[i];

	//add click listeners to squares
	squares[i].addEventListener("click", function() {
		//grab color of clicked squares
		var clickedColor = this.style.background;
		//compare color to pickedColor
		if(clickedColor === pickedColor) {
			alert("Correct!");
		} else {
			alert("WRONG!!!");
		}
	});
}

