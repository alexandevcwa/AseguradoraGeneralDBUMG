# Aseguradora General de GT (MiUMG - Practica)
Este proyecto representa una practica de normalización de base de datos hasta 3-FN e implementacion en DDL para la creación de los objetos en base de datos Oracle

## Detalles de requerimiento
La Aseguradora General de Guatemala, necesita una base de conocimiento para guardar la
información relativa a los vehículos asegurados y de sus propietarios, así como también
llevar el registro de clientes potenciales que estén interesados en adquirir un seguro
vehicular. De los vehículos se sabe su Placa, tipo de placa, fecha de matriculación, precio,
modelo, cilindraje, color y marca. De los propietarios se sabe su nombre, DPI, NIT, Dirección,
Departamento y Municipio. De los clientes potenciales se guardará el tipo de seguro al que
estuvo interesado a adquirir. De los Seguros se sabe: tipo, valor de la prima, fecha de inicio
y fecha de fin de la póliza. Es evidentemente posible, que un cliente tenga asegurados varios
vehículos y que algunos vehículos, figuren a nombre de varios propietarios.

## Diagrama ERD Lógico

[ERD Lógico - OneDrive](https://umgt-my.sharepoint.com/:i:/g/personal/rmachicm_miumg_edu_gt/EbyVkwpYf15Oo8a5ipM7AGcBMFY5IZbgvLHE8tAlLCMhyw?e=TTWQaf "ERD Lógico")

## Diagrama ERD Relacional

[ERD Relacional - OneDrive](https://umgt-my.sharepoint.com/:i:/g/personal/rmachicm_miumg_edu_gt/EQFtHWZPMzdOolG32tvWzvoBgSSPWlnGU4Awei9ufts_GQ?e=64WX9S "ERD Relacional")


## Pasos para creación de usuario que contendra la base de datos.
Para la creación del usuario de base de datos que contendra todos los objetos, ejecutar el siguiente script SQL para su creación adaptando la ruta del [DATAFILE](https://docs.oracle.com/cd/A57673_01/DOC/server/doc/SCN73/ch4.htm) al sistema operativo en el que se esta ejecutando el SGDB

- [Script creación de usuario y tablespace](DDL/USER_DDL.sql)

## Creación de base de datos
Para la creación de tablas,vistas indexes y synonyms ejecutar el siguiente script sql.

- [Script creación de objetos de base de datos](DDL/CREATE_DDL.sql)
