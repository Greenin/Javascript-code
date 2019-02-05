'use strict'

/*
Program that ask us two numbers and tell us which is greater, smaller or if they are the same
PLUS: If the numbers are not numbers or they are less than or equal to zero, then it asks us again
*/

var number1= parseInt(prompt('Enter the first number',0));
var number2= parseInt(prompt('Enter the second number',0));


while (number1<=0 || number2<=0 || isNaN(number1) || isNaN(number2)){
	number1= parseInt(prompt('Enter the first number',0));
	number2= parseInt(prompt('Enter the second number',0));
}

if (number1 == number2){
	alert("The number are the same");
}
else if (number1>number2){
	alert("Number greater is:" + number1);
	alert("Number smaller is:" + number2);
}else if (number2>number1){
	alert("Number greater is:" + number2);
	alert("Number smaller is:" + number1);
}else{
	alert("Enter correct numbers");
}