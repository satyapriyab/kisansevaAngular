import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { userServices } from '../../services/userServices';

@Component({
    moduleId: module.id,
    templateUrl: 'register.component.html',
      styleUrls: [
        	  '../../../assets/template/bootstrap/css/bootstrap.min.css',
		        '../../../assets/template/dist/css/AdminLTE.min.css',
            '../../../assets/template/dist/css/font/css/font-awesome.min.css',
            '../../../assets/template/dist/css/ionicons-2.0.1/css/ionicons.min.css',
		        '../../../assets/custom/css/main.css?v=edda'
          ]
})

export class RegisterComponent implements OnInit{

  pageTitle: string = 'Register';
  data: any;
  user: any;
  constructor(private userService: userServices,
              private router: Router ) { }

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
    this.user=localStorage.getItem("currentUser");
  }
  
  userTypeErrorMessage = '';
  nameErrorMessage = '';  
  emailErrorMessage = '';
  passwordErrorMessage = '';
  cpasswordErrorMessage = '';
  numberErrorMessage = '';

  checkUserType(userType) {
    if (userType === '') {
      this.userTypeErrorMessage = 'Please Select A User';
      return false;
    }
    this.userTypeErrorMessage = '';
    return true;
  }

  checkName(name) {
    name = name.trim();
    if (name.length < 5) {
      this.nameErrorMessage = 'Name should be of atleast 5 charecters';
      return false;
    }
    this.nameErrorMessage = '';
    return true;
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

  checkCPassword(password, cpassword) {
    password = password.trim();
    cpassword = cpassword.trim();
    if (password !== cpassword) {
      this.cpasswordErrorMessage = 'Password Mismatch';
      return false;
    }
    this.cpasswordErrorMessage = '';
    return true;
  }

  checkNumber(number) {
    if (number.length < 10 || number.length > 10) {
      this.numberErrorMessage = 'Number should be of 10 digits';
      return false;
    }
    this.numberErrorMessage = '';
    return true;
  }

  register(event, userType, name, email, password, cpassword, address, number) {
    event.preventDefault();
    const body = JSON.stringify({ userType, name, email, password, cpassword, address, number });

    this.checkUserType(userType);
    this.checkName(name);
    this.checkEmail(email);
    this.checkPassword(password);
    this.checkCPassword(password, cpassword);
    this.checkNumber(number);
    
    if (this.checkUserType(userType) && this.checkName(name) && this.checkEmail(email) && this.checkPassword(password) && this.checkCPassword(password, cpassword) && this.checkNumber(number)) {
       this.userService.register(userType, name, email, password, cpassword, address, number).subscribe(
	      val => {this.data=val;
        if(val!==undefined) {
          if(val[0].EMAILEXISTS===undefined) {
            this.router.navigate(['/login']);
          }
        }
      });
    }
  }
}