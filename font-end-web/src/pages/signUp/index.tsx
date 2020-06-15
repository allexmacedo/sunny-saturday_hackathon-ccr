import React, { useEffect, useState } from "react";
import { useFormik } from "formik";
import { useDispatch, useSelector } from "react-redux";
import { AuthorizeLogin } from "../../store/login/actions";
import { useHistory } from "react-router-dom";
import { IStore } from "../../interfaces/store";
import Button from "@material-ui/core/Button";
import { makeStyles } from "@material-ui/core/styles";
import CheckCircle from "../../assets/icons/check.svg";
import { Colors } from "../../assets/colors";
import { Typography, Divider, Dialog } from "@material-ui/core";
import TextField from "../../shared/textField";
import { ISignUpForm } from "../../interfaces/signUp";
import Request from "../../services";

const useStyles = makeStyles((theme) => ({
  label: {
    fontWeight: "bold",
    textTransform: "none",
  },
  signUp: {
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
  form: {
    display: "flex",
    flexDirection: "column",
    width: "100%",
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
  dialogTitle: {
    fontSize: 24,
    fontWeight: "bold",
    color: Colors.WHITE,
  },
  backdrop: {
    backgroundColor: "rgba(0, 0, 0, 0.8)",
  },
  paper: {
    display: "flex",
    flexDirection: "column",
    background: "rgba(0,0,0,0)",
    boxShadow: "none",
  },
}));

const SignUp = () => {
  const [openDialog, toggleDialog] = useState<boolean>(false);

  const isAuthenticated = useSelector(
    (store: IStore) => store.Login.isAuthenticated
  );

  const classes = useStyles();
  const history = useHistory();
  const dispatch = useDispatch();
  const initialValues: ISignUpForm = {
    usr_name: "",
    usr_email: "",
    usr_password: "",
    usr_confirmPassword: "",
  };

  const validate = (form: ISignUpForm) => {
    let errors: any = {};

    if (!form.usr_name) errors.usr_name = "Você precisa preencher esse campo";

    if (!form.usr_email) errors.usr_email = "Você precisa preencher esse campo";

    if (!form.usr_password)
      errors.usr_password = "Você precisa preencher esse campo";

    if (form.usr_password.length < 8)
      errors.usr_password = "Sua senha precisa ter mais de 8 caracteres";

    if (form.usr_password != form.usr_confirmPassword)
      errors.usr_confirmPassword = "Os campos de senha precisam ser iguais";

    return errors;
  };
  const onSubmit = (form: ISignUpForm) => {
    toggleDialog(true);
    Request.SignUp({ ...form, usr_type: "partner" })
      .then((response: any) =>
        dispatch(AuthorizeLogin(`Bearer ${response.data.token}`))
      )
      .catch((e) => console.log(e));
  };

  const goBack = () => history.goBack();
  const signIn = () => history.push("/login");

  const formik = useFormik({
    initialValues,
    validate,
    validateOnChange: false,
    onSubmit,
  });
  useEffect(() => {
    if (isAuthenticated) setTimeout(() => history.push("/empresa"), 1000);
  }, [isAuthenticated]);
  return (
    <>
      <div className={classes.container}>
        <div className={classes.signUp}>
          <Typography className={classes.title}>Efetuar cadastro</Typography>
          <form className={classes.form} onSubmit={formik.handleSubmit}>
            <TextField
              id="usr_name"
              name="Nome"
              type="name"
              onChange={formik.handleChange}
              value={formik.values.usr_name}
              errorMessage={formik.errors.usr_name}
            />
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
            <TextField
              id="usr_confirmPassword"
              name="Confirmar senha"
              type="password"
              onChange={formik.handleChange}
              value={formik.values.usr_confirmPassword}
              errorMessage={formik.errors.usr_confirmPassword}
            />
            <Button
              variant="contained"
              className={classes.submit}
              classes={{ contained: classes.contained, label: classes.label }}
              type="submit"
            >
              Entrar
            </Button>
            <Divider className={classes.divider} />
            <Button
              onClick={signIn}
              disableRipple={true}
              variant="text"
              classes={{ label: classes.textLabel }}
            >
              Já tem uma conta? Clique aqui para entrar
            </Button>
          </form>
        </div>
      </div>
      <Dialog
        open={openDialog}
        classes={{ paper: classes.paper, root: classes.backdrop }}
      >
        <img src={CheckCircle} />
        <Typography className={classes.dialogTitle}>
          Cadastro concluído!
        </Typography>
      </Dialog>
    </>
  );
};

export default SignUp;
