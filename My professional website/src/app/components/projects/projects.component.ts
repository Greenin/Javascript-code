
import { Component, OnInit } from '@angular/core';
import { Project } from '../../models/project';
import { ProjectService } from '../../services/project.service';
import { oJsonGlobal } from '../../services/global';

@Component({
  selector: 'app-projects',
  templateUrl: './projects.component.html',
  styleUrls: ['./projects.component.css'],
  providers: [ProjectService]
})
export class ProjectsComponent implements OnInit {
  public aProjects: Project[];
  public sUrl: string;

  constructor(
  	private _projectService: ProjectService
  ) { 
  	this.sUrl = oJsonGlobal.url;
  }

  ngOnInit() {
  	this.getProjects();
  }

  getProjects(){
  	this._projectService.getProjects().subscribe(
  		response => {
  			//console.log(response);
  			if (response.aProjects){
  				this.aProjects = response.aProjects;
  				//console.log(this.aProjects);
  			}
  		},
  		error => {
  			console.log(<any>error);
  		}
  	);
  }

}
