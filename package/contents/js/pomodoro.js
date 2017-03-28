"use strict";

var pomodoroTotal = 25*60; // seconds
var shortPauseTotal = 5*60; // seconds
var LongPauseTotal = 10*60; // seconds
var timer_total = 0;

function Timer() {
    return Qt.createQmlObject("import QtQuick 2.0; Timer {}", root);
}

var timer = new Timer();
timer.interval = 1000;
timer.repeat = true;
timer.triggered.connect(function () {
    print("I'm triggered once every second");
    timer_total -= 1;
});


function start(total) {
    timer_total = total;
    timer.start();
}

start(pomodoroTotal);

function getTimerTotal() {
    var total = timer_total;
    if (typeof total != "number")
        total = "ERROR"
    return total;
}

function formatTimer(time) {
    if (time < 0)
        return "00:00";
    var minutes = Math.floor(time / 60);
    var seconds = time % 60;

    if (seconds < 10)
        seconds = "0" + seconds;

    if (minutes < 10)
        minutes = "0" + minutes;

    return minutes + ":" + seconds;
}
