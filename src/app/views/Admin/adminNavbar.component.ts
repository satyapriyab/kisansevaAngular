import { Component } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';


@Component({
	selector: 'sidebar',
  moduleId: module.id,
  templateUrl: 'adminNavbar.component.html'
})
export class adminNavbarComponent {
  title = 'Home';

  constructor(private router: Router) { }

  emailErrorMessage = '';
  passwordErrorMessage = '';

  ngOnInit() {
    if (localStorage.getItem('userType') !== "1") {
      this.router.navigate(['/login']);
    } 
  }
}