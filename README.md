# Hades
Prueba de concepto de aplicación de administración de accesos.

## Estructura aplicación

### Clases con build (pantallas)
* [ListadoAccesos](../master/lib/pantallas/ListadoAccesos.dart)
* [PaginaEspera](../master/lib/pantallas/PaginaEspera.dart)
* [PaginaInicioSesion](../master/lib/pantallas/PaginaInicioSesion.dart)
* [PaginaPrincipal](../master/lib/pantallas/PaginaPrincipal.dart)

### Clases con factory
* [Acceso](../master/lib/Acceso.dart)
* [InformacionToken](../master/lib/InformacionToken.dart)
* [PostInicioSesion](../master/lib/PostInicioSesion.dart)
* [Usuario](../master/lib/Usuario.dart)


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
[Push, Pop, Push](https://medium.com/flutter-community/flutter-push-pop-push-1bb718b13c31)

[Borrar Rutas](https://stackoverflow.com/questions/45398204/removing-the-default-back-arrow-on-certain-pages)

## Construir Widget
[Material Components widgets](https://flutter.io/docs/development/ui/widgets/material)
## Métodos get y post
La librería [http](https://pub.dartlang.org/packages/http) permite realizar consultas por get y post asincrónamente
 ```dart
import 'package:http/http.dart' as http;
 ```

 dado que al momento de enviar parámetros se complica el utilizarla, por lo que se crearon los siguientes métodos
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


## Convertir Json a un Objeto (convertirJson)
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
Para añadir imagenes agregarlas en las carpetas mipmap ubicadas en
Hades\android\app\src\main\res


Para agregar el color de fondo agregar el archivo [colors.xml](../master/android/app/src/main/res/values/colors.xml) en la carpeta values, ubicada en
Hades\android\app\src\main\res
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
 Para agregar los links ir a Hades\android\app\src\main\AndroidManifest.xml
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





