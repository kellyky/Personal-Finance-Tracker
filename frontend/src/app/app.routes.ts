import { Routes } from '@angular/router';
import { LoginPage } from './pages/login-page/login-page';
import { SignupPage } from './pages/signup-page/signup-page';

export const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'login' },
  { path: 'login', component: LoginPage },
  { path: 'signUp', component: SignupPage },
];
