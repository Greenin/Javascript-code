'use strict'

//DOM - Document Object Model

function ChangeColor(sColor){
	oBox.style.background = sColor;
}

//Get elements with concret id


//var oBox = document.getElementById("mybox");
var oBox = document.querySelector("#mybox");

oBox.innerHTML = "TEXT IN THE BOX FROM JS!";
oBox.style.background = "red";
oBox.style.padding = "20px";
oBox.style.color = "white";
oBox.className = "Hello";



//Get elements with its tag
var arrayAllDivs = document.getElementsByTagName('div');

console.log(arrayAllDivs);

//arrayAllDivs.forEach((oValue,iIndex) = > {
var oSection = document.querySelector("#mysection");

var iIndex;
for (iIndex in arrayAllDivs){
	if (typeof arrayAllDivs[iIndex].textContent =='string'){
		console.log(arrayAllDivs[iIndex]);
		var oParagraph = document.createElement("p");
		var oText = document.createTextNode(arrayAllDivs[iIndex].textContent);
		oParagraph.append(oText);
		oSection.prepend(oParagraph);
	}
}
//});

//var oHr = document.createElement("hr");
//oSection.append(oHr);


var oDiv = arrayAllDivs[2];

oDiv.innerHTML = "Another text for the second element";
oDiv.style.background = "red";

console.log(oDiv);

console.log(oBox);

//Get elements with its css
var oRedDivs = document.getElementsByClassName("red");
var oYellowDivs = document.getElementsByClassName("yellow");
oYellowDivs[0].style.background = "yellow";

for (iIndex in oRedDivs){
	if (oRedDivs[iIndex].className == "red"){
		oRedDivs[iIndex].style.background = "red";
	}
}

//console.log(oRedDivs);

