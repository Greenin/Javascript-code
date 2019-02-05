'use strict'

//JSON - JavaScript Object Notation

var jsonMovie = {
	title: 'Batman vs Superman',
	year: 2017,
	country: "United States"
};


var arrayMovies = [
	{title: "Truth hurts", year: 2016, country: 'France'}, jsonMovie
];


var oMovieBox = document.querySelector("#Movies");
var iIndex;
for (iIndex in arrayMovies){
	var p = document.createElement("p");
	p.append(arrayMovies[iIndex].title + " - " + arrayMovies[iIndex].year);
	oMovieBox.append(p);
}



