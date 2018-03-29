import React from 'react';
import {Row, FormGroup, FormControl, Col} from 'react-bootstrap'
import {FloatingActionButton, MuiThemeProvider, Checkbox} from 'material-ui';
import StarRatingComponent from 'react-star-rating-component';
import Slider from 'rc-slider';
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
            <Col md={4}>
                <DeliveryTimeSlider />
            </Col>
            <Col md={2}>
                <RatingFilter />
            </Col>
            <Col md={2}>
                <Filter10Bis />
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
            <div className='filter-min-rating'>
                <div className='filter-title'>Minimum rating</div>
                <StarRatingComponent className={'select-rating'}
                                 name={'rating'}
                                 starCount={3}
                                 value={rating}
                                 // starColor='#FFFF00'
                                 starColor='#00BFA5'
                                 onStarClick={this.onStarClick.bind(this)} />
            </div>
        )
    }
}

class DeliveryTimeSlider extends React.Component {
    constructor() {
        super();

        this.state = {
            sliderValue: 20
        }
    }

    handleSliderChange = (value) => {
        this.setState({sliderValue: value});
    };

    render() {
        const selectedColor = '#00BFA5';
        const trackStyle = { backgroundColor: selectedColor };
        const handleStyle = { borderColor: selectedColor };
        const activeDotStyle = { borderColor: selectedColor};
        const railStyle = { backgroundColor: 'white' };

        return (
            <div className='select-max-delivery'>
                <div className='filter-title'>Maximum delivery time: {this.state.sliderValue} min.</div>
                <Slider
                        min={0}
                        max={120}
                        defaultValue={20}
                        handleStyle={handleStyle}
                        onChange={this.handleSliderChange}
                        activeDotStyle={activeDotStyle}
                        trackStyle={trackStyle}
                        railStyle={railStyle} />
            </div>
        );
    }
}

class Filter10Bis extends React.Component {
    constructor() {
        super();

        this.state = {
            checked: false
        }
    }

    handleCheckChange = () => {
        this.setState({checked: !this.state.checked});
    };

    render() {
        const styles = {
            block: {
                maxWidth: 250,
            },
            checkbox: {
                marginTop: 40,
            }};
        return (
            <MuiThemeProvider>
                <Checkbox label="Only 10Bis?"
                          checked={this.state.checked}
                          labelStyle={{color: 'black', fontFamily: 'sans-serif', marginLeft: -13}}
                          iconStyle={{fill: this.state.checked ? '#00BFA5' : 'black'}}
                          onCheck={this.handleCheckChange.bind(this)}
                          style={styles.checkbox}/>
            </MuiThemeProvider>
        );
    }
}
