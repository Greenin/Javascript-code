'use strict';

//Fetch (Ajax) and request for services /api rest

var oUsers_div = document.querySelector("#users");
var oTeacher_div = document.querySelector("#teacher");
var oJanet_div = document.querySelector("#janet");


GetUsers()
	.then(sData => sData.json())
	.then(oUsers => {
		UserList(oUsers.data);
		
		return GetInfo();
	})
	.then(oData => {
		oTeacher_div.innerHTML = oData;
		
		return GetJanet();
	})
	.then(sData => sData.json())
	.then(oUser => {
		ShowJanet(oUser.data);
	})
	.catch(sError => {
		alert("Error in requests")
	});



	
function GetUsers(){
	return fetch('https://reqres.in/api/users?page=2');
	
}



function GetJanet(){
	return fetch('https://reqres.in/api/users/2');
	
}
	
	
function GetInfo(){
	
	var oTeacher = {
		name: 'Victor',
		surname: 'Robles',
		url: 'http://victorroblesweb.es'
	};
	
	return new Promise((resolve, reject) => {
		
		var sTeacherString = "";
		
		setTimeout(function(){
			sTeacherString = JSON.stringify(oTeacher);
			
			if (typeof sTeacherString != 'string' || sTeacherString == '') return reject('error');
			
			return resolve(sTeacherString);
			
		},3000);

	});	
}


function UserList(arrayUsers){
	
	arrayUsers.map((oUser,iIndex) =>{
		let oName = document.createElement('h3');
		
		oName.innerHTML = iIndex + '. ' + oUser.first_name + " " + oUser.last_name;
		
		oUsers_div.appendChild(oName);
		
		document.querySelector(".loading").style.display = 'none';
	});
}


function ShowJanet(oUser){	
	
	let oName = document.createElement('h4');
	let oAvatar = document.createElement('img');
	
	oName.innerHTML = oUser.first_name + " " + oUser.last_name;
	oAvatar.src = oUser.avatar;
	oAvatar.width = '100';
	
	oJanet_div.appendChild(oName);
	oJanet_div.appendChild(oAvatar);
	
	document.querySelector("#janet .loading").style.display = 'none';
	
}