import * as React from "react";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Typography from "@mui/material/Typography";
import { CardActionArea } from "@mui/material";
import { Link } from "react-router-dom";

import HotelInfo from "../HotelDetails";
import img1 from "assets/images/hotels/img1.jpg";
import img2 from "assets/images/hotels/img3.jpg";

const images = [img1, img2, img1, img2];

const HotelCard = ({ location, id }) => {
  return (
    <Grid
      item
      xs={12}
      lg={4}
      sm={6}
      //   zIndex={-1}
      display="flex"
      justifyContent={"center"}
    >
      <Link to={`/hotel/${id}`}>
        <Card>
          <CardActionArea>
            <CardMedia
              component="img"
              sx={{ width: "90%", maxHeight: "400px", marginX: "auto" }}
              image={images[id]}
              alt="Hotel Image"
            />
            <CardContent>
              <Grid container>
                <Grid item>
                  <Typography gutterBottom variant="h5" component="div">
                    {location}
                  </Typography>
                </Grid>
              </Grid>
              <Typography variant="body2" color="text.secondary">
                Lorem ipsum
              </Typography>
              <Typography gutterBottom variant="h6" component="div" mt={2}>
                $100
              </Typography>
            </CardContent>
          </CardActionArea>
        </Card>
      </Link>
    </Grid>
  );
};

export default HotelCard;
