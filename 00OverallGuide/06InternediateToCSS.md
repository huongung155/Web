# Text and Fonts
* `em`: size of font that applies to the parent of the element. Ifyou haven't set the font size anywhere on the page, it uses browser default, probably 16px, so 1em = 16px
```html
<head>
	<title>Fonts</title>
	<link rel="stylesheet" type="text/css" href="16Style.css">
	<link href="https://fonts.googleapis.com/css?family=Encode+Sans+Condensed|Slabo+27px" rel="stylesheet">
	/*Copy font website from fonts.google.com*/
</head>
<body>
	<h1>Fonts Demo Page</h1>
	<p>Doner tongue pork chop, <span>steak shankle landjaeger meatball</span> flank. Bresaola landjaeger shank short loin chicken andouille tail picanha, salami swine.</p>

	<p>Fatback pork chop sirloin swine bacon. Cow beef ground round boudin alcatra, bresaola pig pastrami spare ribs sausage pork chop corned beef pancetta. Shank kielbasa cow pastrami boudin.</p>	
</body>
```

```css
body{
	font-size: 10px
}
span{
	font-size: 2.0em;
}

h1{
	text-align: center;
}

h1{
	text-decoration: underline;
}
span{
	text-decoration: line-through;
}
```
* `font-weight`: define how thick the lines are (value: from 100 to 800)
```css
p{
	font-weight: 200;
}
```
* `line-height`: distance between two lines
```css
p{
	line-height: 1.5;
}
```
![alt text](https://9tvycq.ch.files.1drv.com/y4mbEoq9t4OKhy6RFy8VsEvpkeoDzdi7fAw8I06b3W2uCYfoY0XurcnejVHn89SMczPTpnKb9edr22EaFwvzdR3vlH3g02SnO9pFI9Xl341GnA5P11dp9pb0r4WrlX-CH-1LoPIQxFA2RJdsjJvcvqG5KQGzN4YCDHMEOk5BbRF4Neisyolu8wgjr-HGx-nfjYvIKdMXOjVoJnBXiJh42BfcQ/Web06.png?psid=1)