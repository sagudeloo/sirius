const serial_port = require('serialport');

const Readline = serial_port.parsers.Readline;

const port = new serial_port('/dev/ttyACM3', {
    baudRate: 9600
});

const parser = port.pipe(new Readline({delimiter: "\r\n"}));

port.on('open', function(){
    console.log('connetion is opened');
});

parser.on('data', function(data){
    console.log(data);
    if((data+'').includes("Ready")){
        sendToArduino('HW');
    }
});

port.on('error', function(err){
    console.log(err);
});

function sendToArduino(data){
    port.write(data, function(err, results) {
        console.log('Sent: ' + data);
        //console.log('Error: ' + err);
        //console.log('Results ' + results);
    });
}