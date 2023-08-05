import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../../models/oferta_model.dart';
import '../../../models/usuario_model.dart';
import '../../../providers/demandas_provider.dart';
import '../../../providers/drawer_provider.dart';
import '../../../providers/login_provider.dart';
import '../../../providers/miembros_provider.dart';
import '../../../providers/ofertas_provider.dart';
import '../../../utils/colores.dart';
import '../../../widgets/alert_personalizado.dart';
import '../../../widgets/widgets_personalizados.dart';

class TransferirHorasPage extends StatefulWidget {
  static const PAGE_ROUTE = "transferirhoraspage";

  @override
  _TransferirHorasPageState createState() => _TransferirHorasPageState();
}

class _TransferirHorasPageState extends State<TransferirHorasPage> {
  late LoginProvider _loginProvider;
  late DrawerProvider _drawerProvider;
  late OfertasProvider _ofertasProvider;
  late DemandasProvider _demandasProvider;
  late MiembrosProvider _miembrosProvider;
  TextEditingController _txtControllerComentario = TextEditingController();
  int horas = 1;
  double valoracion = 5.0;
  UsuarioModel _usuarioLogin = UsuarioModel();
  OfertaModel _ofertaSeleccionada = OfertaModel();
  String _lugar = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginProvider = Provider.of<LoginProvider>(context, listen: false);
    _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
    _usuarioLogin = _loginProvider.usuario!;
    //Recibimos parametros de donde se va transferir las horas
    _ofertaSeleccionada = _ofertasProvider.ofertaSeleccionado;
    _txtControllerComentario.text = _ofertaSeleccionada.descripcionActividad!;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      // final Object? args = ModalRoute.of(context)?.settings.arguments;
      // if (args != null) {
      //   // _ofertaModel = args["oferta"];
      //   print("INIT CASE  >> $args" );
      //   args['idV']
      //   _lugar = args;
      // } else {
      //   print("TRANSFERIR >>  ");
      // }
    });
  }

  void changeHoras(int t, int disponibles) {
    int horasMin = 1;
    if (t == -1) {
      if (horas == horasMin) {
        WidgetsPersonalizados.mostrarToast(
            mensaje: "No se puede transferir menos de $horasMin hora");
      } else {
        setState(() {
          horas--;
        });
      }
    } else {
      if (horas < disponibles) {
        setState(() {
          horas++;
        });
      } else if (horas == disponibles || horas > disponibles) {
        WidgetsPersonalizados.mostrarToast(
            mensaje: "No se puede tranferir un tiempo mayor al que tiene disponible");
      }
    }
  }

  Widget cantidadHoras(BuildContext context, int horasdisponibles) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: RichText(
                text: TextSpan(
                  text: "Horas disponibles: ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "$horasdisponibles",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: " Horas",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: ShapeDecoration(
                  // color: saldo > salto ? Colores.COLOR_ACTION : Colors.grey,
                  color: Colors.grey,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.white,
                  onPressed: () {
                    changeHoras(-1, horasdisponibles);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  "$horas",
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                decoration: ShapeDecoration(
                  // color: saldo < formaPago.saldo ? Colores.COLOR_ACTION : Colors.grey,
                  color: Colors.grey,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    changeHoras(1, horasdisponibles);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: AutoSizeText(
                "Valor a transferir",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: Form(
              child: TextFormField(
                controller: _txtControllerComentario,
                decoration: InputDecoration(
                  hintText: 'Razón de transferencia',
                ),
                textCapitalization: TextCapitalization.sentences,
                onChanged: (String val) {},
                validator: (val) {
                  if(val != null){
                    if (val.trim().isEmpty || val.trim().length < 5) {
                      return 'Ingrese una razón de transferencia';
                    }
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget destinatarioView(String usuario, String email) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: AutoSizeText(
                "Destinatario",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 0,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: AutoSizeText(
                    "Nombres : ",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: AutoSizeText(
                    usuario,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 0,
                    child: AutoSizeText(
                      "Email : ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: AutoSizeText(
                      email == "" ? "correo@email.com" : email,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contenidoComprobante() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        AutoSizeText(
          "De:",
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 3.0),
        AutoSizeText(
          "${_loginProvider.usuario!.nombres} ${_loginProvider.usuario!.apellidos}",
          maxLines: 2,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 6.0),
        AutoSizeText(
          "Para:",
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 3.0),
        AutoSizeText(
          "${_ofertaSeleccionada.nombres} ${_ofertaSeleccionada.apellidos}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 6.0),
        AutoSizeText(
          "Monto:",
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 3.0),
        AutoSizeText(
          "$horas horas",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        SizedBox(height: 6.0),
        AutoSizeText(
          "Motivo:",
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: 3.0),
        AutoSizeText(
          _txtControllerComentario.text.length < 30
              ? "${_txtControllerComentario.text}"
              : "${_txtControllerComentario.text.substring(0, 29)}....",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _drawerProvider = Provider.of<DrawerProvider>(context);
    _miembrosProvider = Provider.of<MiembrosProvider>(context);
    _demandasProvider = Provider.of<DemandasProvider>(context);
    return Scaffold(
      appBar: WidgetsPersonalizados.appBarNormalOption(
          title: "Transferir Horas",
          elevation: 0.0,
          mostrarBackButton: true,
          optionsList: [],
          callBackButton: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            switch(_lugar) {
              case "miembros":
                print("CASE misdemandas ");
                _miembrosProvider.consultarMiembrosList(_loginProvider.usuario!.idUsuario!);
                break;
              case "ofertas":
                // _ofertasProvider.obtenerCategorias();
                // _ofertasProvider.consultarOfertasMisOfertas(
                //     0, 100, _loginProvider.usuario.idUsuario, 0);
                break;
              case "misdemandas":
                print("CASE misdemandas ");
                _demandasProvider.consultarDemandasMisDemandas(0, 50, _usuarioLogin.idUsuario!, 1);
                break;
              default:
            }
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              destinatarioView("${_ofertaSeleccionada.nombres} ${_ofertaSeleccionada.apellidos}", "${_ofertaSeleccionada.email}"),
              Divider(
                color: Colors.grey.withAlpha(150),
              ),
              cantidadHoras(context, _usuarioLogin.tiempo!),
              SizedBox(
                height: 20.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print("RATING >> $rating");
                      setState(() {
                        valoracion = rating;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              WidgetsPersonalizados.botonGeneral(
                title: "Transferir Horas",
                margen: 60.0,
                colorTexto: Colores.COLOR_BLANCO,
                colorBoton: Colores.COLOR_PRIMARY,
                callBackBoton: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (_txtControllerComentario.text.trim().isNotEmpty &&
                      horas > 0 &&
                      valoracion > 0.0) {
                    await _drawerProvider.trasferirHoras(
                      context,
                      idUsuarioP: _usuarioLogin.idUsuario!,
                      idUsuarioR: _ofertaSeleccionada.idUsuario!,
                      detalle: _txtControllerComentario.text.trim(),
                      valoracion: valoracion,
                      monto: horas,
                    );
                    if (_drawerProvider.consultaExitosa) {
                      AlertPersonalizado.alertWidget(
                        context,
                        true,
                        "Tranferencia",
                        contenidoComprobante(),
                        callback: () {
                          switch(_lugar) {
                            case "miembros":
                              _miembrosProvider.consultarMiembrosList(_loginProvider.usuario!.idUsuario!);
                              break;
                            case "ofertas":
                              // _ofertasProvider.obtenerCategorias();
                              // _ofertasProvider.consultarOfertasMisOfertas(
                              //     0, 100, _loginProvider.usuario.idUsuario, 0);
                              _miembrosProvider.consultarMiembrosList(_loginProvider.usuario!.idUsuario!);
                              break;
                            case "demandas":
                              _miembrosProvider.consultarMiembrosList(_loginProvider.usuario!.idUsuario!);
                              break;
                            default:
                          }
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      AlertPersonalizado.alertConfirmError(
                          context, _drawerProvider.mensajeConsulta, 0);
                    }
                    _loginProvider.usuario!.tiempo = _loginProvider.usuario!.tiempo! - horas;
                    // }
                  } else {
                    String _mensaje = "";
                    if (_txtControllerComentario.text.trim().isEmpty) {
                      _mensaje = "Debe ingresar un comentario para realizar esta transferencia";
                    } else if (horas == 0) {
                      _mensaje =
                          "Debe ingresar un minimo de 1 hora para realizar esta transferencia";
                    } else if (valoracion == 0) {
                      _mensaje = "Debe asignar una valoración para realizar esta transferencia";
                    }
                    WidgetsPersonalizados.mostrarToast(mensaje: _mensaje);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
