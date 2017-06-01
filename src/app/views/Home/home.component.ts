import { Component , OnInit} from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { adminNavbarComponent } from '../Admin/adminNavbar.component';


@Component({
  moduleId: module.id,
  templateUrl: 'home.component.html'
})
export class HomeComponent implements OnInit{
  title = 'Home';
  email: string; name: string; type: string; image: string;

  constructor(private router: Router) { }

  ngOnInit() {
    this.email=localStorage.getItem("currentUser");
    this.name=localStorage.getItem("userName");
    this.type=localStorage.getItem("userType");
    this.image=localStorage.getItem("userImage");
  }

  signout() {
    localStorage.setItem('currentUser', "");
    this.router.navigate(['/login']);
  }
}