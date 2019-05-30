
import { Component, OnInit } from '@angular/core';
import { Project } from '../../models/project';
import { ProjectService } from '../../services/project.service';
import { UploadService } from '../../services/upload.service';
import { oJsonGlobal } from '../../services/global';

@Component({
  selector: 'app-create',
  templateUrl: './create.component.html',
  styleUrls: ['./create.component.css'],
  providers: [ProjectService, UploadService]
})
export class CreateComponent implements OnInit {

  public sTitle: string;
  public oProject: Project;
  public oSaveProject;
  public sStatus: string;
  public aFilesToUpload: Array<File>;

  constructor(
     private _projectService: ProjectService,
     private _uploadService: UploadService
  ) { 
  		this.sTitle = "Create project";
  		this.oProject = new Project('','','','',2019,'','');
  }

  ngOnInit() {
  }

  onSubmit(oForm){
  	//console.log(this.oProject);

  	//To save basic data
  	this._projectService.saveProject(this.oProject).subscribe(
  		response => {
  			//console.log(response);
  			if (response.project){
  				
  				//To upload the image
  				this._uploadService.makeFileRequest(oJsonGlobal.url+"upload-image/"+response.project._id,[],this.aFilesToUpload,'Image')
  				.then((oResult:any) => {
  					
            this.oSaveProject = oResult.project;

            this.sStatus = 'success';
  					//console.log(oResult);
  					oForm.reset();
  				});
  				
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
