'use strict'

window.addEventListener('load', function(){
	console.log("DOM loaded!!");
	
	var oForm = document.querySelector("#form");
	var oBox_dashed = document.querySelector(".dashed");
	oBox_dashed.style.display = "none";
	
	oForm.addEventListener('submit', function(){
		console.log("Submit event captured");
		
		var oName = document.querySelector("#name").value;
		var oSurname = document.querySelector("#surname").value;
		var oAge = document.querySelector("#age").value;
		
		if (oName.trim() == null || oName.trim().length == 0){
			alert("Name is not valid");
			document.querySelector("#name_error").innerHTML = "Name is not valid<br/>";
			return false;
		} else {
			document.querySelector("#name_error").style.display = "None";
		}
		
		if (oSurname.trim() == null || oSurname.trim().length == 0){
			alert("Surname is not valid");
			return false;
		}
		
		if (oAge.trim() == null || oAge<= 0 || isNaN(oAge)){
			alert("Age is not valid");
			return false;
		}
		
		oBox_dashed.style.display = "block";
		
		var oPName = document.querySelector("#p_name span");
		var oPSurname = document.querySelector("#p_surname span");
		var oPAge = document.querySelector("#p_age span");
		
		oPName.innerHTML = oName;
		oPSurname.innerHTML = oSurname;
		oPAge.innerHTML = oAge;
		
		/*
		var arrayUserData = [oName,oSurname,oAge];
		
		var iIndex;
		
		for (iIndex in arrayUserData){
			var oParagraph = document.createElement("p");
			oParagraph.append(arrayUserData[iIndex]);
			oBox_dashed.append(oParagraph);
		}

		console.log(oName,oSurname,oAge);
		*/

	});
});

