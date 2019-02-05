'use strict'

/*
Make a program that shows all the odd numbers between two numbers entered by the user
*/

//var number1= parseInt(prompt('Enter the first number',0));
//var number2= parseInt(prompt('Enter the second number',0));

var nNumber1 = parseInt(prompt('Enter the first number: ',0));
var nNumber2 = parseInt(prompt('Enter the second number: ',0));

while(nNumber1<nNumber2) {
	nNumber1++;
	
	if (nNumber1%2 != 0) {
		console.log("The "+nNumber1+" is odd");
	}
	
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
