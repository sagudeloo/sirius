# SIRIUS

Pedro Quintero
Stiven Agudelo
Maria Antonia Rincón

Desarrollo del parcial - SIRIUS

El proyecto se basa en la manipulación del puente-electroimán que se encarga de manejar las torres de hanoi.
Nuestro objetivo es crear un aplicativo movil el cual permita mover en las direcciones posibles (arriba, abajo, drecha e izquierda)
el electroimán de la máquina, además de poder encenderlo y apagarlo desde la  misma aplicación. Y con estas acciones ya realizadas,
se pretende recuperar tanto la posición en la que se encuentra el electroimán, como el tamaño de la ficha que éste esté sosteniendo.

Para poder realizar esto, es necesario manejar todo el sistema con todos los frentes de desarrollo: Back End, Middle End y Front
End, los cuales son NodeJS, Arduino y Flutter(Dart) respectivamente.
Estos frentes funcionan de manera simultánea enviando y recibiendo información desde y para la máquina empleada. Por lo cual es 
netamente necesaria la comunicación efectiva e impecable entre ellos. 

En breve descripción: Desde la aplicación se comandará una acción para que el electroimán la ejecute. Ésta se envía al BackEnd
(NodeJS) y éste se encarga de convertirla en un caracter, número o byte y la envía al arduino. Allí, la instrucción se recibe y se
evalúa, identificando qué es lo que ésta hará en el electrimán, y finalmente, el electroimán funcionará dependiendo de la orden
que le haya sido enviada. Luego de ejecutarse, la infromación que el electroimán mantenga (Posición y tamaño del disco), será
recuperada por el arduino, el BackEnd la guarda, y la envía a la aplicación para que pueda ser recuperada en pantalla.

Como resultado, se obtiene una aplicación interactiva que es capáz de establecer comunicación con un módulo distinto al propio, y 
también hace posible la recuperación de información.
