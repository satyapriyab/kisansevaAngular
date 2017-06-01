import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { routing }        from './app.routing';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { LoginComponent } from './views/login/login.component';
import { ForgotPasswordComponent } from './views/login/forgotPassword.component';
import { ResetPasswordComponent } from './views/login/resetPassword.component';
import { RegisterComponent } from './views/register/register.component';
import { HomeComponent } from './views/Home/home.component';
import { adminHomeComponent } from './views/Admin/adminHome.component';
import { adminNavbarComponent } from './views/Admin/adminNavbar.component';
import { userServices } from './services/userServices';
import { AuthGuard } from './guards/index';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    ForgotPasswordComponent,
    ResetPasswordComponent,
    adminHomeComponent,
    adminNavbarComponent,
    HomeComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    ReactiveFormsModule,
    HttpModule,
    routing
  ],
  providers: [ AuthGuard, userServices ],
  bootstrap: [AppComponent]
})
export class AppModule { }