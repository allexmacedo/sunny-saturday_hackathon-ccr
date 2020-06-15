import React, { useState } from "react";
import { useHistory, Link } from "react-router-dom";
import { makeStyles } from "@material-ui/core/styles";
import { Colors } from "../../assets/colors";
import { Typography, Grid, Button, Dialog } from "@material-ui/core";
import CheckCircle from "../../assets/icons/check.svg";
import TextField from "../../shared/textField";
import SelectInput from "../../shared/select";
import CheckboxField from "../../shared/checkbox";
import { useFormik } from "formik";
import Request from "../../services";

const useStyles = makeStyles((theme) => ({
  row: {
    display: "flex",
  },
  dialogTitle: {
    fontSize: 24,
    fontWeight: "bold",
    color: Colors.WHITE,
  },
  backdrop: {
    backgroundColor: "rgba(0, 0, 0, 0.8)",
  },
  paper: {
    display: "flex",
    flexDirection: "column",
    background: "rgba(0,0,0,0)",
    boxShadow: "none",
  },
  page: {
    marginTop: 32,
  },
  container: {
    marginTop: 32,
    display: "flex",
    height: "100%",
    flexGrow: 1,
    alignItems: "center",
    justifyContent: "center",
  },
  form: {
    display: "flex",
    flexDirection: "column",
  },
  card: {
    background: Colors.WHITE,
    border: `3px solid ${Colors.GREY}`,
    minWidth: 740,
    borderRadius: 5,
    padding: theme.spacing(4),
    paddingTop: theme.spacing(8),
  },
  title: {
    color: Colors.DARK_GREY_MEDIUM,
    fontWeight: "bold",
    fontSize: 34,
    textAlign: "center",
  },
  subtitle: {
    color: Colors.DARK_GREY_MEDIUM,
    fontSize: 18,
    textAlign: "center",
  },
  toolbar: {
    display: "flex",
    width: "100%",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: theme.spacing(1),
  },
  toolbarTitle: {
    fontSize: 24,
    fontWeight: "bold",
  },
  toolbarAction: {
    color: Colors.DARK_GREY_MEDIUM,
    cursor: "pointer",
    "&:hover": {
      color: Colors.LIGHT_GREEN,
    },
  },
  formRow: {
    display: "flex",
    width: "100%",
    "& > div": {
      flexGrow: 1,
    },
  },
  options: {
    paddingLeft: 12,
  },
  label: {
    fontWeight: "bold",
    textTransform: "none",
  },
  contained: {
    background: Colors.LIGHT_GREEN,
    maxWidth: 306,
    "&:hover": {
      background: Colors.GREEN,
    },
  },
  submit: {
    marginTop: theme.spacing(4),
    marginBottom: theme.spacing(4),
    color: Colors.WHITE,
  },
}));

