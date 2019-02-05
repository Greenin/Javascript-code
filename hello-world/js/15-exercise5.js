'use strict'

/*
Show all the divisor numbers entered at the prompt
*/

//var number1= parseInt(prompt('Enter the first number',0));
//var number2= parseInt(prompt('Enter the second number',0));

var nNumber = parseInt(prompt('Enter a number: ',1));
//var nNumber2 = parseInt(prompt('Enter the second number: ',0));

for (var i=1; i <= nNumber; i++) {
	
	if (nNumber%i == 0) {
		console.log("Divisor: "+ i);
	}	
}

