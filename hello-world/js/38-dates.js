

var oDate = new Date();

var iYear = oDate.getFullYear();
var iMonth = oDate.getMonth();
var iDay = oDate.getDate();
var iHour = oDate.getHours();


var sTimeText = `
	Year is: ${iYear}
	Month is: ${iMonth}
	Day is: ${iDay}
	Hour is: ${iHour}
`;


console.log(sTimeText);
console.log(Math.ceil(Math.random()*10));
