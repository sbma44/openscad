import time, serial, sys

ser = serial.Serial('/dev/ttyACM0', 115200)
while True:
    line = ser.readline().decode('ascii').strip()
    print(str(int(time.time())) + ',' + line)
    sys.stdout.flush()
