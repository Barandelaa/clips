import random
from clips import Environment
from time import sleep

# Crear el entorno CLIPS
env = Environment()

# Cargar las reglas
env.load("templatesrules2.clp")

# Cargar los hechos
def cargar_hechos():
    env.load("hechos.clp")
    env.reset()


# Función para generar lecturas de temperatura
def generar_lectura(sensor):
    value = random.uniform(20, 40)  # Generar un valor aleatorio entre 20 y 40
    return {"nombre": sensor["nombre"], "zona": sensor["zona"], "temperatura": value}

# Función para mostrar la ejecucion de las reglas de regulacion de temperatura
def demostracion_temperatura(): 
    cargar_hechos()
    print("Demostración de temperatura: ")
    env.assert_string('(sensor-temperatura (nombre "sensor-temp-1") (zona "servidores") (temperatura 27))')
    env.assert_string('(sensor-temperatura (nombre "sensor-temp-2") (zona "servidores") (temperatura 18))')
    env.run()
    print("\n")
    sleep(5)

# Función para mostrar la ejecucion de las reglas de regulacion de humedad
def demostracion_humedad():
    cargar_hechos()
    print("Demostración de humedad: ")
    env.assert_string('(sensor-humedad (nombre "sensor-hum-1") (zona "servidores") (humedad 20))')
    env.assert_string('(sensor-humedad (nombre "sensor-hum-2") (zona "servidores") (humedad 90))')
    env.run()
    print("\n")
    sleep(5)

# Función para mostrar la ejecucion de las reglas de incendio
def demostracion_incendio():
    cargar_hechos()
    print("Demostración de incendio: ")
    env.assert_string('(sensor-humo (nombre "sensor-humo-1") (zona "servidores") (humo "Si"))')
    env.run()
    print("\n")
    sleep(5)

# Función para mostrar la ejecucion de las reglas de accesos
def demostracion_accesos():
    cargar_hechos()
    print("Demostración de accesos: ")
    env.assert_string('(sensor-acceso (nombre "sensor-acc-1") (zona "servidores") (acceso "Tomas"))')
    env.assert_string('(sensor-acceso (nombre "sensor-acc-2") (zona "servidores") (acceso "David"))')
    env.assert_string('(sensor-salida (nombre "sensor-sal-1") (zona "servidores"))')
    env.run()
    print("\n")
    sleep(5)

# Función para mostrar ña ejecucion de las reglas de caso de bomba
def demostracion_bomba():
    cargar_hechos()
    print("Demostración de bomba: ")
    env.assert_string('(sensor-metales (nombre "sensor-metales-1") (zona "entrada"))')
    env.run()
    print("\n")


#Lanzar demostraciones
demostracion_temperatura()
demostracion_humedad()
demostracion_incendio()
demostracion_accesos()
demostracion_bomba()

