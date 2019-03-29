
var oBike = {
	aColor: 'Red',
	aModel: 'BMX',
	aTypeOfBrakes: 'Disc brake',
	aMaxSpeed: '60km',
	mChangeColor: function(sNewColor){
		//oBike.aColor = sNewColor
		this.aColor = sNewColor;
		console.log(this);
	}
};


oBike.mChangeColor("Blue");