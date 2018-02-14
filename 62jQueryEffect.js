//alert("CONNECTED");

/*$("button").on("click", function(){
	$("div").fadeOut(1000);	
	console.log("Fade Completed");
});*/

//If you write like this, console.log() will not wait until fadeOut completes
//To do that:
$("button").on("click", function(){
	$("div").fadeOut(1000, function(){
		console.log("Fade Completed");	
	});	
});

/*$("button").on("click", function(){
	$("div").fadeOut(1000, function(){
		$(this).remove();
	});
})*/
//After fadeOut(), this div wil remove

//when display: none, we can fadeIn
/*$("button").on("click", function(){
	$("div").fadeIn(1000, function(){
		
	});	
});

$("button").on("click", function(){
	$("div").fadeToggle(1000, function(){
		
	});	
});*/

/*$("button").on("click", function(){
	$("div").slideDown();
});*/

$("button").on("click", function(){
	$("div").slideUp();
});

$("button").on("click", function(){
	$("div").slideToggle(1000, function(){
		console.log("Slide is done");
		$(this).remove();
	});
});