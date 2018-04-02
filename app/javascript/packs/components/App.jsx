import React from 'react';
import SearchBar from "./search_bar";
import {Col, FormControl, FormGroup, Row} from "react-bootstrap";
import RestaurantsList from "./restaurants_list";
import {RestaurantsMap} from "./restaurants_map";


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
            restaurantFilter: '',
            mapPosition: {lat: 40.732013, lng: -73.996155}
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
        if (this.state.restaurantFilter && rest.name.toLowerCase().search(
            this.state.restaurantFilter.toLowerCase()) === -1) {
            return false;
        } else if (this.state.selectedCuisines.length > 0 && !this.state.selectedCuisines.some(
            item => item.value == rest.cuisine_id)) {
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

    handleRestaurantClick = (rest) => {
        this.setState({mapPosition: {lat: rest.latitude, lng: rest.longitude}})
    };


    render() {
        return (
            <div>
                <Header cuisines={this.state.cuisines}
                        selectedCuisines={this.state.selectedCuisines}
                        maxDeliveryTime={this.state.maxDeliveryTime}
                        rating={this.state.rating}
                        only10Bis={this.state.only10bis}
                        restaurantsFilter={this.state.restaurantFilter}
                        onFilterChange={this.handleFilterChange.bind(this)}/>
                <Body restaurants={this.state.filteredRestaurants}
                      mapPosition={this.state.mapPosition}
                      onRestaurantClick={this.handleRestaurantClick.bind(this)} />
            </div>
        )
    }
}

function Header(props) {
    return (
        <div className='header'>
            <Row>
                <div className='title'>we eat</div>
            </Row>
            <RestaurantSearch restaurantsFilter={props.restaurantFilter}
                              onFilterChange={props.onFilterChange} />
            <SearchBar cuisines={props.cuisines}
                       onFilterChange={props.onFilterChange} />
        </div>
    );
}

function RestaurantSearch(props) {
    return(
        <FormGroup>
            <FormControl type='text'
                         placeholder='Search Restaurant...'
                         onChange={(e) => {
                             props.onFilterChange({restaurantFilter: e.target.value});}} />
        </FormGroup>
    )
}

function Body(props) {
    return (
        <div>
            <Row>
                <Col md={4} className='restaurants-list'>
                    <RestaurantsList restaurants={props.restaurants}
                                     onRestaurantClick={props.onRestaurantClick} />
                </Col>
                <Col md={8} className='restaurants-map'>
                    <RestaurantsMap
                        googleMapURL="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry,drawing,places"
                        loadingElement={<div style={{height: '100%'}} />}
                        containerElement={<div style={{height: '100%'}} />}
                        mapElement={<div style={{height: '100%'}} />}
                        center={props.mapPosition}
                        restaurants={props.restaurants}/>
                </Col>
            </Row>
        </div>
    );
}

export default App;