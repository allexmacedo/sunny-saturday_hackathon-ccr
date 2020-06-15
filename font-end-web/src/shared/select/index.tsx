import React from "react";
import { makeStyles, useTheme } from "@material-ui/core/styles";
import FormControl from "@material-ui/core/FormControl";
import Select from "@material-ui/core/Select";
import { Colors } from "../../assets/colors";
import { Typography, MenuItem } from "@material-ui/core";
import TextField from "../textField";

const SelectInput = (props: any) => {
  return (
    <Select input={<TextField />} {...props}>
      <option aria-label="" value="" />
      {props.options.map((name: string) => (
        <MenuItem value={name}>{name}</MenuItem>
      ))}
    </Select>
  );
};

export default SelectInput;
