type tlettersOrNumbers = string | number;


let sChain: tlettersOrNumbers = "victorrobles.es";
sChain=12;

//number
let nNumber: number = 12;

//Boolean
let bTrueFalse: boolean = true;

//Any
let oAny: any = "hello";
oAny = 77;

//Arrays
var aLanguage: Array<string> = ["PHP","JS","CSS"];


let aYears: number[] = [12, 13, 15];

//Let vs var
var nNumber1 = 10;
var nNumber2 = 12;

if (nNumber1 == 10){
	let nNumber1 = 44;
	var nNumber2 = 55;

	console.log(nNumber1,nNumber2);
}

console.log(nNumber1,nNumber2);


console.log(sChain,nNumber,bTrueFalse,oAny,aLanguage,aYears);