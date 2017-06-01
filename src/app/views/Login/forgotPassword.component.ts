import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { userServices } from '../../services/userServices';

@Component({
  moduleId: module.id,
  templateUrl: 'forgotPassword.component.html',
  styleUrls: [
        	  '../../../assets/template/bootstrap/css/bootstrap.min.css',
		        '../../../assets/template/dist/css/AdminLTE.min.css',
            '../../../assets/template/dist/css/font/css/font-awesome.min.css',
            '../../../assets/template/dist/css/ionicons-2.0.1/css/ionicons.min.css',
		        '../../../assets/custom/css/main.css?v=edda'
  ]
})

export class ForgotPasswordComponent implements OnInit{

  pageTitle: string = 'Forgot Password';  
  data: any;
  constructor(private userService: userServices,
              private router: Router) { }

  emailErrorMessage = '';

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


  forgotPassword(event, email) {
    event.preventDefault();
    const body = JSON.stringify({ email });
    this.checkEmail(email);
    
    if (this.checkEmail(email)) {
      this.userService.forgotPassword(email).subscribe(
	      val => {this.data=val;}
      );
    }
  }
}