import Axios from "axios";
import { ISignUpForm } from "../interfaces/signUp";
import { ILoginForm } from "../interfaces/login";

const axios = () => {
  const config = {
    baseURL: "http://sunny-saturday-app.herokuapp.com/",
    timeout: 60000,
    headers: {
      Authorization: JSON.stringify(sessionStorage.getItem("Token")).replace(
        /"/g,
        ""
      ),
    },
  };

  return Axios.create(config);
};

export const Instance = axios();

const SignUp = (form: ISignUpForm) =>
  axios().post("user", {
    user: {
      usr_email: form.usr_email,
      usr_password: form.usr_password,
      usr_type: form.usr_type,
    },
  });

const SignIn = (form: ILoginForm) => axios().post("login", form);

const Partners = () => axios().get("/partners");

const insertPartner = (form: any) => axios().post("/partner", form);

export default {
  SignUp,
  SignIn,
  Partners,
  insertPartner,
};
