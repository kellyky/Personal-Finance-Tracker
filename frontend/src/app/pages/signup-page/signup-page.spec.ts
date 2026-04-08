import { ComponentFixture, TestBed } from '@angular/core/testing';
import { provideRouter } from '@angular/router';
import { SignupPage } from './signup-page';

describe('SignupPage', () => {
  let component: SignupPage;
  let fixture: ComponentFixture<SignupPage>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SignupPage],
      providers: [provideRouter([])]
    }).compileComponents();

    fixture = TestBed.createComponent(SignupPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render promotional text in header', () => {
    const h2 = fixture.nativeElement.querySelector('h2');
    expect(h2.textContent).toContain('Keep track of your money');
  });

  it('should contain the login form component in signup mode', () => {
    const loginForm = fixture.nativeElement.querySelector('app-login-form-component');
    expect(loginForm).toBeTruthy();
    expect(loginForm.getAttribute('mode')).toBe('signup');
  });
});
