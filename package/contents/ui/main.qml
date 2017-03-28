/***************************************************************************
 *   Copyright (C) %{CURRENT_YEAR} by %{AUTHOR} <%{EMAIL}>                            *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .        *
 ***************************************************************************/

import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtMultimedia 5.7
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "../js/pomodoro.js" as Logic

Item {
    id: root
    Plasmoid.title: "Pomodoro"
//     Plasmoid.onformFactorChanged: {
//         if (plasmoid.formFactor == PlasmaCore.Types.Horizontal) {
//         // My custom JavaScript handler code to react to a formfactor change
//     }
    Plasmoid.fullRepresentation: Text {
        text: "use it in the taskbar"
    }

    Plasmoid.compactRepresentation: RowLayout {
        anchors.fill: parent

        PlasmaComponents.Label {
            id: timerLabel
            font.pointSize: 14
            text: Logic.formatTimer(Logic.timer_total)
            function set() {
                timerLabel.text = Logic.formatTimer(Logic.timer_total);
            }
        }

        PlasmaComponents.Button {
            Layout.fillWidth: true
            Layout.minimumWidth: 25
            text: "25"
            onClicked: {
                pomodoroTimer.pomodoroStart(25*60);
                endDialogText.text = "You can rest for a while!"
            }
        }
        PlasmaComponents.Button {
            Layout.fillWidth: true
            Layout.minimumWidth: 25
            text: "5"
            onClicked: {
                pomodoroTimer.pomodoroStart(5*60);
                endDialogText.text = "Go back to Work!"
            }
        }
        PlasmaComponents.Button {
            Layout.fillWidth: true
            Layout.minimumWidth: 25
            text: "10"
            onClicked: {
                pomodoroTimer.pomodoroStart(10*60);
                endDialogText.text = "Go back to Work!"
            }
        }

        Timer {
            id: pomodoroTimer
            interval: 1000
            repeat: true
            running: false
            triggeredOnStart: false
            onTriggered: {
                Logic.timer_total -= 1;
                if (Logic.timer_total <= 0) {
                    endDialog.visible = true;
                    pomodoroTimer.stop();
                    playSound.play();
                }
                timerLabel.set();
            }
            function pomodoroStart(timeout) {
                Logic.timer_total = timeout;
                pomodoroTimer.start();
                timerLabel.set();
            }
        }
    }

    PlasmaCore.Dialog {
        id: endDialog
        visible: false
        mainItem: Item {
            width: 300
            height: 100
            ColumnLayout {
                anchors.fill: parent

                PlasmaComponents.Label {
                    id: endDialogText
                    font.pointSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    text: "You can rest for a while!"
                }

                PlasmaComponents.Button {
                    minimumWidth: 0
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    text: "OK"
                    onClicked: endDialog.visible = false;
                }
            }
        }
    }

    SoundEffect {
        id: playSound
        volume: 0.4
        source: "../audio/alert.wav"
    }
}
