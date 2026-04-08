import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { LoginFormComponent } from './login-form-component';

describe('LoginFormComponent', () => {
  let component: LoginFormComponent;
  let fixture: ComponentFixture<LoginFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [LoginFormComponent],
      providers: [provideRouter([])]
    }).compileComponents();

    fixture = TestBed.createComponent(LoginFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should default to login mode', () => {
    expect(component.mode).toBe('login');
    const h1 = fixture.nativeElement.querySelector('h1');
    expect(h1.textContent).toContain('Login');
  });

  it('should switch to signup mode when input is set', () => {
    fixture.componentRef.setInput('mode', 'signup');
    fixture.detectChanges();
    
    const h1 = fixture.nativeElement.querySelector('h1');
    expect(h1.textContent).toContain('Sign Up');
    
    const nameLabel = fixture.nativeElement.querySelector('label[for="name"]');
    expect(nameLabel).toBeTruthy();
  });

  it('should not show name field in login mode', () => {
    fixture.componentRef.setInput('mode', 'login');
    fixture.detectChanges();
    
    const nameLabel = fixture.nativeElement.querySelector('label[for="name"]');
    expect(nameLabel).toBeFalsy();
  });

  it('should toggle password visibility', async () => {
    const passwordInput = fixture.nativeElement.querySelector('#password');
    expect(passwordInput.type).toBe('password');
    
    component.togglePasswordVisibility();
    fixture.detectChanges();
    await fixture.whenStable();
    fixture.detectChanges();
    
    expect(passwordInput.type).toBe('text');
    
    component.togglePasswordVisibility();
    fixture.detectChanges();
    await fixture.whenStable();
    fixture.detectChanges();
    
    expect(passwordInput.type).toBe('password');
  });

  it('should show correct redirect link for login mode', () => {
    fixture.componentRef.setInput('mode', 'login');
    fixture.detectChanges();
    
    const link = fixture.nativeElement.querySelector('a');
    expect(link.getAttribute('routerLink')).toBe('/signUp');
    expect(link.textContent).toContain('Sign Up');
  });

  it('should show correct redirect link for signup mode', () => {
    fixture.componentRef.setInput('mode', 'signup');
    fixture.detectChanges();
    
    const link = fixture.nativeElement.querySelector('a');
    expect(link.getAttribute('routerLink')).toBe('/');
    expect(link.textContent).toContain('Login');
  });
});
