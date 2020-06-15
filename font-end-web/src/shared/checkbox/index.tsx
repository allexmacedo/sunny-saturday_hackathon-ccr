import React from "react";
import { withStyles, makeStyles } from "@material-ui/core/styles";
import FormControlLabel from "@material-ui/core/FormControlLabel";
import Checkbox from "@material-ui/core/Checkbox";
import { Colors } from "../../assets/colors";

const CustomCheckbox = withStyles({
  root: {
    width: 0,
    height: 0,
    borderRadius: 4,
    border: "1px solid #ced4da",
    color: Colors.LIGHT_GREY,
    "&$checked": {
      color: Colors.LIGHT_GREEN,
    },
  },
  checked: {},
})((props) => <Checkbox color="default" {...props} />);

const useStyles = makeStyles((theme) => ({
  label: {
    marginLeft: 5,
  },
}));

const CheckboxField = (props: any) => {
  const classes = useStyles();
  return (
    <FormControlLabel
      classes={{ label: classes.label }}
      label={props.label}
      control={<CustomCheckbox {...props} />}
    />
  );
};

export default CheckboxField;
