import { createStore, Action } from "redux";
import { combineReducers } from "redux";
import { IStore } from "../interfaces/store";

import Login from "./login/reducers";

const Reducers = combineReducers({
  Login: Login,
});

export default createStore(Reducers);
