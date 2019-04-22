import { Injectable } from '@angular/core';
import { oJsonGlobal } from './global';

@Injectable()
export class UploadService{
	public sUrl: string;

	constructor(){
		this.sUrl = oJsonGlobal.url;
	}

	makeFileRequest(sUrl: string, aParams: Array<string>, aFiles: Array<File>, sName: string ){
		return new Promise(function(resolve, reject){
			var oFormData:any = new FormData;
			var oXhr = new XMLHttpRequest();

			for (var i=0; i<aFiles.length; i++){
				oFormData.append(sName,aFiles[i],aFiles[i].name);
			}

			oXhr.onreadystatechange = function(){
				if (oXhr.readyState == 4){
					if(oXhr.status == 200){
						resolve(JSON.parse(oXhr.response));
					}else{
						reject(oXhr.response);
					}
				}
			}


			oXhr.open('POST',sUrl,true);
			oXhr.send(oFormData);

		});
	}

}