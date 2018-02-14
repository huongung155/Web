//Check off specific todos by clicking
/*$("li").click(function(){
	if($(this).css("color") === "rgb(128, 128, 128)"){
		$(this).css({
			color: "black",
			textDecoration: "none"
		});
	}else{
		$(this).css({
			color: "gray",
			textDecoration: "line-through"
		});
	}	
});*/

//jquery only add click/ listerner only when the code runs, so
//if you write like code below, jquery only add code in exist li
//at the time the code runs. When you add more li in UI, jquery will not
//add click/ listerner for that li
/*$("li").on("click", function(){
	$(this).toggleClass("completed");//toggle in li which parent is ul
})*/
//To avoid that, we jquery for ul which include all li regardless of the existed li or li
//you add in UI
$("ul").on("click", "li", function(){
	$(this).toggleClass("completed");//toggle in li which parent is ul
})

//Click X to delete todos
//$("span").click(function(){
//	alert("Clicked on the span");
//});//When clicking on Span and the li is parent of span which means you click li, ul is parent of li which means you click ul
//To avoid that we use stopPropagation():
$("ul").on("click", "span", function(event){
	$(this).parent().fadeOut(500, function(){
		$(this).remove();
	});
	event.stopPropagation();
});

$("input[type='text']").keypress(function(event){
	if(event.which === 13){
		var todoText = $(this).val();
		$(this).val("");
		$("ul").append("<li><span><i class='fa fa-trash'></i></span> " + todoText + "</li>");
	}
})

$(".fa-plus").click(function(){
	$("input[type='text']").fadeToggle();
})