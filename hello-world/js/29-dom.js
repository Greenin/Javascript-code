'use strict'

//BOM - Browser Object Model


function GetBOM(){
	console.log(screen.width);
	console.log(screen.height);
	//console.log(window.innerWidth);
	//console.log(window.innerHeight);
	console.log(window.location);
	//console.log(window.location.href);
}


function Redirect(sUrl){
	window.location.href = sUrl;	
}


function OpenWindow(sUrl){
	window.open(sUrl);
}



GetBOM();


