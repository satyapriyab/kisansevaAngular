import { Component, OnInit } from '@angular/core';
import {  Params, Router, ActivatedRoute } from '@angular/router';
import { userServices } from '../../services/userServices';

@Component({
    moduleId: module.id,
    templateUrl: 'resetPassword.component.html',
      styleUrls: [
        	  '../../../assets/template/bootstrap/css/bootstrap.min.css',
		        '../../../assets/template/dist/css/AdminLTE.min.css',
            '../../../assets/template/dist/css/font/css/font-awesome.min.css',
            '../../../assets/template/dist/css/ionicons-2.0.1/css/ionicons.min.css',
		        '../../../assets/custom/css/main.css?v=edda'
          ]
})

export class ResetPasswordComponent implements OnInit{

  pageTitle: string = 'Reset Password';
  data: any;

  constructor(private userService: userServices,
              private activatedRoute: ActivatedRoute,
              private router: Router ) { }

  passwordErrorMessage = '';

  ngOnInit() {
    if (localStorage.getItem('currentUser')) {
      if (localStorage.getItem('userType') === "1") {
        this.router.navigate(['/home/adminNavbar/adminHome']);
      } else if (localStorage.getItem('userType') === "2") {
        this.router.navigate(['/home/farmerNavbar/farmerHome']);
      } else {
        this.router.navigate(['/home/dealerNavbar/dealerHome']);
      }
    }
    let email = this.activatedRoute.snapshot.queryParams['email'];
    let token = this.activatedRoute.snapshot.queryParams['token'];
    this.userService.checkEmail(email).subscribe(
	    val => {this.data=val;
        if(val !== undefined) {
          if(val[0].NOTPRESENT !== undefined || val[0].TOKEN !== token) {
            this.router.navigate(['/login']);
          }
        }
    });
  }

  checkPassword(password) {
    password = password.trim();
    var passwordRegexp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}/;
    if (password === '' || !passwordRegexp.test(password)) {
      this.passwordErrorMessage = 'Password Should Contain Minimum 8 characters, at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character';
      return false;
    }
    this.passwordErrorMessage = '';
    return true;
  }

  resetPassword(event, password) {
    event.preventDefault();
    const body = JSON.stringify({ password });
    let email = this.activatedRoute.snapshot.queryParams['email'];

    this.checkPassword(password);
    
    if (this.checkPassword(password)) {
      this.userService.updatePassword(email, password).subscribe(
	      val => {this.data=val;
        if(val!==undefined) {
          if(val===true) {
            this.router.navigate(['/login']);
          }
        }
      });
    }
  }
}