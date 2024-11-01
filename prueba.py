import random
from clips import Environment

# Crear el entorno CLIPS
env = Environment()

# Cargar las reglas
env.load("templatesrules2.clp")

# Cargar los hechos
# env.load("factos2.clp")

env.assert_string('(usuario (nombre "Josefina") (ocupacion "limpieza") (acceso 2))')
env.assert_string('(usuario (nombre "Javier") (ocupacion "tecnico") (acceso 2))')
env.assert_string('(usuario (nombre "David") (ocupacion "scrum master") (acceso 3))')
env.assert_string('(usuario (nombre "Daniel") (ocupacion "oficinista") (acceso 1))')
env.assert_string('(usuario (nombre "Tomas") (ocupacion "terrorista") (acceso 0))')

env.assert_string('(zona (nombre "area-descanso") (acceso 1) (ocupacion-max 10) (ocupacion-actual 0) (contenido "no-sensible"))')
env.assert_string('(zona (nombre "entrada") (acceso 1) (ocupacion-max 20) (ocupacion-actual 0) (contenido "no-sensible"))')
env.assert_string('(zona (nombre "limpieza") (acceso 2) (ocupacion-max 5) (ocupacion-actual 0) (contenido "sensible"))')
env.assert_string('(zona (nombre "oficinas") (acceso 1) (ocupacion-max 15) (ocupacion-actual 0) (contenido "sensible"))')
env.assert_string('(zona (nombre "servidores") (acceso 2) (ocupacion-max 3) (ocupacion-actual 2) (contenido "sensible"))')
env.assert_string('(zona (nombre "comunicaciones") (acceso 2) (ocupacion-max 4) (ocupacion-actual 0) (contenido "sensible"))')
env.assert_string('(zona (nombre "area-control") (acceso 3) (ocupacion-max 2) (ocupacion-actual 0) (contenido "sensible"))')

# Función para generar lecturas de temperatura
def generar_lectura(sensor):
    value = random.uniform(20, 40)  # Generar un valor aleatorio entre 20 y 40
    return {"nombre": sensor["nombre"], "zona": sensor["zona"], "temperatura": value}


#env.assert_string('(sensor-humo (nombre "sensor-humo-1") (zona "servidores") (humo "Si"))')
#env.assert_string('(sensor-temperatura (nombre "sensor-temp-1") (zona "servidores") (temperatura 27))')
#env.assert_string('(sensor-temperatura (nombre "sensor-temp-2") (zona "servidores") (temperatura 18))')
#env.assert_string('(sensor-metales (nombre sensor) (zona entrada))')
env.assert_string('(sensor-acceso (nombre "sensor-acc-1") (zona "servidores") (acceso "Tomas"))')
env.assert_string('(sensor-acceso (nombre "sensor-acc-2") (zona "servidores") (acceso "David"))')
#env.assert_string('(sensor-salida (nombre "sensor-sal-1") (zona "servidores"))')
env.assert_string('(sensor-humedad (nombre "sensor-hum-1") (zona "servidores") (humedad 70))')

#for fact in env.facts():
#    print(fact)


# Ejecutar las reglas en CLIPS
env.run()