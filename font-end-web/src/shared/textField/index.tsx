import React from "react";
import { fade, withStyles, makeStyles } from "@material-ui/core/styles";
import InputBase from "@material-ui/core/InputBase";
import FormControl from "@material-ui/core/FormControl";
import { Colors } from "../../assets/colors";
import { Typography } from "@material-ui/core";

const BootstrapInput = withStyles((theme) => ({
  input: {
    borderRadius: 4,
    backgroundColor: Colors.LIGHT_GREY,
    border: "1px solid #ced4da",
    fontSize: 16,
    mingWidth: "100%",
    padding: "10px 12px",
    transition: theme.transitions.create(["border-color", "box-shadow"]),
    fontFamily: "Roboto",
    "&:focus": {
      boxShadow: `${fade(Colors.GREEN, 0.25)} 0 0 0 0.2rem`,
    },
  },
}))(InputBase);

const useStyles = makeStyles((theme) => ({
  messageError: {
    color: theme.palette.error.main,
    minHeight: 18,
    fontSize: 12,
  },
  formControl: {
    marginTop: theme.spacing(1),
    marginBottom: theme.spacing(1),
    flexGrow: 1,
  },
  label: {
    color: Colors.DARK_GREY_MEDIUM,
    fontSize: 12,
    marginBottom: 5,
  },
}));

const TextField = ({ name, errorMessage, ...rest }: any) => {
  const classes = useStyles();

  return (
    <FormControl className={classes.formControl}>
      <Typography className={classes.label}>{name}</Typography>
      <BootstrapInput {...rest} />
      <Typography className={classes.messageError}>{errorMessage}</Typography>
    </FormControl>
  );
};

export default TextField;
