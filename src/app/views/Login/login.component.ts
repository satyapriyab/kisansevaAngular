import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute} from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { userServices } from '../../services/userServices';

@Component({
    moduleId: module.id,
    templateUrl: 'login.component.html',
      styleUrls: [
        	  '../../../assets/template/bootstrap/css/bootstrap.min.css',
		        '../../../assets/template/dist/css/AdminLTE.min.css',
            '../../../assets/template/dist/css/font/css/font-awesome.min.css',
            '../../../assets/template/dist/css/ionicons-2.0.1/css/ionicons.min.css',
		        '../../../assets/custom/css/main.css?v=edda'
          ]
})

export class LoginComponent implements OnInit{

pageTitle: string = 'Login';
data: any;
constructor(private userService: userServices,
            private router: Router) { }

emailErrorMessage = '';
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
  }
checkEmail(email) {
    email = email.trim();
    var EMAIL_REGEXP = /^[a-z0-9!#$%&'*+\/=?^_`{|}~.-]+@[a-z0-9]([a-z0-9-]*[a-z0-9])?(\.[a-z0-9]([a-z0-9-]*[a-z0-9])?)*$/i;
    if (email === '' || !EMAIL_REGEXP.test(email)) {
      this.emailErrorMessage = 'Please Enter A Valid Email';
      return false;
    }
    this.emailErrorMessage = '';
    return true;
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

  login(event, email, password) {
    event.preventDefault();
    const body = JSON.stringify({ email, password });
    this.checkEmail(email);
    this.checkPassword(password);
    
    if (this.checkEmail(email) && this.checkPassword(password)) {
       this.userService.login(email, password).subscribe(
	      val => {this.data=val;
          if(val!==undefined) {
            if(val[0].USEREMAIL!==undefined) {
              localStorage.setItem('currentUser', val[0].USEREMAIL);
              localStorage.setItem('userName', val[0].USER);
              localStorage.setItem('userType', val[0].TYPE);
              localStorage.setItem('userImage', val[0].IMAGE);
              if (val[0].TYPE === 1) {
                this.router.navigate(['/home/adminNavbar/adminHome']);
              } else if (val[0].TYPE === 2) {
                this.router.navigate(['/home/farmerNavbar/farmerHome']);
              } else {
                this.router.navigate(['/home/dealerNavbar/dealerHome']);
              }
            }
          }
        }
      );
    }
  }
}