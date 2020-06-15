import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import SignIn from "../pages/signIn";
import SignUp from "../pages/signUp";
import Home from "../pages/home";
import Company from "../pages/company";
import AddCompany from "../pages/companyAdd";
import CompanyList from "../pages/companyList";

import PrivateRouter from "../shared/privateRoute";
import Navbar from "../shared/navbar";
import { makeStyles } from "@material-ui/core/styles";

const useStyles = makeStyles((theme) => ({
  page: {
    padding: "6vh 12vh",
  },
}));

export default () => {
  const classes = useStyles();
  return (
    <Router>
      <div className={classes.page}>
        <Navbar />
        <Switch>
          <Route path="/" component={Home} exact={true} />
          <Route path="/login" component={SignIn} />
          <Route path="/cadastro" component={SignUp} />
          <PrivateRouter path="/empresa" component={Company} />
          <PrivateRouter path="/incluir-empresa" component={AddCompany} />
          <PrivateRouter path="/empresa-lista" component={CompanyList} />
        </Switch>
      </div>
    </Router>
  );
};
