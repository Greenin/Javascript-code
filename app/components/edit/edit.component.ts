
import { Component, OnInit } from '@angular/core';
import { Project } from '../../models/project';
import { ProjectService } from '../../services/project.service';
import { UploadService } from '../../services/upload.service';
import { oJsonGlobal } from '../../services/global';
import { Router, ActivatedRoute, Params } from '@angular/router';

@Component({
  selector: 'app-edit',
  templateUrl: '../create/create.component.html',
  styleUrls: ['./edit.component.css'],
  providers: [ProjectService, UploadService]
})
export class EditComponent implements OnInit {

  public sTitle: string;
  public oProject: Project;
  public oSaveProject;
  public sStatus: string;
  public aFilesToUpload: Array<File>;
  public sUrl: string;

  constructor(
     private _projectService: ProjectService,
     private _uploadService: UploadService,
     private _route: ActivatedRoute,
     private _router: Router
  ) { 
  		this.sTitle = "Edit project";
      this.sUrl = oJsonGlobal.url;
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
  			this.oProject = response.project;
			//console.log(this.oProject);
  		},
  		error => {
  			console.log(<any>error);
  		}
  	)
  }


  onSubmit(){
      this._projectService.updateProject(this.oProject).subscribe(
        response => {
          if (response.project){
                  
            if (this.aFilesToUpload){

              //To upload the image
              this._uploadService.makeFileRequest(oJsonGlobal.url+"upload-image/"+response.project._id,[],this.aFilesToUpload,'Image')
              .then((oResult:any) => {
                
                this.oSaveProject = oResult.project;

                this.sStatus = 'success';
                //console.log(oResult);
              });

            } else
            {
              this.oSaveProject = response.project;
              this.sStatus = 'success';
            }
                  
          } else {
            this.sStatus = 'failed';
          }
        },
        error => {
          console.log(<any>error);
        }
      );
  }


  fileChangeEvent(oFileInput: any){
    //console.log(oFileInput);
    this.aFilesToUpload = <Array<File>>oFileInput.target.files;
  }

}
