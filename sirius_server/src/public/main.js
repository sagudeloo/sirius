const socket = io();

let posicion = document.getElementById('posicion');
let iman = document.getElementById('iman');
let grab = document.getElementById('grab');
let tamanno_disc = document.getElementById('tamanno_disc');
socket.on('read_from_arduino', (data) => {
  console.log(Object.keys(data));
  if (Object.keys(data).length === 3) {
    setState(data['posicion'], data['iman'], data['tamanno_disc']);
  }
});

function setState(posicion_state, iman_state, tamanno_disc_state) {
  if (iman_state == 1) {
    iman.className = 'btn btn-success rounded-pill btn-lg';
    grab.className = 'btn btn-success rounded-pill btn-lg';
  } else {
    iman.className = 'btn btn-danger rounded-pill btn-lg';
    grab.className = 'btn btn-danger rounded-pill btn-lg';
  }
  posicion.innerHTML = '<h4>Posicion</h4><br> <div class="row d-flex align-items-center justify-content-around"><div class="' + (posicion_state == 1 ? 'ps' : 'p') + '"></div><div class="' + (posicion_state == 2 ? 'ps' : 'p') + '"></div><div class="' + (posicion_state == 3 ? 'ps' : 'p') + '"></div></div>';
  tamanno_disc.innerHTML = '<h4>Disco</h4><br> <div class="d-flex align-items-center justify-content-around"><div class="disco-' + tamanno_disc_state + '"></div></div>';
}

function up() {
  send_data('u');
}

function down() {
  send_data('d');
}

function left() {
  send_data('l');
}

function right() {
  send_data('r');
}

function graber() {
  send_data('deu');
}

function magnet() {
  send_data('e');
}

function send_data(data) {
  socket.emit('send_to_arduino', data);
}