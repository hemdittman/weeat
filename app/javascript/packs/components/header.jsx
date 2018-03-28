import React from 'react';
import {Row, FormGroup, FormControl, Col, ControlLabel, Glyphicon} from 'react-bootstrap'
import {FloatingActionButton, MenuItem, MuiThemeProvider, SelectField} from 'material-ui';
import ContentAdd from 'material-ui/svg-icons/content/add';

function Header() {
    return (
        <div className='header'>
            <Title />
            <RestaurantSearch />
            <SearchBar />
        </div>
    );
}

function Title() {
    return (
        <Row>
            <div className='title'>we eat</div>
        </Row>
    )
}

function RestaurantSearch() {
    return(
        <FormGroup>
            <FormControl type='text' placeholder='Search Restaurant...' />
            {/*<Glyphicon glyph="star" />*/}
        </FormGroup>
    )
}

function SearchBar() {
    return (
        <Row className='search-bar'>
            <Col md='4'>
                <SelectFieldMultiSelect></SelectFieldMultiSelect>
            </Col>
            <Col md='4'>
                {/*<SearchSelect controlId='searchRating' options={} />*/}
            </Col>
            <Col md='4'>HELLO</Col>
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

class SelectFieldMultiSelect extends React.Component {
    // state = {
    //     values: [],
    // };
    //
    // handleChange = (event, index, values) => this.setState({values});
    //
    // menuItems(values) {
    //     const names = [
    //         'Oliver Hansen',
    //         'Van Henry',
    //         'April Tucker',
    //         'Ralph Hubbard',
    //         'Omar Alexander',
    //         'Carlos Abbott',
    //         'Miriam Wagner',
    //         'Bradley Wilkerson',
    //         'Virginia Andrews',
    //         'Kelly Snyder',
    //     ];
    //
    //     return names.map((name) => (
    //         <MenuItem
    //             key={name}
    //             insetChildren={true}
    //             checked={values && values.indexOf(name) > -1}
    //             value={name}
    //             primaryText={name}
    //         />
    //     ));
    // }
    //
    // render() {
    //     const {values} = this.state;
    //     return (
    //         <MuiThemeProvider>
    //         <SelectField
    //             fullWidth={true}
    //             multiple={true}
    //             hintStyle={{fontFamily: 'LyonText-Bold', color: 'black'}}
    //             hintText="Select a cuisine"
    //             value={values}
    //             onChange={this.handleChange}
    //         >
    //             {this.menuItems(values)}
    //         </SelectField>
    //         </MuiThemeProvider>
    //     );
    // }
    render() {
        return (<FormGroup controlId="formControlsSelectMultiple">
            <ControlLabel>Multiple select</ControlLabel>
            <FormControl componentClass="select">
                <option value="select">select (multiple)</option>
                <option value="select1">select</option>
            </FormControl>
        </FormGroup>)
    }
}

export default Header;