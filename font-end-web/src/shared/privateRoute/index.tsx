import React, { useState, useEffect } from "react";
import { Route, Redirect } from "react-router-dom";
import { IStore } from "../../interfaces/store";
import { useSelector } from "react-redux";

const PrivateRouter = ({ component: Component, ...rest }: any) => {
  const isAuthenticated = useSelector(
    (store: IStore) => store.Login.isAuthenticated
  );

  return (
    <Route
      {...rest}
      render={(props) =>
        isAuthenticated ? <Component {...props} /> : <Redirect to="/" />
      }
    />
  );
};

export default PrivateRouter;
