# About Me
```html
<html>
<head>
	<title>About Me</title>

	<link rel="stylesheet" type="text/css" href="11AboutMe.css">
</head>
<body>
	<h1>About Me</h1>
	<h4>My Hobbies:</h4>
	<ul>
		<li>Playing guitar</li>
		<li>Cooking</li>
		<li>Origami</li>
	</ul>
	<div>rgba is to make rgb more transparent, from 0 to 1</div>
</body>
</html>
```
* More color on css [here](http://colours.neilorangepeel.com)
```css
h1{
	color: #FF8000;
	border: 5px solid purple;
}

li{
	color: rgb(0, 0, 255);
}
h4{
	color: rgba(0, 000, 255, .2);
}
body{
	background: url(https://c.pxhere.com/photos/c6/1a/deck_wooden_rain_water_slick_slippery-1261602.jpg!d);
	background-repeat: no-repeat;
	background-size: cover;
}
```

# Selectors
```html
<h1>Todo List</h1>
<ul>
	<li class="completed"><input type="checkbox" checked>Walk Rusty</li>
	<li class="completed"><input type="checkbox" checked>Buy Groceries</li>
	<li id="special"><input type="checkbox">Finish recording CSS Videos</li>
</ul>
```
```css
li{
	border: 2px solid red;
}
#special{
	background: yellow;
}
.completed{
	text-decoration: line-through;
}
```

# Advance Selectors
```css
/*Element*/
li{

}
/*class*/
.hello{

}
/*id*/
#name{

}
ul#name{
	
}
/*Star: Apply Style to every single element*/
*{
	border: 1px solid lightgrey;
}

/*Descendant Selector(nested tag): style anchor tag which inside li tag. Eg: li .hello: style class hello which inside li tag*/
li a{
	color: red;
}

/*Adjacent Selector: style ul tag which h4 is next to*/
h4 + ul{
	border: 4px solid red;
}

/*Attribute Selector: style anchor tag which has href=google.com. Eg: input[type="checkbox"]: style input which has this type*/
a[href="http://www.google.com"]{
	background: blue;
}

/*nth of type: style the even(second) ul in a group*/
ul:nth-of-type(even){
	background: purple;
}
```