'use strict'

/*
Make a program that shows all the numbers between two numbers entered by the user
*/

//var number1= parseInt(prompt('Enter the first number',0));
//var number2= parseInt(prompt('Enter the second number',0));

var nNumber1 = parseInt(prompt('Enter the first number: ',0));
var nNumber2 = parseInt(prompt('Enter the second number: ',0));

document.write("<h1>From "+nNumber1+" to "+nNumber2+ " are these numbers:</h1>");
for (var i = nNumber1; i <= nNumber2; i++){
	document.write(i+"<br/>");
}


/*
console.log(nNumber1);
console.log(nNumber2);

if (!isNaN(nNumber1) && !isNaN(nNumber2))
{

	while(nNumber1<nNumber2-1) {
		nNumber1++;	
		console.log(nNumber1);
	}


	while(nNumber1>nNumber2+1) {
		nNumber1--;	
		console.log(nNumber1);
	}	


}
*/
