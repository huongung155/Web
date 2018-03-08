# Table
```html
<table border = "1">
	<thead>
		<tr>
			<th>Image</th>
			<th>Name</th>
			<th>Type</th>
			<th>Evolves Into</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><img width = "50" src="http://img4.wikia.nocookie.net/__cb20140328190757/pokemon/images/thumb/2/21/001Bulbasaur.png/200px-001Bulbasaur.png"></td>
			<td>Bulbasaur</td>
			<td>Grass/Poison</td>
			<td><a href="http://pokemon.wikia.com/wiki/Ivysaur">Ivysaur</a></td>
		</tr>
		<tr>
			<td><img width = "50" src="http://img4.wikia.nocookie.net/__cb20140724195345/pokemon/images/thumb/7/73/004Charmander.png/200px-004Charmander.png"></td>
			<td>Charmander</td>
			<td>Fire</td>
			<td><a href="http://pokemon.wikia.com/wiki/Charmeleon">Charmeleon</a></td>
		</tr>
		<tr>
			<td><img width = "50" src="http://img1.wikia.nocookie.net/__cb20140328191525/pokemon/images/thumb/3/39/007Squirtle.png/200px-007Squirtle.png"></td>
			<td>Squirtle</td>
			<td>Water</td>
			<td><a href="http://pokemon.wikia.com/wiki/Wartortle">Wartortle</a></td>
		</tr>	
	</tbody>
</table>
```
![alt text](https://9two8g.ch.files.1drv.com/y4m57KYM1ipaRLtGtHzQixqEOTLeaOaU9XB6kmaEHRfYTGA5AoFvou-egCLPVbHzfIconF95dTf_02KtT5jSNpqNDHiRQ1ySpyxWT5Z2Wv79mt8jQWHqtCnEBZhawdsxUsheGi1HcOo9Ef0YXsqu5w3FmP9jE2PobAg6F_EOCHzFBOt7J4HLt1zFdkaj9sQGS2eiIkslaE7weBc0BHtdchy5g/Web04.png?psid=1)

#Form
```html
<form action="" method="POST">
	<label for='username'>Email:</label>
	<input id='username' type='email' placeholder='Email' required>

	<label for='pass'>Password:</label>
	<input id='pass' type='password' placeholder='Password' required>	
</form>
```

## Radio, Dropdowns
### Radio
```html
<label for='dog'>Dogs:</label>
<input id='dog' type='radio' name='petCHoice' value='DOGS'>

<label for='cat'>Cats:</label>
<input id='cat' type='radio' name='petCHoice' value='CATS'>
```
### Dropdowns
```html
<select name='mood'>
	<option value='Happy'>:)</option>
	<option value='Neutral'>:|</option>
	<option value='Sad'>:(</option>
</select>
```
### Textarea
```html
<textarea name='paragraph' rows=10 cols=10></textarea>
```
## Exercise
```html
<form>
	<label for="firstName">First Name:</label>
	<input name="name" id="firstName" type="text" placeholder="John" required>

	<label for="lastName">Last Name:</label>
	<input name="name" id="lastName" type="text" placeholder="Smith" required>

	<div>
		<label for="male">Male:</label>
		<input name="gender" id="male" type="radio" value="MALE">

		<label for="female">Female</label>
		<input name="gender" id="female" type="radio" values="FEMALE">

		<label for="other">Other:</label>
		<input name="other" id="other" type="radio" value="OTHER">
	</div>

	<div>
		<label>Email:
			<input name="email" id="email" type="email" placeholder="Your Email" required>
		</label>
		<label>Password:
			<input name="password" id="password" type="password" pattern=".{10,}" required title="10 or more characters">
		</label>
	</div>

	<div>
		<label>
			Birthday:
			<select name="month">
				<option>Month</option>
				<option value="1">Jan</option>
				<option value="2">Feb</option>
				<option value="3">Mar</option>
			</select>
			<select name="day">
				<option>Day</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>
			<select name="year">
				<option>Year</option>
				<option value="2010">2010</option>
				<option value="2011">2011</option>
				<option value="2012">2012</option>
			</select>
		</label>
	</div>

	<div>
		<label for="agree">I agree to the terms and conditions</label>
		<input id="agree" type="checkbox">
	</div>

	<button>Submit</button>
</form>
```
![alt text](https://9tv5ua.ch.files.1drv.com/y4m2H_aRw-IB1voV-3xWOar3cjVuDvsoxAfOGFfVz02AI8rZlp-kwnUdNjojDm3hpLBDVLqd0RCcyoQWC-Ab6hLkL0rr3Z1GIP480eEniysEqYrvdG6mw1cpwCDbDXQubE_r_8-MwlWhh1qybwwWSFFVT4XhH4-E4uuC17o9czeYKgc9F2vb2xHO63aukCfjembtCJ9nmXcOKgIiXryvDJ3XA/Web05.png?psid=1)