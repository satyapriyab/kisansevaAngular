import { Routes, RouterModule } from '@angular/router';

import { LoginComponent } from './views/login/login.component';
import { RegisterComponent } from './views/register/register.component';
import { ForgotPasswordComponent } from './views/login/forgotPassword.component';
import { ResetPasswordComponent } from './views/login/resetPassword.component';
import { HomeComponent } from './views/Home/home.component';
import { adminHomeComponent } from './views/Admin/adminHome.component';
import { adminNavbarComponent } from './views/Admin/adminNavbar.component';
import { AuthGuard } from './guards/index';


const appRoutes: Routes = [
    { path: 'login', component: LoginComponent },
    { path: '', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: 'resetPassword', component: ResetPasswordComponent },
    { path: 'forgotPassword', component: ForgotPasswordComponent },
    { path: 'home', component: HomeComponent, canActivate: [AuthGuard] ,
        children: [
        { path: 'adminNavbar', component: adminNavbarComponent, canActivate: [AuthGuard] ,
            children: [
                { path: 'adminHome', component: adminHomeComponent, canActivate: [AuthGuard] }
                ]
            }
        ]
    }
    ];

export const routing = RouterModule.forRoot(appRoutes);