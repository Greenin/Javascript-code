'use strict'

/*
Using a loop, show the sum and average of the entered numbers until you enter a negative number and there show the result
*/

//var number1= parseInt(prompt('Enter the first number',0));
//var number2= parseInt(prompt('Enter the second number',0));

var nNumber;

var nSum = 0;
var nNumOfNum = 0;
var nAverage = 0;


do{
	nNumber= parseInt(prompt('Enter numbers until you enter a negative number: ',0));
	//number2= parseInt(prompt('Enter the second number',0));
	
	if (isNaN(nNumber)){
		nNumber = 0;
	}
	else if (nNumber>=0)
	{
		nSum += nNumber;
		nNumOfNum++;
		nAverage = nSum/nNumOfNum;
		
		//alert("Sum: " + nSum);
		//alert("Average: " + nAverage);
	}
	
	console.log("Sum: " + nSum);
	console.log("Counter: " + nNumOfNum);
	console.log("Average: " + nAverage);
	
}while  (nNumber>=0)


alert("The sum of all the numbers is: " + nSum);
//alert("Counter: " + nNumOfNum);
alert("The average of all the numbers is: " + nAverage);

