var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
//Decorator
function mStamp(sLogo) {
    return function (target) {
        target.prototype.stamping = function () {
            console.log("T-shirt printed with the logo " + sLogo);
        };
    };
}
//Class (object shape or object mold)
var Tshirt = /** @class */ (function () {
    //Methods (Object functions/actions)
    function Tshirt(sColor, sModel, sBrand, sSize, nPrice) {
        this.sColor = sColor;
        this.sModel = sModel;
        this.sBrand = sBrand;
        this.sSize = sSize;
        this.nPrice = nPrice;
    }
    Tshirt.prototype.mSetColor = function (sColor) {
        this.sColor = sColor;
    };
    Tshirt.prototype.mGetColor = function () {
        return this.sColor;
    };
    Tshirt = __decorate([
        mStamp('Gucci Gang')
    ], Tshirt);
    return Tshirt;
}());
//Daughter class
var Sweatshirt = /** @class */ (function (_super) {
    __extends(Sweatshirt, _super);
    function Sweatshirt() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    Sweatshirt.prototype.setHood = function (bHasHood) {
        this.bHasHood = bHasHood;
    };
    Sweatshirt.prototype.mGetHood = function () {
        return this.bHasHood;
    };
    return Sweatshirt;
}(Tshirt));
var oTshirt = new Tshirt("Red", "fas", "fas", "fasf", 12);
console.log(oTshirt);
oTshirt.stamping();
var oNikeSweatshirt = new Sweatshirt("Red", "Long Sleeve", "Nike", "L", 30);
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
