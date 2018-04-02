import React from 'react';
import {GoogleMap, Marker, withGoogleMap, withScriptjs} from "react-google-maps";
import {InfoBox} from "react-google-maps/lib/components/addons/InfoBox";
import {InfoWindow} from "react-google-maps/lib/components/InfoWindow";
import {Col, Image, Row} from "react-bootstrap";

export const RestaurantsMap = withScriptjs(withGoogleMap((props) =>
    <GoogleMap
        defaultZoom={14}
        center={props.center}
        defaultCenter={{lat: 40.732013, lng: -73.996155}} >
        {props.selectedRestaurant ? <RestaurantMarker restaurant={props.selectedRestaurant} showInfo={true} /> :
            props.restaurants.map(restaurant => (
                <RestaurantMarker key={restaurant.id} restaurant={restaurant} showInfo={false} />
            ))}
    </GoogleMap>
));

function RestaurantMarker(props) {
    return (
        <Marker key={props.restaurant.id}
                position={{lat: props.restaurant.latitude, lng: props.restaurant.longitude}}
                clickable={true}>
            {props.showInfo &&
            <InfoWindow>
                <Row className={'info-window-details'}>
                    <Col className={'info-window-img-container'} md={4}>
                        {props.restaurant.thumb_url ?
                            <Image className={'info-window-img'} src={props.restaurant.thumb_url} rounded/> :
                            <div className={'info-window-icon'}>{props.restaurant.cuisine.icon}</div>
                        }
                    </Col>
                    <Col md={8}>
                        <div className={'info-window-title'}>
                            {props.restaurant.name}
                        </div>
                    </Col>
                </Row>
            </InfoWindow> }
        </Marker>
    )
}
