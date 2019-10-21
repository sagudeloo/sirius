const socket = io();
const socket2 = io();

let posicion = document.getElementById('posicion');
let iman = document.getElementById('iman');
let tamanno_disc = document.getElementById('tamanno_disc');

socket.on('read_from_arduino', (data) => {
  if (data['iman'] == 1) {
    iman.className = 'btn btn-success rounded-pill btn-lg';
  }else{
    iman.className = 'btn btn-danger rounded-pill btn-lg';
  }
  np = data['posicion']
  posicion.innerHTML = '<h4>Posicion</h4><br> <div class="row d-flex align-items-center justify-content-around"><div class="'+ (np == 1? 'ps':'p') + '"></div><div class="'+ (np == 2? 'ps':'p') +'"></div><div class="'+ (np == 3? 'ps':'p') +'"></div></div>'
  tamanno_disc.innerHTML = '<h4>Disco</h4><br> <div class="d-flex align-items-center justify-content-around"><div class="disco-' + data['tamanno_disc'] + '"></div></div>'
});

function up(){
  send_data('u');
}

function down(){
  send_data('d');
}

function left(){
  send_data('l');
}

function right(){
  send_data('r');
}

function magnet(){
  send_data('e');
}

function send_data(data){
  socket.emit('send_to_arduino', data);
}