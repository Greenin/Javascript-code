'use strict'

/*
1. Ask 6 numbers with prompt and insert them into an array
2. Show the entire array (all its elements) in the body of the page and in the console
3. Sort and show it
4. Reverse its order and show it
5. Show how many elements the array has
6. Search for a element entered by the user and to inform us if it finds it and its index
(the use of the functions will be appreciated)
*/





function ShowArray(arrayElements, sCustomText = ""){
	document.write("<h1>Content of the "+sCustomText+" array</h1>");
	document.write("<ul>");
	arrayElements.forEach(nNum => {
		document.write("<li>"+nNum+"</li>");		
		console.log(nNum);
	});
	document.write("</ul>");
}



var arrayNum = [];

for (var i=0; i<6; i++)
{
	arrayNum[i]= parseInt(prompt('Enter a number: '));
}

/*
arrayNum.forEach(nNum => {
	document.write("<li>"+nNum+"</li>");
	console.log(nNum);
});
*/

ShowArray(arrayNum);

document.write("<br/>");

arrayNum.sort(function(a,b){return a-b});


ShowArray(arrayNum, 'ordered');

document.write("<br/>");

arrayNum.reverse();

ShowArray(arrayNum, 'reverse');


document.write("<br/>");
document.write("The array has "+arrayNum.length+" elements");

/*
for (let i in arrayNum){
	document.write("<li>"+arrayNum[i]+"</li>");
	console.log(arrayNum[i]);
}
*/

var nNumToSearch= parseInt(prompt('Enter a number to search: '));
document.write("<br/>");
document.write("Number to search: "+nNumToSearch);
document.write("<br/>");

if (arrayNum.find(nArrayNum => nArrayNum==nNumToSearch))
{
	document.write("Number found in position "+arrayNum.indexOf(nNumToSearch));
}
