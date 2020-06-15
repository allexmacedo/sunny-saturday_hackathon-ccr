import React from "react";
import Button from "@material-ui/core/Button";
import { makeStyles } from "@material-ui/core/styles";
import LockIcon from "@material-ui/icons/Lock";
import { Colors } from "../../assets/colors";
import { Typography, ButtonBase } from "@material-ui/core";
import { useHistory } from "react-router-dom";

const useStyles = makeStyles((theme) => ({
  page: {
    marginTop: 60,
  },
  signUp: {
    display: "flex",
    background: Colors.GREEN,
    borderRadius: 5,
    paddingLeft: 15,
    color: Colors.WHITE,
  },
  filledLabel: {
    height: 60,
    marginLeft: 15,
    paddingLeft: 15,
    paddingRight: 15,
    borderTopRightRadius: 5,
    borderBottomRightRadius: 5,
    background: Colors.LIGHT_GREEN,
    display: "flex",
    alignItems: "center",
  },
  contained: {
    background: Colors.GREEN,
  },
  title: {
    fontWeight: "bold",
    maxWidth: 645,
    color: Colors.BLACK_MEDIUM,
    marginBottom: 40,
  },
  subtitle: {
    maxWidth: 625,
    color: Colors.DARK_GREY,
    marginBottom: 40,
  },
}));

const Home = () => {
  const classes = useStyles();
  const history = useHistory();

  const singIn = () => history.push("/login");
  const signUp = () => history.push("/cadastro");

  return (
    <div className={classes.page}>
      <Typography variant="h3" className={classes.title}>
        Guia com os principais pontos de apoio para profissionais de transportes
      </Typography>
      <Typography variant="h6" className={classes.subtitle}>
        Ajudamos caminhoneiros a encontrarem estabelecimentos e locais de apoio
        durante sua viagem.
      </Typography>
      <ButtonBase className={classes.signUp} onClick={signUp}>
        <LockIcon />
        <div className={classes.filledLabel}>
          <Typography>Cadastre sua empresa agora GRÁTIS!</Typography>
        </div>
      </ButtonBase>
    </div>
  );
};

export default Home;
