import dbus
import dbus.service
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
from dataclasses import dataclass
import threading
import time


@dataclass
class Notification:
    summary: str
    body: str
    app: str
    icon: str
    timeout: float


notifications = []


def remove_object(notif):
    time.sleep(notif.timeout)
    notifications.remove(notif)
    print_state()


def add_object(notif):
    notifications.insert(0, notif)
    print_state()
    timer_thread = threading.Thread(target=remove_object, args=(notif,))
    timer_thread.start()


def print_state():
    string = ""
    for item in notifications:
        string = string + create_eww_literals(item)

    string = string.replace('\n', ' ')
    print(f"""(box :orientation 'vertical' {string or ''})""", flush=True)

def create_eww_literals(item):
    if item.app == "critical":
        return f"""
             (button :class 'notify-send'
                   (box :orientation 'horizontal' :space-evenly false
                        (box :orientation 'vertical'
                            (label :text '{item.app}')
                            (label :width 100 :wrap true :text '{item.summary or ''}')
                            (label :width 100 :wrap true :text '{item.body or ''}')
                        )))"""
    else:
        return f"""
             (button :class 'notify-send'
                   (box :orientation 'horizontal' :space-evenly false
                        (box :orientation 'v'
                         (label :class 'header' :width 100 :wrap true :text '{item.summary or ''}')
                         (label :class 'body' :width 100 :wrap true :text '{item.body or ''}')
                        )))"""
#
#
class NotificationServer(dbus.service.Object):
    def __init__(self):
        bus_name = dbus.service.BusName('org.freedesktop.Notifications', bus=dbus.SessionBus())
        dbus.service.Object.__init__(self, bus_name, '/org/freedesktop/Notifications')

    @dbus.service.method('org.freedesktop.Notifications', in_signature='susssasa{ss}i',
                         out_signature='u')
    def Notify(self, app_name, replaces_id, icon, summary, body, actions, hints, timeout):
        add_object(Notification(
            summary,
            body,
            app_name,
            icon,
            float(timeout / 1000.0) if -1 else 5.0
        ))
        return 0

    @dbus.service.method('org.freedesktop.Notifications', out_signature='ssss')
    def GetServerInformation(self):
        return ("Custom Notification Server", "ExampleNS", "1.0", "1.2")


if __name__ == '__main__':
    DBusGMainLoop(set_as_default=True)
    server = NotificationServer()
    mainloop = GLib.MainLoop()
    mainloop.run()
