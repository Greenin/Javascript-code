
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-aboutme',
  templateUrl: './aboutme.component.html',
  styleUrls: ['./aboutme.component.css']
})
export class AboutmeComponent implements OnInit {
  public sTitle: string;
  public sSubtitle: string;
  public sEmail: string;
  //public sGithub: string;

  constructor() {
  	
  	this.sTitle = "Oscar Parrilla";
  	this.sSubtitle = "Web developer";
  	this.sEmail = "oparrilla@gmail.com";
    //this.sGithub = "GitHub";
  }

  ngOnInit() {
  }

}
