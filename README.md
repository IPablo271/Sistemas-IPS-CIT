# Proyecto de Sistema de Posicionamiento en Interiores (IPS) para la Universidad del Valle de Guatemala

Este proyecto, desarrollado en el contexto de la Universidad del Valle de Guatemala (UVG), tiene como objetivo implementar un **Sistema de Posicionamiento en Interiores (IPS)** para facilitar recorridos virtuales a través de realidad aumentada en el campus universitario. Utilizando tecnologías avanzadas como **Bluetooth Low Energy (BLE)** y **Ultra-Wideband (UWB)**, se evalúa la precisión y viabilidad de estas tecnologías para brindar una experiencia de navegación precisa y eficiente.

## Descripción del Proyecto

El proyecto busca mejorar la orientación y navegación de estudiantes, profesores, y visitantes dentro del campus universitario mediante un sistema de posicionamiento interior. Se evaluaron dos tecnologías:

- **BLE**: Tecnología de bajo costo y energía que utiliza la intensidad de la señal recibida (RSSI) para calcular distancias y determinar la ubicación.
- **UWB**: Tecnología avanzada que permite alta precisión en la ubicación mediante el cálculo de la diferencia de tiempo de llegada (TDOA) de las señales de radiofrecuencia.

### Objetivos

1. Evaluar y seleccionar la tecnología más efectiva para posicionamiento en interiores en UVG.
2. Implementar ambas tecnologías y compararlas en términos de precisión, alcance, costo, y escalabilidad.
3. Desarrollar una aplicación que visualice las posiciones en tiempo real utilizando las distancias calculadas por las balizas.

## Estructura del Repositorio

El repositorio está organizado en las siguientes carpetas:

- **Arduino/**: Contiene archivos en C++ para la configuración de balizas BLE, cada uno configurado con un identificador único para emitir señales que permitan el cálculo de la ubicación.
- **BLEDistance/**: Incluye una aplicación desarrollada en Swift para dispositivos iOS, que calcula la distancia a balizas BLE basándose en la señal RSSI.
- **EstimoteUWB/**: Incluye una aplicación en Swift para calcular la distancia usando la tecnología UWB, integrada con el SDK de Estimote para la comunicación con las balizas UWB.

## Implementación de BLE

1. **Configuración de Balizas**: Los dispositivos Arduino fueron configurados como balizas BLE que emiten señales RSSI, utilizadas para estimar la distancia entre el dispositivo móvil y cada baliza.
2. **Algoritmo de Trilateración**: Con las distancias obtenidas de cada baliza BLE, el algoritmo de trilateración calcula las coordenadas (X, Y) aproximadas del dispositivo móvil.
3. **Resultados**: La tecnología BLE es accesible y de bajo costo, pero en pruebas demostró limitaciones en precisión debido a interferencias en el entorno universitario.

## Implementación de UWB

1. **Configuración de Balizas UWB**: Utilizando balizas UWB de Estimote, el sistema mide con alta precisión las distancias desde el dispositivo móvil a cada baliza.
2. **Algoritmo de Trilateración**: Similar a BLE, se utiliza la trilateración para determinar la ubicación exacta del dispositivo en el plano.
3. **Resultados**: La tecnología UWB presentó una mayor precisión y estabilidad frente a las interferencias, ideal para aplicaciones que requieren alta precisión en entornos complejos.


## Requisitos

- **Arduino IDE** para la configuración de balizas BLE.
- **Xcode** para la implementación de las aplicaciones en iOS.
- **SDK de Estimote** para la integración de balizas UWB.

## Agradecimientos

Este proyecto se desarrolló con el apoyo del Centro de Innovación y Tecnología de la Universidad del Valle de Guatemala, bajo la guía y asesoría del Ingeniero Andrés Tahuico y otros colaboradores.
