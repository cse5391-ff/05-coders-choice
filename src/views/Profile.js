import React, { Component } from 'react'
import { connect } from 'react-redux'

class Profile extends Component {
    render() {
        return (
            <div className="profile">
                <p>{this.props.username}</p>
            </div>
        )
    }
}

const mapStateToProps = state => ({
    username: state.auth.username
})

const mapDispatchToProps = dispatch => ({ })

export default connect(mapStateToProps, mapDispatchToProps)(Profile)
