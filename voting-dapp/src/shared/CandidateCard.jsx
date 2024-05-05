import { Grid, Typography } from "@mui/material";
import image from "@/assets/image.png";
import PropTypes from "prop-types";
import { useTheme } from "@mui/material/styles";

const CandidateCard = ({ id, name, voteCount }) => {
  const voteCountNum = Number(voteCount);
  const theme = useTheme();

  return (
    <Grid
      container
      sx={{
        maxWidth: 345,
        minWidth: 300,
        border: "2px solid #673AB7",
        borderRadius: 1,
        boxShadow: 3,
        padding: "16px",
        backgroundColor: theme.palette.primary.light, // Custom color (pale pinkish tan)
        color: theme.palette.primary.contrastText,
      }}
    >
      <Grid item xs={12} sx={{ textAlign: "center", p: 2 }}>
        <Typography variant="subtitle1">{name}</Typography>
      </Grid>
      <Grid
        item
        xs={7}
        sx={{
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          marginX: 8,
        }}
      >
        <img
          src={image}
          alt="green iguana"
          style={{ width: "100%", height: 140 }}
        />
      </Grid>
      {voteCountNum != null && (
        <Grid item xs={12} sx={{ textAlign: "center", p: 2 }}>
          <Typography>
            <strong>{voteCountNum}</strong> votes
          </Typography>
        </Grid>
      )}
    </Grid>
  );
};

CandidateCard.propTypes = {
  id: PropTypes.number.isRequired,
  name: PropTypes.string.isRequired,
  voteCount: PropTypes.any,
};

export default CandidateCard;
