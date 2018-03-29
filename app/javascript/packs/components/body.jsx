import React from 'react';
import {Row} from "react-bootstrap";
import Col from "react-bootstrap/es/Col";
import {RestaurantsList} from "./restaurants_list";

export default function Body(props) {
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