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

# Advance Selectors (more [here](https://code.tutsplus.com/tutorials/the-30-css-selectors-you-must-memorize--net-16048))
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
```
* Apply Style to every single element
```css
*{
	border: 1px solid lightgrey;
}
```

* Descendant Selector(nested tag): style anchor tag which inside li tag
* Eg: `li .hello`: style class hello which inside li tag
```css
li a{
	color: red;
}
```

* Adjacent Selector: style `ul` tag which `h4` is next to
```css
h4 + ul{
	border: 4px solid red;
}
```

* Attribute Selector: style anchor tag which has `href=google.com`
* Eg: `input[type="checkbox"]`: style input which has this type
```css
a[href="http://www.google.com"]{
	background: blue;
}
```

* `nth-of-type`: style the `even`(second) ul in a group
```css
ul:nth-of-type(even){
	background: purple;
}
```
* With selector `input[type='text' checked]`
```css
input[type="text"]{

}

a:hover{

}
```

# Specificity
```css
body{
	color:red;
}
ul{
	color: blue;				
}
li{
	color: orange;
}
.highlight{
	color: yellow;
}
#special{
	color: pink 
}
```

# CSS the HTML
```html
<h1>Selectors Exercise</h1>

<p>PARAGRAPH NOT INSIDE A DIV</p>

<div>
  <p class="hello">I am a paragraph with a class</p>
  <p id="special">I am a paragraph with an ID</p>

  <h2>I am an awesome h2</h2>
  
  
  <p>Roof party yr hella synth, Wes Anderson narwhal four dollar toast before they sold out retro lo-fi. Austin iPhone pop-up farm-to-table, they sold out Portland wolf fanny pack YOLO.</p>

</div>

<div>
  <h2>Things I need to do</h2>

  <ul>
    <li>Walk Dog <input type="checkbox" checked> </li>
    <li>Feed Dog <input type="checkbox" checked> </li>
    <li>Wash Dog <input type="checkbox"></li>
  </ul>
</div>

<div>
  <h2>I am another awesome h2</h2>

  <p>Cardigan Tumblr mlkshk, fap tilde 3 wolf moon Portland. Heirloom health goth taxidermy blog lo-fi selfies. Lomo sustainable put a bird on it trust fund post-ironic</p>

  <p>I'm the second paragraph inside this div!</p>
</div>

<p>PARAGRAPH NOT INSIDE A DIV</p>


<div>
  <h2>A less awesome h2</h2>

  <p>Roof party yr hella synth, Wes Anderson narwhal four dollar toast before they sold out retro lo-fi. Austin iPhone pop-up farm-to-table. Flannel listicle health goth asymmetrical freegan mixtape street art pour-over whatever</p>

  <p>One last paragraph here!</p>

  <a href="http://www.facebook.com">I am a link to facebook</a>
  <a href="http://www.facebook.com">I am another link to facebook</a>
  <br>

  <input type="text" name="name" /><label> Name</label><br/>
  <input type="password" name="password" /><label> Password</label><br/>

</div>

<p>PARAGRAPH NOT INSIDE A DIV</p>
```

```css
/* Give the <body> element a background of #bdc3c7*/
body{
	background: #bdc3c7;
}

/* Make the <h1> element #9b59b6*/
h1{
	color: #9b59b6;
}

/* Make all <h2> elements orange */
h2{
	color: orange;
}

/* Make all <li> elements blue(pick your own hexadecimal blue)*/ 
li{
	color: blue;
}

/*Change the background on every paragraph to be yellow*/
p{
	background: yellow;
}

/* Give everything with the class 'hello' a white background*/
.hello{
	background: white;
}

/* Give the element with id 'special' a 2px solid blue border(pick your own rgb blue)*/
#special{
	border: 2px solid rgb(0, 100, 200);
}
```
* Make all inputs have a `3px red` border
```css
input{
	border-width: 3px;
	border-color: red;
}
```
* Make all the `<p>`'s that are nested inside of `divs` 25px font(`font-size: 25px`)
```css
div p{
	font-size: 25px;
}
```
* Make only inputs with type `text` have a gray background
```css
input[type="text"]{
	background: gray;
}
```
* Give both `p`'s inside the 3rd `div` a pink background
```css
div:nth-of-type(3) p{
	background: pink
}
```
* Give the 2nd `p` inside the 3rd `div` a `5px white` border
```css
div:nth-of-type(3) p:nth-of-type(2){
	border-width: 5px;
	border-color: white;
}
```
* Make the `em` in the 3rd `div` element white and 20px font(`font-size:20px`)
```css
div:nth-of-type(3) em{
	font-size: 20px;
	color: white;
}
```
* Make all `checked` checkboxes have a left margin of 50px(`margin-left: 50px`)
```css
input:checked{
	margin-left: 50px;
}
```
* Make the `label` elements all UPPERCASE
```css
label{
	text-transform: uppercase;
}
```
* Make the `first letter` of the element with id `special` green and 100px font size(`font-size: 100`)
```css
#special:first-letter{
	color: green;
	font-size: 30px;
}
```
* Make the `h1` element's color change to blue when hovered over
```css
h1:hover{
	color: blue;
}
```