#!/bin/sh

DEBUG_LEVEL=0

IN_FILE=$PROJ_PROFILE_DATA_LOC/demat-data/icicidirect/demat-data.csv
OUT_FILE_1=$PROJ_PROFILE_REPORTS_LOC/demat-reports/portfolio-phase-1.csv
OUT_FILE_2=$PROJ_PROFILE_REPORTS_LOC/demat-reports/portfolio-phase-2.csv
OUT_FILE_3=$PROJ_PROFILE_REPORTS_LOC/demat-reports/portfolio-phase-3.csv
OUT_FILE_4=$PROJ_PROFILE_REPORTS_LOC/demat-reports/portfolio-phase-4.csv

demat_invoke.py ${DEBUG_LEVEL} ${IN_FILE} ${OUT_FILE_1} ${OUT_FILE_2} ${OUT_FILE_3} ${OUT_FILE_4} 

OUT_FILE_QTR=$PROJ_PROFILE_REPORTS_LOC/demat-reports/stats_qtr_output.csv
OUT_FILE_YEAR=$PROJ_PROFILE_REPORTS_LOC/demat-reports/stats_year_output.csv
./demat_stats/icici_direct_stats.sh ${IN_FILE} all all year > ${OUT_FILE_YEAR}
./demat_stats/icici_direct_stats.sh ${IN_FILE} all all quarter > ${OUT_FILE_QTR}
