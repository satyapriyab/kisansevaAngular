import { Injectable }    from '@angular/core';
import { Component}  from '@angular/core';
import { Headers, Http } from '@angular/http';
import 'rxjs/add/operator/toPromise';
import 'rxjs/add/operator/map';

@Injectable()
export class userServices {
  constructor(private http: Http) { }
    login(email: string, password: string) {
      var body = 'email=' +email + '&password=' +password;
      var headers = new Headers();
      headers.append('Content-Type', 'application/x-www-form-urlencoded');
      return this.http.post('http://www.kisansevaangular.com/controller/userController.cfc?method=loginUser', body, {
      headers: headers })
        .map((response) => response.json()
        );
    }
    register(userType: number, name:string, email: string, password: string, cpassword: string, address:string, number: number) {
      var body = 'type='+userType+'&username='+name+'&email='+email+'&password='+password+'&retypePassword='+cpassword+'&address='+address+'&number='+number;
      var headers = new Headers();
      headers.append('Content-Type', 'application/x-www-form-urlencoded');
      return this.http.post('http://www.kisansevaangular.com/controller/userController.cfc?method=registerUser', body, {
      headers: headers })
        .map((response) => response.json());
    }
    forgotPassword(email: string) {
      var body = 'email='+email;
      var headers = new Headers();
      headers.append('Content-Type', 'application/x-www-form-urlencoded');
      return this.http.post('http://www.kisansevaangular.com/controller/userController.cfc?method=createToken', body, {
      headers: headers })
        .map((response) => response.json());
    }
    checkEmail(email: string) {
      var body = 'email='+email;
      var headers = new Headers();
      headers.append('Content-Type', 'application/x-www-form-urlencoded');
      return this.http.post('http://www.kisansevaangular.com/controller/userController.cfc?method=userDetails', body, {
      headers: headers })
        .map((response) => response.json());
    }
    updatePassword(email: string, password: string) {
      var body = 'email='+email+'&password='+password;
      var headers = new Headers();
      headers.append('Content-Type', 'application/x-www-form-urlencoded');
      return this.http.post('http://www.kisansevaangular.com/controller/userController.cfc?method=updatePassword', body, {
      headers: headers })
        .map((response) => response.json());
    }

  private handleError(error: any): Promise<any> {
    console.error('An error occurred', error); // for demo purposes only
    return Promise.reject(error.message || error);
  }
}