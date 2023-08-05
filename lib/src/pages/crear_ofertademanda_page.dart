import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../models/categoria_model.dart';
import '../models/demanda_model.dart';
import '../models/oferta_model.dart';
import '../providers/demandas_provider.dart';
import '../providers/general_provider.dart';
import '../providers/login_provider.dart';
import '../providers/ofertas_provider.dart';
import '../utils/colores.dart';
import '../widgets/widgets_personalizados.dart';

class CrearOfertaDemandaPage extends StatefulWidget {
  const CrearOfertaDemandaPage({Key? key}) : super(key: key);
  static const PAGE_ROUTE = "crearofertademandapage";

  @override
  _CrearOfertaDemandaPageState createState() => _CrearOfertaDemandaPageState();
}

class _CrearOfertaDemandaPageState extends State<CrearOfertaDemandaPage> {
  late Generalprovider _generalprovider;
  late OfertasProvider _ofertasProvider;
  late DemandasProvider _demandasProvider;
  late LoginProvider _loginProvider;
  OfertaModel _oferta = OfertaModel();
  DemandaModel _demanda = DemandaModel();
  TextEditingController _txtControllerTitulo = TextEditingController();
  TextEditingController _txtControllerDescripcion = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      _generalprovider = Provider.of<Generalprovider>(context, listen: false);
      _ofertasProvider = Provider.of<OfertasProvider>(context, listen: false);
      _demandasProvider = Provider.of<DemandasProvider>(context, listen: false);
      if (_generalprovider.currentIndexMisOD == 0) {
        if (_ofertasProvider.estadoEditarOferta) {
          _oferta = _ofertasProvider.ofertaSeleccionado;
          _txtControllerTitulo.text = _oferta.titulo!;
          _txtControllerDescripcion.text = _oferta.descripcionActividad!;
          _generalprovider.categoriaSeleccionada = _oferta.categoria!;
        }
      } else {
        if (_demandasProvider.estadoEditarDemanda) {
          _demanda = _demandasProvider.demandaSeleccionada;
          _txtControllerTitulo.text = _demanda.titulo!;
          _txtControllerDescripcion.text = _demanda.descripcionActividad!;
          _generalprovider.categoriaSeleccionada = _demanda.categoria!;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _generalprovider = Provider.of<Generalprovider>(context);
    _ofertasProvider = Provider.of<OfertasProvider>(context);
    _demandasProvider = Provider.of<DemandasProvider>(context);
    _loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: WidgetsPersonalizados.appBarNormalOption(
          title: _generalprovider.currentIndexMisOD == 0 ? "Oferta" : "Demanda",
          elevation: 0.0,
          mostrarBackButton: true,
          optionsList: [],
          callBackButton: () {
            _ofertasProvider.estadoEditarOferta = false;
            _demandasProvider.estadoEditarDemanda = false;
            Navigator.pop(context);
          }),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText("Título :  "),
                  Container(
                    width: 200.0,
                    child: TextFormField(
                      maxLines: 2,
                      maxLength: 80,
                      controller: _txtControllerTitulo,
                      decoration: InputDecoration(
                        hintText: 'Ingrese un titulo a la solicita',
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (String val) {
                        // _txtControllerTitulo.text = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText("Descripcion :  "),
                  Flexible(
                    child: Container(
                      height: 100,
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        maxLength: 250,
                        controller: _txtControllerDescripcion,
                        decoration: InputDecoration(
                          hintText: 'Ingrese una descripccion a su solicitud',
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (String val) {
                          // print("PRUEBA >> $val");
                          // _txtControllerDescripcion.text = val;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              flex: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText("Categoria :  "),
                  Expanded(
                    flex: 0,
                    child: DropdownButton<String>(
                      value: _generalprovider.categoriaSeleccionada,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        color: Colores.COLOR_PRIMARY,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      items: _generalprovider.listStringcategorias.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (data) {
                        if (data != null) {
                          _generalprovider.categoriaSeleccionada = data;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            WidgetsPersonalizados.botonGeneral(
              title: _generalprovider.currentIndexMisOD == 0
                  ? _ofertasProvider.estadoEditarOferta
                      ? "Editar Oferta"
                      : "Crear oferta"
                  : _demandasProvider.estadoEditarDemanda
                      ? "Editar Demanda"
                      : "Crear Demanda",
              margen: 60.0,
              colorTexto: Colores.COLOR_BLANCO,
              colorBoton: Colores.COLOR_PRIMARY,
              callBackBoton: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                CategoriaModel categoria = _generalprovider.listTodasCategorias
                    .firstWhere((element) => element.categoria == _generalprovider.categoriaSeleccionada);
                if (_generalprovider.currentIndexMisOD == 0) {
                  if (_ofertasProvider.estadoEditarOferta) {
                    // estado 0 desabilitado, 1 visible
                    await _ofertasProvider.editarOferta(context, 1, _txtControllerTitulo.text.trim(),
                        _txtControllerDescripcion.text.trim(), categoria.idCategoria!, _oferta.idOfertasDemandas!);
                    _ofertasProvider.estadoEditarOferta = false;
                    _ofertasProvider.consultarOfertasMisOfertas(0, 50, _loginProvider.usuario!.idUsuario!, 1);
                  } else {
                    _ofertasProvider.estadoEditarOferta = false;
                    await _ofertasProvider.registrarOferta(context, _txtControllerTitulo.text.trim(),
                        _txtControllerDescripcion.text.trim(), categoria.idCategoria!, _loginProvider.usuario!.idUsuario!);
                    _ofertasProvider.consultarOfertasMisOfertas(0, 50, _loginProvider.usuario!.idUsuario!, 1);
                  }
                } else {
                  print("PRUEBA > DEMANDA :1 ${categoria.idCategoria}");
                  if (_demandasProvider.estadoEditarDemanda) {
                    // estado 0 desabilitado, 1 visible
                    print("PRUEBA > DEMANDA :2 ${categoria.idCategoria}");
                    await _demandasProvider.editarDemanda(context, 1, _txtControllerTitulo.text.trim(),
                        _txtControllerDescripcion.text.trim(), categoria.idCategoria!, _demanda.idOfertasDemandas!);
                    _demandasProvider.estadoEditarDemanda = false;
                    _demandasProvider.consultarDemandasMisDemandas(0, 50, _loginProvider.usuario!.idUsuario!, 1);
                  } else {
                    print("PRUEBA > DEMANDA :3 ${categoria.idCategoria}");
                    _demandasProvider.estadoEditarDemanda = false;
                    await _demandasProvider.registrarDemanda(context, _txtControllerTitulo.text.trim(),
                        _txtControllerDescripcion.text.trim(), categoria.idCategoria!, _loginProvider.usuario!.idUsuario!);
                    _demandasProvider.consultarDemandasMisDemandas(0, 50, _loginProvider.usuario!.idUsuario!, 1);
                  }
                }
                //limpiar campos
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
