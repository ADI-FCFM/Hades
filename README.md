# Hades
Prueba de concepto de aplicación de administración de accesos.


La aplicación permite al usuario iniciar sesión utilizando sus credenciales universitarias
mediantes el protocolo [CAS](https://apereo.github.io/cas/4.2.x/protocol/CAS-Protocol.html
).


Cuando el usuario inicie sesión externamente, se le redigirá a la aplicación con un ticket,
el cual será verificado en la api [Aqueronte](https://github.com/ADI-FCFM/Aqueronte) antes de permitir al usuario ingresar.
Junto con verificar el ticket la api enviará más información, la cual será de tipo PostInicioSesion.
Este objeto contendrá datos del usuario(tipo Usuario) e información para poder comunicarse directamente con esta (tipo InformacionToken).


Además, la aplicación entregará el listado de accesos del usuario y permitirá abrirlos.
Para obtener esta información, la aplicación se comunicará con Aqueronte utilizando InformacionToken.

## Comunicación con Aqueronte

Cuando la aplicación se comunique con Aqueronte pueden existir las siguientes situaciones:
* Respuesta 200: no hubo errores al momento de obtener la información, por lo que esta se muestra.
* Respuesta 403: el token utilizado está vencido por lo que se debe llamar a la función refrescarToken,
    actualizar informacionToken con los nuevos datos e
    intentar comunicarse nuevamente con la api.
* Otro : mostrar un error con la función alertaError.

## Estructura aplicación

### Clases para las pantallas
* [PaginaInicioSesion](../master/lib/pantallas/PaginaInicioSesion.dart): contiene un botón para redigir a la página de autenticación.
* [PaginaPrincipal](../master/lib/pantallas/PaginaPrincipal.dart): se muestra el nombre del usuario en el _app_bar_ y en el _body_ el listado de accesos (ListadoAccesos).
* [ListadoAccesos](../master/lib/pantallas/ListadoAccesos.dart): listado de los accesos del usuario, los cuales al ser presionados abren las puertas.
* [PaginaEspera](../master/lib/pantallas/PaginaEspera.dart): contiene un _CircularProgressIndicator_.

### Otras clases
* [Acceso](../master/lib/Acceso.dart): accesos (puertas) que son administrados por la aplicación
* [InformacionToken](../master/lib/InformacionToken.dart): información que permite comunicarse con Aqueronte.
* [PostInicioSesion](../master/lib/PostInicioSesion.dart): información recibida al entregar el ticket a Aqueronte.
* [Usuario](../master/lib/Usuario.dart): información del usuario.


### Utilidades
* [Utilidades Generales](../master/lib/utilidades/utilidadesGenerales.dart) 
    * metodoGet
    * metodoPost
    * alertaError
    * lanzarURL
    * salirAplicacion
* [Accesos](../master/lib/utilidades/accesos.dart)
    * conseguirAccesos
    * parsearAccesos
    * abrirAcceso
* [Información Token](../master/lib/utilidades/informacionToken.dart)
    * conseguirTokenAlmacenado
    * verificarFechaExpiracionToken
    * refrescarToken
    * invalidarToken
* [Usuario](../master/lib/utilidades/usuario.dart)
    * conseguirNombreAlmacenadoUsuario


# Referencia

## Navigation
[Documentación Flutter sobre Navigation](https://flutter.io/docs/cookbook/navigation/navigation-basics)


[Explicación en medium de más métodos para navegar](https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31)


[Borrar Rutas](https://stackoverflow.com/questions/45398204/removing-the-default-back-arrow-on-certain-pages)

Para navegar entre pantallas se utiliza _Navigator_. En palabras simples, a las pantallas se les asocian _routes_,
 las cuales son mostradas con Navigator.pushNamed(contexto, nombreRuta) y quitadas con Navigator.pop(contexto).
 Existen más métodos para navegar entre pantallas, los cuales se explican en las referencias de arriba.


## Construir Widget
[Widget](https://flutter.io/docs/development/ui/widgets-intro)


[Material Components widgets](https://flutter.io/docs/development/ui/widgets/material)


En Flutter para construir la interfaz se utilizan widget. Los cuales pueden ser de dos tipos:
* StatefulWidget: widget que pueden cambiar.
* StatelessWidget: widget que nunca cambia.
## Métodos get y post
La librería [http](https://pub.dartlang.org/packages/http) permite realizar consultas por get y post asincrónamente
 ```dart
import 'package:http/http.dart' as http;
 ```

 dado que al momento de enviar parámetros se complica el utilizarla, se crearon los siguientes métodos:
### Post (metodoPost)


 Recibe la url y los parametros de consulta en con el formato {"parametro1": "value", "parametro2": "value"}.


 Para utilizar el post de http se requiere entregar el cuerpo como un JSON string,
 por ello con la librería __convert__ se transformarn los parámetros de consulta utilizando la función __json.encode(parametrosConsulta)__.

 ```dart
 import 'dart:convert';

 Future<http.Response> metodoPost(url, parametrosConsulta) async {
   Map<String, String> headers = {
     "Content-Type": "application/json ; charset=utf-8",
   };
   var body = json.encode(parametrosConsulta);
   http.Response respuesta = await http.post(url, headers: headers, body: body);
   return respuesta;
 }
 ```
### Get (metodoGet)

Recibe la url y los parametros de consulta en con el formato {"parametro1": "value", "parametro2": "value"}.


Para utilizar el método get de http es necesario pasar los parámetros como una
[Uri](https://api.dartlang.org/stable/2.1.0/dart-core/Uri-class.html)
por ello, primero se crea la uri con __Uri.parse(url)__ y
luego con replace se agregan los parametros de consulta.

 ```dart
 Future<http.Response> metodoGet(url, parametrosConsulta) async {
    var uri = Uri.parse(url);
    uri = uri.replace(queryParameters: parametrosConsulta);
    http.Response respuesta = await http.get(uri);
    return respuesta;
  }
```


## Convertir Json en un Objeto (convertirJson)
Explicación de como convertir un Json en un objeto:
[Factory](https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51)

## Guardar información en la aplicación
[Shared Preferences 1](https://pub.dartlang.org/packages/shared_preferences)

[Shared Preferences 2](https://medium.com/@carlosAmillan/shared-preferences-c%C3%B3mo-guardar-la-configuraci%C3%B3n-de-la-aplicaci%C3%B3n-flutter-y-las-preferencias-del-8bbd30cd7dbc).

Para almacenar datos __sin cifrar__ en la aplicación se utiliza Shared Preferences.


 Estos datos dejarán de estar guardados si el usuario
 limpia los datos de la aplicación o la desinstala.



Los datos se obtienen asíncronamente por lo que antes de intentar conseguir un dato almacenado
se debe utilizar
```dart
 SharedPreferences prefs = await SharedPreferences.getInstance();
```
Para setear se utiliza
```dart
    pref.setBool("activo", false);
    pref.setDouble("numeroImportante", 0.5);
    pref.setInt("contador", 0);
    prefs.setString("nombre", "Juan");
    prefs.setStringList("ramos", ["calculo", "física"]);
```
Para conseguir los datos guardados se utiliza

```dart
    bool activo = prefs.getBool("activo");
    double numeroImportante = prefs.getDouble("numeroImportante");
    int contador = prefs.getInt("contador");
    String nombre = prefs.getString("nombre");
    var prefs.setStringList = prefs.getStringList("ramos");
```

Para borrar los datos se utiliza
```dart
prefs.remove("activo");
```


## Hecho nativo
### Splash screen
[splash screen 1](https://flutter.io/docs/development/ui/assets-and-images)
#### Android:
Para añadir imagenes agregarlas en las carpetas __mipmap__ ubicadas en
[Hades\android\app\src\main\res](../master/android/app/src/main/res)



Para agregar el color de fondo agregar el archivo [colors.xml](../master/android/app/src/main/res/values/colors.xml) en la carpeta __values__, ubicada en
[Hades\android\app\src\main\res](../master/android/app/src/main/res)
con el siguiente contenido
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="nombreColor">#colorEnHexadecimal</color>
</resources>
```

Finalmente para configurar la splash screen ir a
Hades\android\app\src\main\res\drawable\launch_background.xml
y agregar
```xml
<?xml version="1.0" encoding="utf-8"?><!-- Modify this file to customize your launch splash screen -->
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- indicar color -->
    <item android:drawable="@color/nombreColor" />

    <!-- insertar imagen -->
    <item>
        <bitmap
            android:gravity="center"
            android:src="@mipmap/nombreImagen" />
    </item>
</layer-list>

```

#### iOS:

### Redirigir a la aplicación luego de que la persona inicie sesión
[uni_links 1](https://pub.dartlang.org/packages/uni_links)


Se utilizó la función getLinksStream de la librería uni_links  para
tener un listener que vea el cambio en la url.


Para utilizar la librería fue necesario configurar los permisos de los links en las
 carpetas de ios y android.

#### Android:
 Para agregar los links ir a [Hades\android\app\src\main\AndroidManifest.xml](../master/android/app/src/main/AndroidManifest.xml)
```xml
<manifest ...>
    <application ...>
          <activity ...>
              <!-- Deep Links -->
              <intent-filter>
                  <action android:name="android.intent.action.VIEW" />

                  <category android:name="android.intent.category.DEFAULT" />
                  <category android:name="android.intent.category.BROWSABLE" />

                  <data
                      android:scheme="app"
                      android:host="accesos.app.adi">

                  </data>
              </intent-filter>

              <!-- App Links -->
              <intent-filter android:autoVerify="true">
                  <action android:name="android.intent.action.VIEW" />

                  <category android:name="android.intent.category.DEFAULT" />
                  <category android:name="android.intent.category.BROWSABLE" />

                  <data
                      android:scheme="unilinks"
                      android:host="accesos.app.adi">

                  </data>
              </intent-filter>
          </activity>
    </application>
</manifest>
```

#### iOS:





