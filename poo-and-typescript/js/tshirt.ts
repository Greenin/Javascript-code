//Interface
interface BaseTShirt{
	mSetColor(sColor);
	mGetColor();
}



//Decorator
function mStamp(sLogo: string){
	return function(target: Function){
		target.prototype.stamping = function():void{
			console.log("T-shirt printed with the logo "+sLogo);
		}
	}
}



//Class (object shape or object mold)
@mStamp('Gucci Gang')
class Tshirt implements BaseTShirt{
	
	//Attributes (Object properties/members/fields/variables)
	private sColor: string;
	private sModel: string;
	private sBrand: string; //Trademark
	private sSize: string;
	private nPrice: number;


	//Methods (Object functions/actions)
	constructor(sColor, sModel, sBrand, sSize, nPrice){
		this.sColor = sColor;
		this.sModel = sModel;
		this.sBrand = sBrand;
		this.sSize = sSize;
		this.nPrice = nPrice;
	}



	public mSetColor(sColor){
		this.sColor = sColor;
	}

	public mGetColor(){
		return this.sColor;
	}
}



//Daughter class
class Sweatshirt extends Tshirt{
	public bHasHood: boolean;

	setHood(bHasHood: boolean){
			this.bHasHood = bHasHood;
	}

	mGetHood():boolean{
		return this.bHasHood;
	}
}


var oTshirt = new Tshirt("Red", "fas","fas", "fasf",12);
console.log(oTshirt);
oTshirt.stamping();


var oNikeSweatshirt = new Sweatshirt("Red","Long Sleeve","Nike","L",30);
oNikeSweatshirt.setHood(true);
oNikeSweatshirt.mSetColor("Gray");
console.log(oNikeSweatshirt);


//var oTshirt = new Tshirt("Red","Long Sleeve","Nike","L",10);
//oTshirt.mSetColor("Red");
//oTshirt.mGetColor();

/*
oTshirt.sColor = "Red";
oTshirt.sModel = "Long Sleeve";
oTshirt.sBrand = "Nike";
oTshirt.sSize = "L";
oTshirt.nPrice = 10;
*/



//var oBeachShirt = new Tshirt();
//oBeachShirt.mSetColor("Blue");

/*
oBeachShirt.sColor = "Blue";
oBeachShirt.sModel = "t-shirt";
oBeachShirt.sBrand = "Adidas";
oBeachShirt.sSize = "L";
oBeachShirt.nPrice = 15;
*/

//console.log(oTshirt);

