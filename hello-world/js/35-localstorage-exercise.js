'use strict'

var oForm = document.querySelector("#movieform");

oForm.addEventListener('submit',function(){	
	var sTitle = document.querySelector('#addmovie').value;
	if (sTitle.length >= 1){
		localStorage.setItem(sTitle,sTitle)
	}
});


var oUl = document.querySelector('#movie-list');
for (var i in localStorage){
	console.log(localStorage[i]);
	if (typeof localStorage[i] == 'string'){
		var oLi = document.createElement("li");
		oLi.append(localStorage[i]);
		oUl.append(oLi);
	}
}

var oDelForm = document.querySelector("#deleteMovieForm");

oDelForm.addEventListener('submit',function(){	
	var sTitle = document.querySelector('#deletemovie').value;
	if (sTitle.length >= 1){
		localStorage.removeItem(sTitle,sTitle)
	}
});