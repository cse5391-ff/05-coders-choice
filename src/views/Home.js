import React, { Component } from 'react'
import { connect } from 'react-redux'

class Home extends Component {
    render() {
        return (
            <div className="profile">
                <p>Home</p>
            </div>
        )
    }
}

const mapStateToProps = state => ({
    username: state.auth.username
})

const mapDispatchToProps = dispatch => ({ })

export default connect(mapStateToProps, mapDispatchToProps)(Home)
