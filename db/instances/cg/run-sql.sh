#!/usr/bin/env bash
psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_cg < $1