import React, { Component } from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'
import { connect } from "react-redux"
import { Snackbar } from "react-md"
import { fetchToken, deleteToken, dismissToast } from "../actions"

import '../assets/css/App.css'
import Authentication from './Authentication'
import Dashboard from './Dashboard'

class App extends Component {
  componentDidMount() {
    // Checks for user in localstorage
    this.props.fetchToken()
    // If the token is invalid, get rid of it
    if (this.props.status === 401)
      this.props.deleteToken()
  }

  render() {
    return (
      <div className="app">
        <div className="title-bar" />
        <BrowserRouter>
          <Switch className="app-container">
            <Route path="/auth" exact component={Authentication} />
            <Route path="/" component={Dashboard} />
          </Switch>
        </BrowserRouter>

        {/* Snackbars handled and displayed by this component */}
        <Snackbar
          toasts={this.props.toasts}
          autohide={true}
          onDismiss={this.props.dismissToast}
        />
      </div>
    );
  }
}

const mapStateToProps = state => ({
  toasts: state.toasts,
  username: state.auth.username,
  status: state.auth.status
})

const mapDispatchToProps = dispatch => ({
  fetchToken: () => dispatch(fetchToken(null)),
  deleteToken: () => dispatch(deleteToken()),
  dismissToast: (text, action) => dispatch(dismissToast(text, action))
})

export default connect(mapStateToProps, mapDispatchToProps)(App)
