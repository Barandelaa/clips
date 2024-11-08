(deffacts hechos-iniciales 
    (usuario (nombre "Josefina") (ocupacion "limpieza") (acceso 2))
    (usuario (nombre "Javier") (ocupacion "tecnico") (acceso 2))
    (usuario (nombre "David") (ocupacion "scrum master") (acceso 3))
    (usuario (nombre "Daniel") (ocupacion "oficinista") (acceso 1))
    (usuario (nombre "Tomas") (ocupacion "terrorista") (acceso 0))
    

    (zona (nombre "area-descanso") (acceso 1) (ocupacion-max 10) (ocupacion-actual 0) (contenido "no-sensible"))
    (zona (nombre "entrada") (acceso 1) (ocupacion-max 20) (ocupacion-actual 0) (contenido "no-sensible"))
    (zona (nombre "limpieza") (acceso 2) (ocupacion-max 5) (ocupacion-actual 0) (contenido "sensible"))
    (zona (nombre "oficinas") (acceso 1) (ocupacion-max 15) (ocupacion-actual 0) (contenido "sensible"))
    (zona (nombre "servidores") (acceso 2) (ocupacion-max 3) (ocupacion-actual 2) (contenido "sensible"))
    (zona (nombre "comunicaciones") (acceso 2) (ocupacion-max 4) (ocupacion-actual 0) (contenido "sensible"))
    (zona (nombre "area-control") (acceso 3) (ocupacion-max 2) (ocupacion-actual 0) (contenido "sensible"))
)