import { LoginTypes } from "../types";

export const AuthorizeLogin = (token: string) => ({
  isAuthenticated: true,
  token,
  type: LoginTypes.SUCCESS_LOGIN,
});

export const Logout = {
  isAuthenticated: false,
  type: LoginTypes.LOGOUT,
};
