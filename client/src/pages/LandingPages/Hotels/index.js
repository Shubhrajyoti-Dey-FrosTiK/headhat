// @mui material components
import Grid from "@mui/material/Grid";

// Material Kit 2 React components
import MKBox from "components/MKBox";
// import MKInput from "components/MKInput";
// import MKButton from "components/MKButton";
// import MKTypography from "components/MKTypography";

// Material Kit 2 React examples
import DefaultNavbar from "examples/Navbars/DefaultNavbar";
import DefaultFooter from "examples/Footers/DefaultFooter";

// Routes
import routes from "routes";
import footerRoutes from "footer.routes";

import * as React from "react";
import HotelCard from "./HotelCard";

const hotels = [
  {
    location: "New York",
    type: "Hotel",
    hotelId: "0",
    rooms: [
      {
        totalRooms: 10,
        roomsBooked: 5,
        roomType: "Suite",
        roomId: "1-suite",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
      {
        totalRooms: 7,
        roomsBooked: 2,
        roomType: "Deluxe",
        roomId: "1-deluxe",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
    ],
    reviews: ["Awesome hotel", "Great location", "Good food"],
  },
  {
    location: "New York",
    type: "Hotel",
    hotelId: "1",
    rooms: [
      {
        totalRooms: 10,
        roomsBooked: 5,
        roomType: "Suite",
        roomId: "1-suite",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
      {
        totalRooms: 7,
        roomsBooked: 2,
        roomType: "Deluxe",
        roomId: "1-deluxe",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
    ],
    reviews: ["Awesome hotel", "Great location", "Good food"],
  },
  {
    location: "New York",
    type: "Hotel",
    hotelId: "2",
    rooms: [
      {
        totalRooms: 10,
        roomsBooked: 5,
        roomType: "Suite",
        roomId: "1-suite",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
      {
        totalRooms: 7,
        roomsBooked: 2,
        roomType: "Deluxe",
        roomId: "1-deluxe",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "1",
      },
    ],
    reviews: ["Awesome hotel", "Great location", "Good food"],
  },
  {
    location: "California",
    type: "BNB",
    hotelId: "3",
    rooms: [
      {
        totalRooms: 8,
        roomsBooked: 4,
        roomType: "Suite",
        roomId: "2-suite",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "2",
      },
      {
        totalRooms: 7,
        roomsBooked: 5,
        roomType: "Deluxe",
        roomId: "2-deluxe",
        roomPhotos: ["img1", "img2"],
        facilities: ["wifi", "tv", "ac"],
        hotelId: "2",
      },
    ],
    reviews: ["Awesome hotel", "Great location", "Good food"],
  },
];

const Hotels = () => (
  <>
    <MKBox position="fixed" top="0.5rem" width="100%" zIndex={10}>
      <DefaultNavbar
        routes={routes}
        action={{
          type: "external",
          route: "https://www.creative-tim.com/product/material-kit-react",
          label: "Sign Up",
          color: "info",
        }}
      />
    </MKBox>
    <Grid container spacing={4} alignItems="center" py={16} px={4}>
      {hotels.map(({ hotelId, location, type, rooms, reviews }) => (
        <HotelCard
          id={hotelId}
          location={location}
          type={type}
          rooms={rooms}
          reviews={reviews}
        />
      ))}
    </Grid>
    <MKBox pt={6} px={1} mt={6}>
      <DefaultFooter content={footerRoutes} />
    </MKBox>
  </>
);

export default Hotels;
