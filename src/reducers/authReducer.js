import {
    FETCH_TOKEN,
    DELETE_TOKEN,
    CREATE_USER
} from "../actions/types"

// Handles registration and login
export default function (state = {
    username: null
}, action) {
    switch (action.type) {
        case FETCH_TOKEN:
            return {
                username: action.payload.username,
                status: action.payload.status
            }
        case DELETE_TOKEN:
            return {
                username: null
            }
        case CREATE_USER:
            return {
                status: action.status
            }
        default:
            return state
    }
}