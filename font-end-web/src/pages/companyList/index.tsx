import React, { useState, useEffect } from "react";
import { makeStyles, Typography } from "@material-ui/core";
import StarIcon from "../../assets/icons/star.svg";
import { Colors } from "../../assets/colors";
import Request from "../../services";

const useStyles = makeStyles((theme) => ({
  page: {
    marginTop: theme.spacing(6),
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
  },
  list: { marginTop: theme.spacing(2) },
  item: {
    padding: `${theme.spacing(1)}px ${theme.spacing(2)}px`,
    display: "flex",
    alignItems: "center",
    flexDirection: "row",
    background: Colors.WHITE,
    flexGrow: 1,
    maxHeight: 55,
    border: `3px solid ${Colors.GREY}`,
    borderRadius: 5,
  },
  itemName: {
    fontSize: 16,
    fontWeight: "bold",
    flexGrow: 1,
  },
  rate: {
    display: "flex",
    alignItems: "center",
    flexGrow: 0.3,
    "& > p": {
      margin: 0,
      fontFamily: "Roboto",
      color: Colors.DARK_GREY_MEDIUM,
      marginLeft: 5,
    },
  },
  itemAction: {
    flexGrow: 0.1,
    color: Colors.DARK_GREY_MEDIUM,
    cursor: "pointer",
    "&:hover": {
      color: Colors.GREEN,
    },
  },
}));

const CompanyList = () => {
  const [partners, setPartners] = useState<any>([]);
  const classes = useStyles();

  useEffect(() => {
    Request.Partners().then((response: any) => setPartners(response.data));
  }, []);
  return (
    <div className={classes.page}>
      <Typography className={classes.title}>Empresas</Typography>
      <div className={classes.list}>
        {partners.map((partner: any) => (
          <div className={classes.item}>
            <Typography className={classes.itemName}>
              {partner.prt_name}
            </Typography>
            <div className={classes.rate}>
              <img src={StarIcon} />
              <p>
                <b>200</b>
              </p>
              <p>avaliações</p>
            </div>
            <Typography className={classes.itemAction}>
              <b>Editar</b>
            </Typography>
            <Typography className={classes.itemAction}>Excluir</Typography>
          </div>
        ))}
      </div>
    </div>
  );
};

export default CompanyList;