const AddCompany = () => {
  const [image, setImage] = useState<any>("");
  const [openDialog, toggleDialog] = useState<boolean>(false);
  const [prt_services, setServices] = useState<any>(new Set());
  const classes = useStyles();
  const history = useHistory();

  const initialValues: any = {
    prt_logo: "",
    prt_image: "",
    prt_name: "",
    prt_description: "",
    cep: "",
    address: "",
    city: "",
    state: "",
    prt_attendence: "",
    prt_phone: "",
    whatsapp: "",
  };

  const validate = (values: any) => {
    let errors: any = {};

    return errors;
  };

  const setService = (service: string) => {
    const newSet = new Set(prt_services);
    if (prt_services.has(service)) newSet.delete(service);
    else newSet.add(service);

    setServices(newSet);
  };

  const onSubmit = (values: any) => {
    //toggleDialog(true);
    const services: any = [];
    prt_services.forEach((service: any) => services.push(service));

    const partner = {
      prt_attendence: values.prt_attendence,
      prt_description: values.prt_description,
      prt_image: values.prt_image,
      prt_logo: values.prt_logo,
      prt_name: values.prt_name,
      prt_phone: values.prt_phone,
      prt_address: `${values.address}, ${values.city} - ${values.state}, ${values.cep}`,
      prt_services: services,
    };

    Request.insertPartner(partner).then((response) =>
      history.push("/empresa-lista")
    );
  };

  const formik = useFormik({
    initialValues,
    validate,
    onSubmit,
  });

  return (
    <>
      <div className={classes.page}>
        <Typography className={classes.title}>Incluir empresa</Typography>
        <Typography className={classes.subtitle}>
          Informe os dados de sua empresa
        </Typography>
        <div className={classes.container}>
          <div className={classes.card}>
            <form className={classes.form} onSubmit={formik.handleSubmit}>
              <TextField
                name="URL Logotipo *"
                id="prt_logo"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.prt_logo}
              />
              <TextField
                name="URL imagem da empresa *"
                id="prt_image"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.prt_image}
              />
              <TextField
                id="prt_name"
                name="Nome da empresa *"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.prt_name}
              />
              <TextField
                id="prt_description"
                name="Descrição *"
                multiline
                type="text"
                onChange={formik.handleChange}
                value={formik.values.prt_description}
              />
              <div className={classes.toolbar}>
                <Typography className={classes.toolbarTitle}>
                  Endereço
                </Typography>
                <Typography className={classes.toolbarAction}>
                  Ajuste o endereço no mapa
                </Typography>
              </div>
              <iframe
                height="342"
                src="https://www.google.com/maps/embed/v1/undefined?origin=...&q=...&destination=...&center=...&zoom=...&key=..."
              />
              <TextField
                id="cep"
                name="CEP *"
                type="text"
                style={{ maxWidth: 211 }}
                onChange={formik.handleChange}
                value={formik.values.cep}
              />
              <TextField
                id="address"
                name="Endereço *"
                type="text"
                onChange={formik.handleChange}
                value={formik.values.address}
              />
              <div className={classes.row}>
                <TextField
                  id="city"
                  name="Cidade *"
                  type="text"
                  onChange={formik.handleChange}
                  value={formik.values.city}
                />
                <div style={{ width: 16 }} />
                <TextField
                  id="state"
                  name="Estado *"
                  type="text"
                  onChange={formik.handleChange}
                  value={formik.values.state}
                />
              </div>
              <div className={classes.toolbar}>
                <Typography className={classes.toolbarTitle}>
                  Horário de atendimento
                </Typography>
                <Typography className={classes.toolbarAction}></Typography>
              </div>
              <SelectInput
                id="prt_attendence"
                name="Selecione um formato *"
                onChange={(event: any) =>
                  formik.setFieldValue("prt_attendence", event.target.value)
                }
                style={{ maxWidth: 211 }}
                value={formik.values.prt_attendence}
                options={[
                  "Todos os dias",
                  "Segunda a Sexta",
                  "Segunda a Sábado",
                ]}
              />
              <div className={classes.row}>
                <TextField
                  id="prt_phone"
                  name="Telefone *"
                  type="tel"
                  onChange={formik.handleChange}
                  value={formik.values.prt_phone}
                />
                <div style={{ width: 16 }} />
                <TextField
                  id="whatsapp"
                  name="WhatsApp *"
                  type="tel"
                  onChange={formik.handleChange}
                  value={formik.values.whatsapp}
                />
              </div>

              <div className={classes.toolbar}>
                <Typography className={classes.toolbarTitle}>
                  Áreas de atendimento
                </Typography>
                <Typography className={classes.toolbarAction}></Typography>
              </div>
              <div className={classes.options}>
                <Grid container>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Alimentação")}
                      label="Alimentação"
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Área de descanso")}
                      label="Área de descanso"
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Borracharia")}
                      label="Borracharia"
                    />
                  </Grid>
                </Grid>
                <Grid container>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Hotéis")}
                      label="Hotéis"
                    />
                  </Grid>

                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Mecânica")}
                      label="Mecânica"
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Pontos de Apoio")}
                      label="Pontos de Apoio"
                    />
                  </Grid>
                </Grid>
                <Grid container>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Posto de combustível")}
                      label="Posto de combustível"
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Postos de serviços")}
                      label="Postos de serviços"
                    />
                  </Grid>
                  <Grid item xs={4}>
                    <CheckboxField
                      onChange={() => setService("Saúde")}
                      label="Saúde"
                    />
                  </Grid>
                </Grid>
                <Grid container>
                  <Grid>
                    <CheckboxField
                      onChange={() => setService("Socorro")}
                      label="Socorro"
                    />
                  </Grid>
                </Grid>
              </div>
              <Button
                variant="contained"
                className={classes.submit}
                classes={{ contained: classes.contained, label: classes.label }}
                type="submit"
              >
                Cadastrar empresa
              </Button>
            </form>
          </div>
        </div>
      </div>
      <Dialog
        open={openDialog}
        classes={{ paper: classes.paper, root: classes.backdrop }}
      >
        <img src={CheckCircle} />
        <Typography className={classes.dialogTitle}>
          Cadastro da empresa concluído!
        </Typography>
      </Dialog>
    </>
  );
};

export default AddCompany;
