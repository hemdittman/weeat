import React from 'react';
import SearchBar from "./search_bar";
import {Col, FormControl, FormGroup, Row} from "react-bootstrap";
import RestaurantsList from "./restaurants_list";


class App extends React.Component {
    constructor() {
        super();
        this.state = {
            filteredRestaurants: [],
            restaurants: [],
            cuisines: [],
            selectedCuisines: [],
            maxDeliveryTime: 120,
            rating: 0,
            only10bis: false,
            restaurantFilter: ''
        };
    }

    componentDidMount() {
        this.apiFetch(this.api.restaurants, data => {this.setState({restaurants: data, filteredRestaurants: data})});
        this.apiFetch(this.api.cuisines, data => {this.setState({cuisines: data})});
    }

    api = {
       restaurants: 'restaurants',
       cuisines: 'cuisines'
    };

    apiFetch(endpoint, callback) {
        fetch(endpoint)
            .then(response => response.json())
            .then(data => {callback(data)})
    }

    handleFilterChange = (newFilter) => {
        this.setState(newFilter, () => {
            const filteredRestaurants = this.state.restaurants.filter(this.applyFilter.bind(this));
            this.setState({filteredRestaurants: filteredRestaurants})
        });
    };

    applyFilter(rest) {
        if (this.state.selectedCuisines.length > 0 && !this.state.selectedCuisines.some(item => item.value == rest.cuisine_id)) {
            return false;
        } else if (rest.max_delivery_time_minutes > this.state.maxDeliveryTime) {
            return false;
        } else if (rest.rating < this.state.rating) {
            return false;
        } else if (this.state.only10Bis && !rest.accepts_10bis) {
            return false;
        }
        return true;
    };


    render() {
        return(
            <div>
                <Header cuisines={this.state.cuisines}
                        selectedCuisines={this.state.selectedCuisines}
                        maxDeliveryTime={this.state.maxDeliveryTime}
                        rating={this.state.rating}
                        only10Bis={this.state.only10bis}
                        onFilterChange={this.handleFilterChange.bind(this)}/>
                <Body restaurants={this.state.filteredRestaurants}/>
            </div>
        )}
}

function Header(props) {
    return (
        <div className='header'>
            <Row>
                <div className='title'>we eat</div>
            </Row>
            <RestaurantSearch />
            <SearchBar cuisines={props.cuisines}
                       onFilterChange={props.onFilterChange}/>
        </div>
    );
}

function RestaurantSearch() {
    return(
        <FormGroup>
            <FormControl type='text' placeholder='Search Restaurant...' />
        </FormGroup>
    )
}

function Body(props) {
    return (
        <div>
            <Row>
                <Col md={4} className='restaurants-list'>
                    <RestaurantsList restaurants={props.restaurants} />
                </Col>
                <Col md={8} className='restaurants-map'>
                </Col>
            </Row>
        </div>
    )
}

export default App;