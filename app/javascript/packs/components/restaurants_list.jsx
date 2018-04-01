import React from 'react';
import {Col, Image, ListGroup, ListGroupItem, Row} from "react-bootstrap";
import StarRatingComponent from 'react-star-rating-component';

export default function RestaurantsList(props) {

    const restaurantsList = props.restaurants.map(restaurant => {
        return (<RestaurantItem key={restaurant.id} restaurant={restaurant}/>)
    });

    return (
        <ListGroup componentClass='ul'>
            {restaurantsList}
        </ListGroup>
    )
}

function RestaurantItem(props) {
    const tenbisImg = props.restaurant.accepts_10bis ?
        <Image className='tenbis-img' src='/images/logo10Bis.png' rounded/> : '';

        const reviewsText = props.restaurant.reviews_count == 1 ? 'review' : 'reviews';

    return (
        <ListGroupItem>
            <div className='restaurants-list-item'>
                <Row>
                    <Col md={2}>
                        <div className={'cuisine-icon'}>{props.restaurant.cuisine.icon}</div>
                    </Col>
                    <Col md={7} className='restaurant-title'>
                        <div className='restaurant-name'>{props.restaurant.name}</div>
                        <div className='restaurant-address'>{props.restaurant.address}</div>
                    </Col>
                    <Col md={3} className='logo10bis'>
                        {tenbisImg}
                    </Col>
                </Row>
                <Row>
                    <Col md={2}/>
                    <Col md={7}>
                        <Row>
                            <StarRatingComponent className={'restaurant-item-rating'}
                                                 name={'rating'}
                                                 starCount={3}
                                                 emptyStarColor={'#dcdcdc'}
                                                 value={props.restaurant.rating}
                                                 editing={false}/>
                            <div className='restaurant-small-title'>({props.restaurant.review_ids.length} {reviewsText})</div>
                        </Row>
                    </Col>
                    <Col md={3}>
                        <Row>
                            <Image className='delivery-img' src='/images/delivery.png'/>
                            <div className='restaurant-small-title'>{props.restaurant.max_delivery_time_minutes} min.</div>
                        </Row>
                    </Col>
                </Row>
            </div>
        </ListGroupItem>
    )

}