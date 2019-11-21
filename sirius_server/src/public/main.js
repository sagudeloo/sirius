const socket = io();
let towers = [];
let towerA = [];                          //P1
towerA.push(1);
towerA.push(2);
towerA.push(3);
towerA.push(4);
let towerB = [];                          //P2
let towerC = [];                          //P3
towers.push(towerA);
towers.push(towerB);
towers.push(towerC);
let currentPos;
let actionBuffer = [];

let posicion = document.getElementById('posicion');
let iman = document.getElementById('iman');
let grab = document.getElementById('grab');
let tamanno_disc = document.getElementById('tamanno_disc');
let torres = document.getElementById('towers');
socket.on('read_from_arduino', (data) => {
  if (Object.keys(data).length >= 3) {
    console.log(data);
    setState(data['posicion'], data['iman'], data['tamanno_disc']);
    currentPos = parseInt(data['posicion'], 10);
    if(data['confirmacion'] == 1 && actionBuffer.length > 0){
      actionExecuter();
    }
  }
});

setState();

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
  let tempTorres = '<div class="row align-items-end justify-content-around">';
  for (let tower of towers) {
    tempTorres += '<div class="col border border-primary rounded" style="min-height: 110px; max-width: 90px; padding: 0%; margin: 10px;display: flex;align-items: flex-end;"><div class="row align-items-end justify-content-center" style="padding: 0%;">';
    for (let disk of tower) {
      tempTorres += '<div class="col d-flex position-sticky align-items-center justify-content-center" style="margin-bottom: 5px; margin-top: 5px; padding-bottom: 3%; margin: 0 30%;"><div class="r' + disk + '"></div></div>';
    }
    if (tower.length == 1) {
      tempTorres += '<div class="col d-flex position-sticky align-items-center justify-content-center" style="margin-bottom: 5px; margin-top: 5px; padding-bottom: 3%; margin: 0 30%;"><div class="r6"></div></div>';
    }
    tempTorres += '</div></div>';
  }
  tempTorres += '</div>';
  torres.innerHTML = tempTorres;
}

/*
* n= number of disks.
* from, to, aux are the positions (towers).
* if more positions are needed, a list of positions must be implemented,
* where from,aux and to are selected from this list.
*/

let steps = []

//The aux position is set by the user.
function hanoi() {
  if (towers[0].length >= 1) {
    console.log(towers[0]);
    console.log(towerOfHanoi(4, 1, 3, 2));
    console.log(steps);
    console.log(towers[2]);
    runSteps();
    actionExecuter();
    setState();
  }
}

//This method fills a list with the steps required to solve the Hanoi Towers problem.
function towerOfHanoi(n, from, to, aux) {

  if (n <= 1) {
    steps.push({ 'nDisks': n, 'fromPosition': from, 'toPosition': to });
    return 1;
  }

  towerOfHanoi(n - 1, from, aux, to);
  steps.push({ 'nDisks': n, 'fromPosition': from, 'toPosition': to });
  towerOfHanoi(n - 1, aux, to, from);
}

function runSteps() {
  let posStep = currentPos;
  for (let step of steps) {
    towers[step['toPosition'] - 1].push(towers[step['fromPosition'] - 1].pop());
    actionInterpreter(step['fromPosition'],step['toPosition'], posStep);
    posStep = step['toPosition'];
  }
}

function actionInterpreter(from, to, currentPos) {
  movesToGrap = currentPos - from;
  movesToDrop = from - to;
  auxStr = '';
  if (from != to) { 
    console.log(currentPos,from,to);
    if(currentPos != from){
      if (movesToGrap > 0) {
        auxStr += 'l'.repeat(Math.abs(movesToGrap));
      } else {
        auxStr += 'r'.repeat(Math.abs(movesToGrap));
      }
    }
    auxStr += 'deu';
    if (movesToDrop > 0) {
      auxStr += 'l'.repeat(Math.abs(movesToDrop));
    } else {
      auxStr += 'r'.repeat(Math.abs(movesToDrop));
    }
    auxStr += 'deut';
    actionBuffer.push(auxStr);
  }
}

function actionExecuter(){
  send_data(actionBuffer.shift())
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

function graper() {
  send_data('deu');
}

function magnet() {
  send_data('e');
}

function send_data(data) {
  socket.emit('send_to_arduino', data);
}