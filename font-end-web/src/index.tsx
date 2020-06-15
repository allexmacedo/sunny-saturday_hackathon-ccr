import React from "react";
import ReactDOM from "react-dom";
import Routes from "./routes";
import { Provider } from "react-redux";
import Store from "./store";
import * as serviceWorker from "./serviceWorker";

ReactDOM.render(
  <React.StrictMode>
    <Provider store={Store}>
      <Routes />
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);
serviceWorker.unregister();
