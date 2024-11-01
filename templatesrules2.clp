(deftemplate sensor-reading
   (slot sensor-id)
   (slot value))

(deftemplate usuario
   (slot nombre)
   (slot ocupacion)
   (slot acceso))

(deftemplate zona
   (slot nombre)
   (slot acceso)
   (slot ocupacion-max)
   (slot ocupacion-actual)
   (slot contenido))  ; Atributo para describir el tipo de contenido de la zona (por ejemplo: "sensible" o "normal")

(deftemplate sensor-temperatura
   (slot nombre)
   (slot zona)
   (slot temperatura))

(deftemplate sensor-humedad
   (slot nombre)
   (slot zona)
   (slot humedad))

(deftemplate sensor-acceso
   (slot nombre)
   (slot zona)
   (slot nivel-acceso))

(deftemplate sensor-salida
   (slot nombre)
   (slot zona))

(deftemplate sensor-metales
   (slot nombre)
   (slot zona)
   (slot detectado))

(defrule high-temperature
   (sensor-temperatura (nombre ?nombre) (zona ?zona) (temperatura ?temp&:(> ?temp 30)))
   =>
   (printout t "Temperatura demasiado alta detectada por " ?nombre " en zona " ?zona " con temperature " ?temp crlf))

(defrule high-humidity
   (sensor-humedad (nombre ?nombre) (zona ?zona) (humedad ?hum&:(> ?hum 70)))
   =>
   (printout t "Alta humedad detectada por sensor " ?nombre " en zona " ?zona " con humedad " ?hum crlf))

(defrule control-entrada
   ?sensor <- (sensor-acceso (nombre ?nombre) (zona ?zona) (nivel-acceso ?nivel))
   ?sala <- (zona (nombre ?zona) (ocupacion-actual ?ocpact))
   =>
   (printout t "Entrada registrada en " ?zona "." crlf)
   (modify ?sala (ocupacion-actual (+ ?ocpact 1)))
   (retract ?sensor))

(defrule control-salida
   ?sensor <- (sensor-salida (nombre ?nombre) (zona ?zona))
   ?sala <- (zona (nombre ?zona) (ocupacion-actual ?ocpact))
   =>
   (printout t "Salida registrada en " ?zona "." crlf)
   (modify ?sala (ocupacion-actual (- ?ocpact 1)))
   (retract ?sensor))

(defrule protocolo-seguridad
   ?sensor <- (sensor-metales (nombre ?nombre) (zona ?zona))
   =>
   (printout t "Detectado explosivo en " ?zona ". Amenaza a la seguridad. Evacuación inminente del edificio." crlf)
   (do-for-all-facts ((?z zona)) TRUE
      (modify ?z (ocupacion-actual 0)))
   (retract ?sensor))