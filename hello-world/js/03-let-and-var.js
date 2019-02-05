'use strict'

//Test with var
var numero = 40;
console.log(numero); //value 40

if (true){
	var numero = 50;
	console.log(numero); //value 50
}

console.log(numero); //value 50

//Test with var
var texto = "Curso JS oscarparrilla.es";
console.log(texto); //value


if (true){
	let texto = "Curso Laravel 5 oscarparrilla.es";
	console.log(texto); //value laravel 5
}


console.log(texto); //value js