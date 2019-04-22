
import { Directive, ElementRef } from '@angular/core';

@Directive({
  selector: '[appHighlighted]'
})
export class HighlightedDirective {

  constructor(public oEl: ElementRef) { 

  }

  ngOnInit(){
  	var oElement = this.oEl.nativeElement;
  	oElement.style.background =  "blue";
  	oElement.style.padding = "20px";
  	oElement.style.marginTop = "15px";
  	oElement.style.color = "white";

  	//console.log(oElement.innerText);
  	oElement.innerText = oElement.innerText.toUpperCase().replace("CONTACT","****");
  }

}
