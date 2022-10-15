import * as React from "react";
import Grid from "@mui/material/Grid";
import Card from "@mui/material/Card";
import CardContent from "@mui/material/CardContent";
import CardMedia from "@mui/material/CardMedia";
import Typography from "@mui/material/Typography";
import { CardActionArea } from "@mui/material";

import img1 from "assets/images/hotels/img1.jpg";

const HotelCard = ({ location, id }) => (
  <Grid item xs={12} lg={4} sm={6} zIndex={-1}>
    <Card sx={{ maxWidth: 345 }}>
      <CardActionArea>
        <CardMedia
          component="img"
          height="200"
          image={img1}
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
  </Grid>
);

export default HotelCard;
