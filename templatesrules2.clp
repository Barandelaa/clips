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
   (slot acceso))

(deftemplate sensor-salida
   (slot nombre)
   (slot zona))

(deftemplate sensor-metales
   (slot nombre)
   (slot zona))

(deftemplate sensor-humo
   (slot nombre)
   (slot zona)
   (slot humo))



(defrule ajustar-temperatura-alta
   ?sensor <- (sensor-temperatura (nombre ?nombre) (zona ?zona) (temperatura ?temp))
   (test (>= ?temp 25))
   =>
   (printout t "Temperatura alta en el sensor " ?nombre ", de la zona " ?zona ". Bajando 1 grado." crlf)
   (modify ?sensor (temperatura (- ?temp 1))))


(defrule ajustar-temperatura-baja
   ?sensor <- (sensor-temperatura (nombre ?nombre) (zona ?zona) (temperatura ?temp))
   (test (<= ?temp 20))
   =>
   (printout t "Temperatura baja en el sensor " ?nombre ", de la zona " ?zona ". Subiendo 1 grado." crlf)
   (modify ?sensor (temperatura (+ ?temp 1))))


(defrule ajustar-humedad-alta
   ?sensor <- (sensor-humedad (nombre ?nombre) (zona ?zona) (humedad ?hum))
   (test (>= ?hum 60))
   =>
   (printout t "Humedad alta en el sensor " ?nombre ", de la zona " ?zona ". Bajando la humedad." crlf)
   (modify ?sensor (humedad (- ?hum 10))))

(defrule ajustar-humedad-baja
   ?sensor <- (sensor-humedad (nombre ?nombre) (zona ?zona) (humedad ?hum))
   (test (<= ?hum 40))
   =>
   (printout t "Humedad baja en el sensor " ?nombre ", de la zona " ?zona ". Subiendo la humedad." crlf)
   (modify ?sensor (humedad (+ ?hum 10))))

(defrule protocolo-incendios
   ?sensor <- (sensor-humo (nombre ?nombre) (zona ?zona) (humo ?humo))
   ?sala <- (zona (nombre ?zona) (contenido ?contenido))
   (test (eq ?humo "Si"))
   =>
   (if (eq ?contenido "sensible")
       then
       (printout t "Humo detectado en zona sensible " ?zona crlf)
       (printout t "Evacuando el edificio..." crlf)
       (do-for-all-facts ((?z zona)) TRUE
          (modify ?z (ocupacion-actual 0)))
       (printout t "Activando sistema de gas" crlf)
   else
       (printout t "Humo detectado en zona " ?zona ". Activando sistema de agua." crlf)
       (printout t "Evacuando el edificio..." crlf)
       (do-for-all-facts ((?z zona)) TRUE
            (modify ?z (ocupacion-actual 0))))
   (retract ?sensor))


(defrule control-acceso
   ?sensor <- (sensor-acceso (nombre ?nombre) (zona ?zona) (acceso ?per))
   ?sala <- (zona (nombre ?zona) (acceso ?acc) (ocupacion-max ?ocpmax) (ocupacion-actual ?ocpact))
   ?usuario <- (usuario (nombre ?per) (acceso ?niv))
   (and
      (test (< ?ocpact ?ocpmax))
      (test (>= ?niv ?acc))
   )
   =>
   (printout t ?per " ha entrado en " ?zona "." crlf)
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
   (printout t "Detectado explosivo en " ?zona ". Amenaza a la seguridad. Evacuacion inminente del edificio." crlf)
   (do-for-all-facts ((?z zona)) TRUE
      (modify ?z (ocupacion-actual 0)))
   (retract ?sensor))