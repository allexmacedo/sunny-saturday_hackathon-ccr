import React from "react";
import { useHistory, Link } from "react-router-dom";
import { makeStyles } from "@material-ui/core/styles";
import { Colors } from "../../assets/colors";
import { Typography } from "@material-ui/core";
import HouseIcon from "../../assets/icons/house.svg";
import BuildingIcon from "../../assets/icons/building.svg";

const useStyles = makeStyles((theme) => ({
  page: {
    marginTop: 32,
  },
  container: {
    marginTop: 32,
    display: "flex",
    height: "100%",
    flexGrow: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  card: {
    display: "flex",
    justifyContent: "center",
    alignItems: "center",
    flexDirection: "column",
    background: Colors.WHITE,
    width: 265,
    height: 312,
    border: `3px solid ${Colors.GREY}`,
    borderRadius: 5,
    "&:nth-of-type(1)": {
      marginRight: theme.spacing(4),
    },
    cursor: "pointer",
    "& > p:nth-of-type(1)": {
      display: "block",
      minHeight: 62,
      padding: `0px ${theme.spacing(1)}px`,
      textAlign: "center",
      fontSize: 26,
      fontFamily: "Roboto",
      fontWeight: "bold",
      transition: "0.5s",
    },
    "& > p:nth-of-type(2)": {
      transition: "0.5s",
      display: "block",
      minHeight: 58,
      maxWidth: 250,
      textAlign: "center",
      margin: 0,
      padding: 0,
      fontSize: 16,
      fontFamily: "Roboto",
      color: Colors.DARK_GREY_MEDIUM,
    },

    transition: "0.5s",
    "&:hover": {
      borderColor: Colors.LIGHT_GREEN,
      "& > p:nth-of-type(1)": {
        color: Colors.GREEN,
      },
      "& > p:nth-of-type(2)": {
        color: Colors.BLACK_MEDIUM,
      },
    },
  },
  title: {
    color: Colors.DARK_GREY_MEDIUM,
    fontWeight: "bold",
    fontSize: 34,
    textAlign: "center",
  },
  subtitle: {
    color: Colors.DARK_GREY_MEDIUM,
    fontSize: 18,
    textAlign: "center",
  },
}));

interface ILoginForm {
  email: string;
  password: string;
}

const AddCompany = () => {
  const classes = useStyles();
  const history = useHistory();

  const simpleCompany = () => history.push("/incluir-empresa");

  return (
    <div className={classes.page}>
      <Typography className={classes.title}>Cadastro de empresa</Typography>
      <Typography className={classes.subtitle}>
        Selecione o perfil que melhor se encaixa com sua empresa
      </Typography>
      <div className={classes.container}>
        <div onClick={simpleCompany} className={classes.card}>
          <img src={HouseIcon} />
          <p>Simples</p>
          <p>Perfeito para empresas que possuí um único endereço</p>
        </div>
        <div className={classes.card}>
          <img src={BuildingIcon} />
          <p>Redes e Concessionárias</p>
          <p>
            Feito para empresas que tem uma ou mais filiais ou pontos de
            atendimento.
          </p>
        </div>
      </div>
    </div>
  );
};

export default AddCompany;
