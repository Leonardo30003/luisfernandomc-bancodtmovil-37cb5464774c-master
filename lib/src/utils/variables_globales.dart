class GlobalVariables {
  /// SERVIDORES
  static const URL_PRODUCCION = "http://localhost:3001";

  /// RECURSOS
  //otros drawer
  static const BUSCAR_USUARIO = "/usuario/usuariobycelular";
  static const TRANSFERIR_TIEMPO = "/usuario/transferir";
  static const OBTENER_TRANSACCIONES = "/usuario/movimientos";
  //login
  static const LOGIN_USUARIO = "/usuario/autenticar";
  //Miembros
  static const OBTENER_MIEMBROS = "/usuario/miembros";
  //ofertas
  static const REGISTRAR_FAVORITO = "/oferta/reg-favorito";
  static const CATEGORIAS_OFERTAS = "/categoria/listar";
  static const LISTA_OFERTAS = "/oferta/listar";
  static const REGISTRAR_OFERTA = "/oferta/registrar";
  static const EDITAR_OFERTA = "/oferta/editar";
  static const QUIENES_APLICARON = "/oferta/listar-aplicaron";
  //demandas
  static const LISTA_DEMANDAS = "/demanda/listar";
  static const CATEGORIAS_DEMANDAS = "/categoria/listar_demandas";
  static const REG_FAVORITO_DEMANDA = "/demanda/reg-favorito";
  static const REGISTRAR_DEMANDA = "/demanda/registrar";
  static const EDITAR_DEMANDA = "/demanda/editar";
  static const ELIMINAR_APLICADO = "/demanda/quitar_postulante";

  // lis
  static const CATEGORIAS_TODAS = "/categoria/listar-todas";

  /// ID APLICACIONES
  static const ID_APLICATIVO = 1;
  static const ID_APLICATIVO_ANDROID = 9;
  static const ID_APLICATIVO_IOS = 10;

  ///RECURSOS MAPAS
  static const ID_EMPRESA = 5;
  static const ID_CIUDAD = 1; //modificar
  static const URL_MAPBOX = "https://api.mapbox.com/directions/v5/mapbox/";
  static const URL_MAPGOOGLE = "https://maps.googleapis.com/maps/api/directions/json?";
  static const ACCESS_TOKEN = "pk.eyJ1IjoiY2FybG9zLWphcG9uIiwiYSI6ImNrZnUxNmFhejEyYjcyeW53OHozcXBzOXoifQ.QIG7AeSI4C9Hq8LIJ15Wog";
  static const APPI_KEY = "AIzaSyCQmwSVuq7WBvorbldDngf-1WryX1jL0Xg";

  /// VARIABLES
  static const URL_WHATSAPP = 'https://api.whatsapp.com/send?phone=593';
  static const TOKEN_LOGIN = 'sasabbbbc12341234sasa';
  static const URL_IMAGE = 'https://sweb.ktaxi.com.ec/DES/bantotiempo/img/uploads/admins/';
}