import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import Links from './Links';
import Create from './Create';

import * as serviceWorker from './serviceWorker';
import {
  BrowserRouter as Router,
  Switch,
  Route,
  Link
} from "react-router-dom";


ReactDOM.render(
  <Router>
    <div>
      <ul>
        <li>
          <Link to="/">New Shortened Link</Link>
        </li>
        <li>
          <Link to="/links">Links</Link>
        </li>
      </ul>

      <hr />
      <Switch>
        <Route exact path="/">
          <Create />
        </Route>
        <Route path="/links">
          <Links />
        </Route>
      </Switch>
    </div>
  </Router>,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
