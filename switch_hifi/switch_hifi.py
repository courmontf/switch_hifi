import RPi.GPIO as GPIO
import time
from fastapi import FastAPI

DEFAULT_POSITION = 90
LEFT_PUSH_POSITION = 170
RIGHT_PUSH_POSITION = 10
PWM_GPIO = 12
FREQUENCY = 50


app = FastAPI()


def angle_to_percent (angle) :
    if angle > 180 or angle < 0 :
        return False

    start = 4
    end = 12.5
    ratio = (end - start)/180 

    angle_as_percent = angle * ratio

    return start + angle_as_percent



def push_to_position(angle):
    GPIO.setup(PWM_GPIO, GPIO.OUT)
    pwm = GPIO.PWM(PWM_GPIO, FREQUENCY)
    pwm.start(angle_to_percent(angle))
    time.sleep(0.12)
    pwm.ChangeDutyCycle(angle_to_percent(DEFAULT_POSITION))
    time.sleep(0.12)
    pwm.stop()


@app.get("/switchto/raspberry")
def switch_to_raspberry():
    push_to_position(RIGHT_PUSH_POSITION)
    return {"message": "Le servo-moteur est maintenant sur la position Raspberry"}


@app.get("/switchto/videoproj")
def switch_to_videoproj():
    push_to_position(LEFT_PUSH_POSITION)
    return {"message": "Le servo-moteur est maintenant sur la position Videoproj"}


@app.on_event("startup")
async def startup_event():
    GPIO.setmode(GPIO.BOARD)


if __name__ == "__main__":
    app.run(debug=True)