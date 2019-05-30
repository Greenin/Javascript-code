
import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
declare var $:any; 

@Component({
  selector: 'slider',
  templateUrl: './slider.component.html',
  styleUrls: ['./slider.component.css']
})
export class SliderComponent implements OnInit {

  @Input() nWidth: number;
  @Input('bTags') bCaptions: boolean;
  @Output() oGetAuthor = new EventEmitter();

  public oAuthor: any;

  constructor() { 

  	this.oAuthor = {
  		name: "Oscar Parrilla",
  		website: "www.google.com",
  		youtube: "www.youtube.es"
  	};

  }

  ngOnInit() {

  	$("#logo").click(function(e){
  		e.preventDefault();
  		$("header").css("background","green")
  				   .css("height","50px");
  	});


  	$('.gallery').bxSlider({
	    mode: 'fade',
	    captions: this.bCaptions,
	    slideWidth: this.nWidth
  	});

  	//Launch event
  	this.oGetAuthor.emit(this.oAuthor);

  }

  launch(oEvent){
  	//console.log(oEvent);
  	this.oGetAuthor.emit(this.oAuthor);
  }

}
