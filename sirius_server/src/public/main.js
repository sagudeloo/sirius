const socket = io();

socket.on('serial', function(data){
    document.body.innerHTML = '';
    document.write(JSON.stringify({"posicion": data[0],
    "iman": data[1],
    "tamanno_disc": data[2]
    }));
});