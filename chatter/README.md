El creador del servidor es Caleb Kleveter

https://theswiftwebdeveloper.com/diving-into-vapor-part-2-persisting-data-in-vapor-3-c927638301e8

-----

Crear una base de datos "chatter"

    $ createdb chatter

Configurar la base

    $ psql chatter

    psql> \password 'usuario'

// 'usuario' puede ser su usuario
    
    $ whoami

// pero tienen que modificar un archivo

    chatter/Sources/App/Configuration/configure.swift
    linea 20

y tambien modifican la contraseña, si quieren.

La contraseña en psql y la config del servidor 
en swift tiene que ser la misma.


Ahora para ejecutar todo
Ir al directorio de chatter, para compilar el paquete

    $ swift build

baja las dependencias, esto tarda un poco
Corremos el servidor

    $ swift run

En otra terminal, vamos a hacer los POST request al servidor

    $ ./superCurl

En cualquiera de estos pasos, se puede ir viendo la base de datos

    $ psql chatter

    psql> \dt 
    para mostrar todas las tablas

    psql> select * from "User";
