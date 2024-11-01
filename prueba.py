import random
from clips import Environment

# Crear el entorno CLIPS
env = Environment()

# Cargar las reglas y hechos desde el archivo templatesrules2.clp
env.load("templatesrules2.clp")

# Cargar los hechos desde el archivo factos2.clp
env.load_facts("factos2.clp")

# Función para generar lecturas de sensor
def generar_lectura(sensor_id):
    value = random.uniform(20, 40)  # Generar un valor aleatorio entre 20 y 40
    return {"sensor-id": sensor_id, "value": value}

# Generar y agregar lecturas de sensor a CLIPS
for i in range(5):  # Generar 5 lecturas de sensor
    reading = generar_lectura(f"sensor-{i+1}")
    fact = env.assert_string(f"(sensor-temperatura (nombre {reading['sensor-id']}) (temperatura {reading['value']}))")
    print(f"Hecho: {fact}")

# Ejecutar las reglas en CLIPS
env.run()