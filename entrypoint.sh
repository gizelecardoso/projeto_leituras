#!/bin/bash

rails db:migrate
rails server -b "0.0.0.0"
