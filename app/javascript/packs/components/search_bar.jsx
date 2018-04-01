import React from "react";
import StarRatingComponent from 'react-star-rating-component';
import Slider from 'rc-slider';
import {Row, Col} from 'react-bootstrap'
import {MuiThemeProvider, Checkbox} from 'material-ui';
import Select from 'react-select';

export default class SearchBar extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            cuisineIDs: props.cuisineIDs,
            maxDeliveryTime: props.maxDeliveryTime,
            rating: props.rating,
            only10bis: props.only10bis,
        }
    }

    render() {
        return (
            <Row className='search-bar'>
                <Col md={2} />
                <Col md={3}>
                    <SelectCuisines cuisines={this.props.cuisines}
                                    onFilterChange={this.props.onFilterChange}
                                    selectedValue={this.state.cuisineID} />
                </Col>
                <Col md={3}>
                    <DeliveryTimeSlider onFilterChange={this.props.onFilterChange}
                                        selectedValue={this.state.maxDeliveryTime} />
                </Col>
                <Col md={4}>
                    <Row>
                        <Col md={4} >
                            <RatingFilter onFilterChange={this.props.onFilterChange}
                                          selectedValue={this.state.rating} />

                        </Col>
                        <Col md={8} >
                        <Filter10Bis onFilterChange={this.props.onFilterChange}
                                     selectedValue={this.state.only10bis} />
                        </Col>
                    </Row>
                </Col>
            </Row>
        );
    }
}

class SelectCuisines extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            value: []
        };
    }

    handleSelectChange (value) {
        this.setState({ value });
        this.props.onFilterChange({selectedCuisines: value});
    }

    render() {
        const options = this.props.cuisines.map(cuisine => {
            return {label: cuisine.name, value: cuisine.id};
        });
        return (
            <Select className={'filter-cuisine'}
                closeOnSelect={false}
                multi
                onChange={this.handleSelectChange.bind(this)}
                options={options}
                placeholder="Select cuisines"
                removeSelected={true}
                value={this.state.value}
            />
        )

    }
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
        this.props.onFilterChange({rating: nextValue});

    }

    render() {
        const { rating } = this.state;

        return (
            <div className='filter-min-rating'>
                <div className='filter-title'>Minimal rating</div>
                <StarRatingComponent className={'select-rating'}
                                     name={'rating'}
                                     starCount={3}
                                     value={rating}
                                     starColor='#FFFF00'
                                     onStarClick={this.onStarClick.bind(this)} />
            </div>
        )
    }
}

class DeliveryTimeSlider extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            sliderValue: 120
        }
    }

    handleSliderChange = (value) => {
        this.setState({sliderValue: value});
    };

    handleAfterChange = () => {
        this.props.onFilterChange({maxDeliveryTime: this.state.sliderValue});
    };

    render() {
        const selectedColor = '#00BFA5';
        const trackStyle = { backgroundColor: selectedColor };
        const handleStyle = { borderColor: selectedColor };
        const activeDotStyle = { borderColor: selectedColor};
        const railStyle = { backgroundColor: 'white' };

        return (
            <div className='select-max-delivery'>
                <div className='filter-title'>Max delivery time: {this.state.sliderValue} min.</div>
                <Slider
                    min={0}
                    max={120}
                    defaultValue={120}
                    handleStyle={handleStyle}
                    onChange={this.handleSliderChange}
                    onAfterChange={this.handleAfterChange}
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
        const checked = !this.state.checked;
        this.setState({checked: checked});
        this.props.onFilterChange({only10Bis: checked});
    };

    render() {
        const styles = {
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
