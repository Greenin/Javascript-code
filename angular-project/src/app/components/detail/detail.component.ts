
import { Component, OnInit } from '@angular/core';
import { Project } from '../../models/project';
import { ProjectService } from '../../services/project.service';
import { oJsonGlobal } from '../../services/global';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-detail',
  templateUrl: './detail.component.html',
  styleUrls: ['./detail.component.css'],
  providers: [ProjectService]
})
export class DetailComponent implements OnInit {
  public sUrl: string;
  public oProject: Project;
  public bConfirm: boolean; 

  constructor(
  	private _projectService: ProjectService,
  	private _router: Router,
  	private _route: ActivatedRoute
  ) {
  		this.sUrl = oJsonGlobal.url;
      this.bConfirm = false;
  }

  ngOnInit() {
  		this._route.params.subscribe(params=> {
  			let id = params.id;

  			this.getProject(id);
  		});
  }

  getProject(id){
  	this._projectService.getProject(id).subscribe(
  		response => {
        //console.log(response);
  			this.oProject = response.oProjectFound;
			  console.log(this.oProject);
  		},
  		error => {
  			console.log(<any>error);
  		}
  	)
  }


  setConfirm(bConfirmParam){
    this.bConfirm = bConfirmParam;
  }


  deleteProject(id){
    this._projectService.deleteProject(id).subscribe(
      response => {
          if(response.project){
              this._router.navigate(['/projects']);
          }
      },

      error => {
          console.log(<any>error);
      }
    );
  }



}
