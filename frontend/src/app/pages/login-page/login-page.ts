import { Component } from '@angular/core';
import { LoginFormComponent } from '../../components/login-form-component/login-form-component';

@Component({
  selector: 'app-login-page',
  imports: [LoginFormComponent],
  templateUrl: './login-page.html',
  styleUrl: './login-page.css',
})
export class LoginPage {}
