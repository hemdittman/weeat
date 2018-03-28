import React from 'react';
import Header from "./header";


class App extends React.Component {
    constructor() {
        super();
        this.state = {
            restaurants: [],
            cuisines: []
        };
    }

    componentDidMount() {
        this.apiFetch(this.api.restaurants, data => {this.setState({restaurants: data})});
        this.apiFetch(this.api.cuisines, data => {this.setState({cuisines: data})});
    }

    api = {
       restaurants: 'restaurants',
       cuisines: 'cuisines'
    }

    apiFetch(endpoint, callback) {
        fetch(endpoint)
            .then(response => response.json())
            .then(data => {callback(data)})
    }

    render() {
        return(
            <div>
                <Header />
            </div>
        )}
}

export default App;