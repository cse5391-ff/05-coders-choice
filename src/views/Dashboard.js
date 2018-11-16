import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Route, Switch, Redirect } from 'react-router-dom'

import '../assets/css/Dashboard.css'

import Header from '../components/Header'
import Home from './Home'
import Profile from './Profile'

class Dashboard extends Component {
    render() {
        return (
            <div className="dashboard">
                <Header />
                {/* Redirects to the auth page once signed out */}
                {!this.props.username && <Redirect to="/auth" />}
                <div className="page">
                    <Switch>
                        <Route path="/user" component={Profile} />
                        <Route path="/" component={Home} />
                    </Switch>
                </div>
            </div>
        )
    }
}

const mapStateToProps = state => ({
    username: state.auth.username
})

export default connect(mapStateToProps)(Dashboard)
