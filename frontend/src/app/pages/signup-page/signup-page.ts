import { Component } from '@angular/core';
import { LoginFormComponent } from '../../components/login-form-component/login-form-component';

@Component({
  selector: 'app-signup-page',
  imports: [LoginFormComponent],
  templateUrl: './signup-page.html',
  styleUrl: './signup-page.css',
})
export class SignupPage {}
