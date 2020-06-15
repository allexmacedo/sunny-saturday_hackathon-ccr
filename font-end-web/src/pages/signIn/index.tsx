import React, { useEffect } from "react";
import { useFormik } from "formik";
import { useDispatch, useSelector } from "react-redux";
import { AuthorizeLogin } from "../../store/login/actions";
import { useHistory } from "react-router-dom";
import { IStore } from "../../interfaces/store";
import Button from "@material-ui/core/Button";
import { makeStyles } from "@material-ui/core/styles";
import { Colors } from "../../assets/colors";
import { Typography, Divider } from "@material-ui/core";
import TextField from "../../shared/textField";
import { ILoginForm } from "../../interfaces/login";
import Request from "../../services";

const useStyles = makeStyles((theme) => ({
  label: {
    fontWeight: "bold",
    textTransform: "none",
  },
  signIn: {
    display: "flex",
    flexDirection: "column",
    alignItems: "center",
    background: Colors.WHITE,
    border: `3px solid ${Colors.GREY}`,
    borderRadius: 5,
    minWidth: 550,
    padding: 24,
    boxSizing: "border-box",
  },
  signInForm: {
    display: "flex",
    flexDirection: "column",
  },
  container: {
    display: "flex",
    flexGrow: 1,
    alignItems: "center",
    justifyContent: "center",
    transform: "scale(0.8)",
  },
  title: {
    color: Colors.DARK_GREY_MEDIUM,
    fontWeight: "bold",
    fontSize: 24,
    textAlign: "center",
    marginBottom: 16,
    maxWidth: 303,
  },
  contained: {
    background: Colors.LIGHT_GREEN,
    "&:hover": {
      background: Colors.GREEN,
    },
  },
  submit: {
    marginTop: theme.spacing(1),
    marginBottom: theme.spacing(1),
    color: Colors.WHITE,
  },
  textLabel: {
    textTransform: "none",
    color: Colors.GREY_MEDIUM,
    "&:hover": {
      color: Colors.GREEN,
    },
  },
  divider: {
    marginTop: theme.spacing(1),
    marginBottom: theme.spacing(1),
  },
}));

const Login = () => {
  const isAuthenticated = useSelector(
    (store: IStore) => store.Login.isAuthenticated
  );
  const classes = useStyles();
  const history = useHistory();
  const dispatch = useDispatch();
  const initialValues: ILoginForm = {
    usr_email: "",
    usr_password: "",
  };

  const validate = (values: ILoginForm) => {
    let errors: any = {};

    if (!values.usr_email) errors.email = "Requirido";

    if (!values.usr_password) errors.password = "Requirido";

    return errors;
  };
  const onSubmit = (values: ILoginForm) => {
    Request.SignIn(values).then((response: any) =>
      dispatch(AuthorizeLogin(`Bearer ${response.data.token}`))
    );
  };
  const goBack = () => history.goBack();
  const signUp = () => history.push("/cadastro");

  const formik = useFormik({
    initialValues,
    validate,
    onSubmit,
  });

  useEffect(() => {
    if (isAuthenticated) history.push("/empresa");
  }, [isAuthenticated]);
  return (
    <div className={classes.container}>
      <div className={classes.signIn}>
        <Typography className={classes.title}>
          Preencha os campos abaixo para efetuar o login
        </Typography>
        <form className={classes.signInForm} onSubmit={formik.handleSubmit}>
          <TextField
            id="usr_email"
            name="E-mail"
            onChange={formik.handleChange}
            value={formik.values.usr_email}
            errorMessage={formik.errors.usr_email}
          />
          <TextField
            id="usr_password"
            name="Senha"
            type="password"
            onChange={formik.handleChange}
            value={formik.values.usr_password}
            errorMessage={formik.errors.usr_password}
          />
          <Button
            variant="contained"
            className={classes.submit}
            classes={{ contained: classes.contained, label: classes.label }}
            type="submit"
          >
            Entrar
          </Button>
          <Button
            disableRipple={true}
            variant="text"
            classes={{ label: classes.textLabel }}
          >
            Recuperar senha
          </Button>
          <Divider className={classes.divider} />
          <Button
            onClick={signUp}
            disableRipple={true}
            variant="text"
            classes={{ label: classes.textLabel }}
          >
            Não tem conta? Crie uma conta agora gratis!
          </Button>
        </form>
      </div>
    </div>
  );
};

export default Login;
