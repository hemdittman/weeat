import React from 'react';
import {Row, Button, FormGroup, FormControl} from 'react-bootstrap'
import {FloatingActionButton, MuiThemeProvider} from 'material-ui';
import ContentAdd from 'material-ui/svg-icons/content/add';

const style = {

};


function Header() {
    return (
        <div>
            <Row>
                <div className='header'>
                    <Title />
                    <RestaurantSearch />
                </div>
            </Row>
            <Row className='filter'/>
        </div>
    );
}

function Title() {
    return (
        <Row>
            <div className='title'>WeEat</div>
        </Row>
    )
}

function RestaurantSearch() {
    return(
        <FormGroup>
            <FormControl type="text" placeholder="Search Restaurant..." />
        </FormGroup>
    )
}

function AddRestaurantBTN() {
    <div>
        <MuiThemeProvider>
            <FloatingActionButton className='btn-add-rest' mini={true}
                                  backgroundColor={'#dcdcdc'} style={style}>
                <ContentAdd />
            </FloatingActionButton>
        </MuiThemeProvider>
    </div>
}

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
            // <div>
            //     <span>{JSON.stringify(this.state.restaurants)}</span>
            // </div>
        )}
}

export default App;