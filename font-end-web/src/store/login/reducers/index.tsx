import { LoginTypes } from "../types";
import { ILogin } from "../../../interfaces/login";

interface IAction {
  isAuthenticated: boolean;
  token?: string;
  errorMessage?: string;
  type: LoginTypes;
}

const initialState = {
  isAuthenticated: false,
};

const handleLogin = (action: IAction) => {
  if (action.token) sessionStorage.setItem("Token", action.token);
  if (!action.isAuthenticated) sessionStorage.removeItem("Token");
  return action.isAuthenticated;
};

const Login = (state: ILogin = initialState, action: IAction) => {
  switch (action.type) {
    case LoginTypes.SUCCESS_LOGIN:
      return {
        ...state,
        isAuthenticated: handleLogin(action),
      };

    case LoginTypes.LOGOUT:
      return {
        ...state,
        isAuthenticated: handleLogin(action),
      };
    default:
      return state;
  }
};

export default Login;
