import { Grid, Typography } from "@mui/material";
import image from "@/assets/image.png";

const CandidateCard = ({ name, voteCount }) => {
  <Grid
    container
    sx={{
      maxWidth: 345,
      minWidth: 300,
      border: 1,
      borderRadius: 1,
      boxShadow: 3,
    }}
  >
    <Grid item xs={12} sx={{ textAlign: "center", p: 2 }}>
      <Typography variant="subtitle1">{name}</Typography>
    </Grid>
    <Grid item xs={12}>
      <img
        src={image}
        alt="green iguana"
        style={{ width: "100%", height: 140 }}
      />
    </Grid>
    {voteCount && (
      <Grid item xs={12} sx={{ textAlign: "center", p: 2 }}>
        <Typography>
          <strong>{voteCount}</strong> votes
        </Typography>
      </Grid>
    )}
  </Grid>;
};

export default CandidateCard;
