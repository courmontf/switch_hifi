#!/bin/bash
source venv/bin/activate
uvicorn switch_hifi:app --reload --host 0.0.0.0 --port 5000