export interface ILogin {
  isAuthenticated: boolean;
  errorMessage?: string;
}

export interface ILoginForm {
  usr_email: string;
  usr_password: string;
}
