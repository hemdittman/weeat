import React from 'react';
import {Row, FormGroup, FormControl, Col} from 'react-bootstrap'
import {FloatingActionButton, MuiThemeProvider, SelectField, Slider} from 'material-ui';
import StarRatingComponent from 'react-star-rating-component';
// import ReactBootstrapSlider from 'react-bootstrap-slider';
import ContentAdd from 'material-ui/svg-icons/content/add';

export default function Header(props) {
    return (
        <div className='header'>
            <Row>
                <div className='title'>we eat</div>
            </Row>
            <RestaurantSearch />
            <SearchBar cuisines={props.cuisines}/>
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

function SearchBar(props) {
    return (
        <Row className='search-bar'>
            <Col md={4}>
                <CuisineSearch cuisines={props.cuisines}/>
            </Col>
            <Col md={2}>
                <RatingFilter />
            </Col>
            <Col md={2}></Col>
            <Col md={4}>
                {/*<DeliveryTimeSlider />*/}
            </Col>
        </Row>
    )
}

function AddRestaurantBTN() {
    return(
        <div>
            <MuiThemeProvider>
                <FloatingActionButton className='btn-add-rest' mini={true}
                                      backgroundColor={'#dcdcdc'} style={style}>
                    <ContentAdd />
                </FloatingActionButton>
            </MuiThemeProvider>
        </div>
    )
}


function CuisineSearch(props) {
    const options = props.cuisines.map(cuisine => {
        return (<option key={cuisine.id} value={cuisine.id}>{cuisine.name}</option>)
    });

    return(
        <FormGroup className="select-cuisine">
            <FormControl componentClass="select" placeholder="Select cuisine">
                <option>All</option>
                {options}
            </FormControl>
        </FormGroup>
    )
}

class RatingFilter extends React.Component {
    constructor() {
        super();

        this.state = {
            rating: 0
        };
    }

    onStarClick(nextValue, prevValue, name) {
        this.setState({rating: nextValue});
    }

    render() {
        const { rating } = this.state;

        return (
            <StarRatingComponent className={'select-rating'}
                                 name={'rating'}
                                 starCount={3}
                                 value={rating}
                                 onStarClick={this.onStarClick.bind(this)} />
        )
    }
}

class DeliveryTimeSlider extends React.Component {
    constructor() {
        super();

        this.state = {
            sliderValue: 30
        }
    }

    handleSliderChange = (event, value) => {
        this.setState({sliderValue: value});
    };

    render() {
        return (
                <ReactBootstrapSlider
                    value={this.state.sliderValue}
                    slideStop={this.handleSliderChange}
                    step={15}
                    max={120}
                    min={0}/>

        );
    }
}
