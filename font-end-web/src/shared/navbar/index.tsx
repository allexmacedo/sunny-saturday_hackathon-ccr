import React, { useState, useEffect } from "react";
import Button from "@material-ui/core/Button";
import { makeStyles } from "@material-ui/core/styles";
import LockIcon from "@material-ui/icons/Lock";
import ArrowBackIcon from "@material-ui/icons/ArrowBack";
import ExitToAppIcon from "@material-ui/icons/ExitToApp";
import Logo from "../../assets/icons/logo.svg";
import { Colors } from "../../assets/colors";
import { useHistory, withRouter } from "react-router-dom";
import { Typography } from "@material-ui/core";
import { useSelector, useDispatch } from "react-redux";
import { IStore } from "../../interfaces/store";
import { Logout } from "../../store/login/actions";

const useStyles = makeStyles((theme) => ({
  navbar: {
    display: "flex",
    maxHeight: 100,
    flexGrow: 1,
    justifyContent: "space-between",
  },
  text: {
    color: Colors.GREEN,
  },
  outlined: {
    color: Colors.GREEN,
    borderColor: Colors.GREEN,
  },
  label: {
    fontWeight: "bold",
    textTransform: "none",
  },
  navbarActions: {
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
  },
  accountName: {
    color: Colors.DARK_GREY_MEDIUM,
    fontSize: 16,
    marginRight: 32,
  },
}));

const Navbar = (props: any) => {
  const [isHome, setIsHome] = useState<boolean>(true);
  const isAuthenticated = useSelector(
    (store: IStore) => store.Login.isAuthenticated
  );
  const classes = useStyles();
  const history = useHistory();
  const dispatch = useDispatch();

  const singIn = () => history.push("/login");
  const goBack = () => history.goBack();
  const exit = () => {
    dispatch(Logout);
    history.push("/");
  };

  useEffect(() => {
    setIsHome(props.location.pathname == "/");
  }, [props.location]);

  return (
    <div className={classes.navbar}>
      <img width={150} height={48} src={Logo} />
      {isHome && !isAuthenticated && (
        <Button
          variant="outlined"
          classes={{ outlined: classes.outlined, label: classes.label }}
          startIcon={<LockIcon />}
          onClick={singIn}
        >
          Fazer Login
        </Button>
      )}
      {!isHome && !isAuthenticated && (
        <Button
          variant="text"
          classes={{ label: classes.label, text: classes.text }}
          startIcon={<ArrowBackIcon />}
          onClick={goBack}
        >
          Voltar
        </Button>
      )}
      {isAuthenticated && (
        <div className={classes.navbarActions}>
          <Typography className={classes.accountName}>
            Olá, José Antonio
          </Typography>
          <Button
            variant="text"
            classes={{ label: classes.label, text: classes.text }}
            endIcon={<ExitToAppIcon />}
            onClick={exit}
          >
            Sair
          </Button>
        </div>
      )}
    </div>
  );
};

export default withRouter((props) => <Navbar {...props} />);
