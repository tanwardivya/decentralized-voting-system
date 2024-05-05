import * as React from "react";
import { Button, Typography } from "@mui/material";
import CoverLayout from "@/shared/CoverLayout";
import { useNavigate } from "react-router-dom";

const backgroundImage =
  "https://source.unsplash.com/Q1p7bh3SHj8";

export default function LandingPage() {
  const navigate = useNavigate();

  const handleClick = () => {
    console.log("home button clicked");
    navigate("/home");
    window.location.reload();
  };

  return (
    <CoverLayout
      sxBackground={{
        backgroundImage: `url(${backgroundImage})`,
        backgroundColor: "#7fc7d9", // Average color of the background image.
        backgroundPosition: "center",
      }}
    >
      {/* Increase the network loading priority of the background image. */}
      <img
        style={{ display: "none" }}
        src={backgroundImage}
        alt="increase priority"
      />
      <Typography color="inherit" align="center" variant="h2" marked="center">
        Voting System
      </Typography>
      <Typography
        color="inherit"
        align="center"
        variant="h5"
        sx={{ mb: 4, mt: { sx: 4, sm: 10 } }}
      >
         Ethereum blockchain based decentralized voting system.
      </Typography>
      <Button
        color="primary"
        variant="contained"
        size="large"
        sx={{ minWidth: 200 }}
        onClick={handleClick}
      >
        Welcome to the Voting System
      </Button>
    </CoverLayout>
  );
}
