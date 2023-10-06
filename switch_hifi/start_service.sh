#!/bin/bash
source venv/bin/activate
PYTHONPATH=/opt/switch_hifi/venv/lib/python3.9/site-packages python3 -m uvicorn switch_hifi:app --reload --host 0.0.0.0 --port 5000