'use strict'

/*
Text templates
*/

var sName= prompt('Enter your name');
var sSurname= prompt('Enter your surname');

var sText = `
	<h1> Hello, how are you</h1>
	<h3>My name is: ${sName}</h3>
	<h3>My surnames are: ${sSurname}</h3>
`; 


document.write(sText);