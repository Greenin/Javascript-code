
import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs/Observable';
//import { Observable } from 'rxjs';
import { Project } from '../models/project';
import { oJsonGlobal } from './global';

@Injectable()
export class ProjectService{
	public sUrl: string;

	constructor(
		private _http: HttpClient
	){
		this.sUrl = oJsonGlobal.url;
	}

	testService(){
		return 'Testing the Angular service';
	}

	saveProject(oProject: Project): Observable<any>{
		let sParams = JSON.stringify(oProject);
		let oHeaders = new HttpHeaders().set('Content-Type','application/json');

		return this._http.post(this.sUrl+'save-project',sParams, {headers: oHeaders});
	}

	getProjects(): Observable<any>{
		let oHeaders = new HttpHeaders().set('Content-Type','application/json');

		return this._http.get(this.sUrl+'projects',{headers: oHeaders});
	}

	getProject(id): Observable<any>{
		let oHeaders = new HttpHeaders().set('Content-Type','application/json');
console.log("id: ",id);
console.log("this.sUrl: ",this.sUrl);
console.log("this.sUrl+project/+id ",this.sUrl+'project/'+id);
		let sAuxUrl=this.sUrl+'project/'+id;
console.log("sAuxUrl: ",sAuxUrl);
		//let oAux = this._http.get(sAuxUrl,{headers: oHeaders});
//console.log("oAux: ",oAux);
		//return oAux;
		return this._http.get(this.sUrl+'project/'+id,{headers: oHeaders});
	}

	deleteProject(id): Observable<any>{
		let oHeaders = new HttpHeaders().set('Content-Type','application/json');

		return this._http.delete(this.sUrl+'project/'+id, {headers: oHeaders});
	}

	updateProject(oProject): Observable<any>{
		let params = JSON.stringify(oProject);
		let oHeaders = new HttpHeaders().set('Content-Type','application/json');

		return this._http.put(this.sUrl+'project/'+oProject._id, params, {headers: oHeaders});
	}


}