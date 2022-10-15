

// @mui material components
import Grid from "@mui/material/Grid";

// Material Kit 2 React components
import MKBox from "components/MKBox";
import MKInput from "components/MKInput";
import MKButton from "components/MKButton";
import MKTypography from "components/MKTypography";
import { useParams } from "react-router-dom";

// Material Kit 2 React examples
import DefaultNavbar from "examples/Navbars/DefaultNavbar";
import DefaultFooter from "examples/Footers/DefaultFooter";

// Routes
import routes from "routes";
import footerRoutes from "footer.routes";

const hotels = {
  0: {
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
  1: {
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
  2: {
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
  3: {
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
};

const HotelDetails = () => {
  const { id } = useParams();
  console.log("HotelDetails", id);
  return (
    <>
      <MKBox position="fixed" top="0.5rem" width="100%">
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
      <MKBox pt={16}>
        <MKTypography variant="h1" align="center">
          {hotels[id].location}
        </MKTypography>
      </MKBox>
      <MKBox pt={6} px={1} mt={6}>
        <DefaultFooter content={footerRoutes} />
      </MKBox>
    </>
  );
};

export default HotelDetails;
