import React from 'react';
import {GoogleMap, Marker, withGoogleMap, withScriptjs} from "react-google-maps";

export const RestaurantsMap = withScriptjs(withGoogleMap((props) =>
    <GoogleMap
        defaultZoom={14}
        center={props.center}
        defaultCenter={{lat: 40.732013, lng: -73.996155}} >

        {props.restaurants.map(restaurant => (
            <Marker key={restaurant.id}
                    position={{lat: restaurant.latitude, lng: restaurant.longitude}}/>
        ))}
    </GoogleMap>
));
