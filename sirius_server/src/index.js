const http = require('http');
const express = require('express');
const socktIO = require('socket.io');
const serial_port = require('serialport');
//const socket = io;

const app = express();
const server = http.createServer(app);
const io = socktIO.listen(server);

io.serveClient()

//setear directorio public como directorio raiz
app.use(express.static(__dirname + '/public'));

server.listen(3000, function () {
  console.log('server listen on port', 3000);
});

const Readline = serial_port.parsers.Readline;

var port_state = false;

var port = star_serial_communication();

//funcion para iniciar la comunicacion con el dirpositivo serial
async function star_serial_communication() {
  //lee todos los puertos del sistema
  const ports = await serial_port.list()
  var i = 0;
  //imprime los puertos con dispositivos disponibles
  ports.forEach((port, i) => {
    if (port.manufacturer != undefined) {
      console.log(i + '. ' + port.comName + " - " + port.manufacturer);
    }
  });
  //solisita la eleccion de uno de los puertos
  console.log("Marque el numero del puerto al que se desea conectar");
  var stdin = process.openStdin();
  stdin.addListener('data', function (data) {
    const dataString = data.toString().trim();
    console.log("connecting to: " + ports[parseInt(dataString)].comName);
    const portPath = ports[parseInt(dataString)].comName.toString().trim();
    console.log(portPath);
    //inicializa el puerto
    const port = new serial_port(portPath, {
      baudRate: 9600
    });

    const parser = port.pipe(new Readline({ delimiter: "\r\n" }));

    //declara los eventos de apertura entrada y error del puerto
    port.on('open', function () {
      port_state = true;
      console.log('connetion is opened');
    });

    parser.on('data', function (data) {
      console.log(data);
      if ((data + '').includes("Ready")) {
        port_state = true;
      } else {
        data = data.toString().replace('\r\n', '').split(',');
        io.sockets.emit('read_from_arduino', {
          "posicion": data[0],
          "iman": data[1],
          "tamanno_disc": data[2]
        });
      }
    });

    port.on('error', function (err) {
      console.log(err);
    });

    port.on('close', function () {
      console.log('port closed');
    });

    send_to_arduino = function (data) {
      if (port == undefined) {
        throw "port is undefined"
      } else if (port_state != true) {
        throw "port isn't connected"
      } else {
        port.write(data, function (err, results) {
          console.log('Sent: ' + data);
        });
      }
    }

    io.on('connection', function (socket) {
      socket.on('send_to_arduino', function (data) {
        send_to_arduino(data);
      });
    });

  });
}

//funcion para cerrar los puertos serial y socket cuando se cierra el servidor
process.on('beforeExit', function (code) {
  serial_port.close(function (error) {
    if (erro) {
      console.log(error);
    }
  });
  io.close(() => {

  })
});