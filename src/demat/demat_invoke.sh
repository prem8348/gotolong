#!/bin/sh

DEBUG_LEVEL=1

CONFIG_PROFILE_DATA_LOC=`python -m config profile_data`
CONFIG_PROFILE_REPORTS_LOC=`python -m config profile_reports`

IN_FILE_TXN=$CONFIG_PROFILE_DATA_LOC/demat-data/icicidirect/demat-txn-data.csv
IN_FILE_SUMMARY=$CONFIG_PROFILE_DATA_LOC/demat-data/icicidirect/demat-summary-data.csv
OUT_FILE_1=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-txn-list-detailed.csv
OUT_FILE_2=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-txn-list-compressed.csv
OUT_FILE_3=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-txn-summary-reports-all.csv
OUT_FILE_4=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-txn-summary-reports-positive.csv
OUT_FILE_5=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-summary-ticker-only.csv

# -t for truncate the table
# python demat_invoke.py -t -d ${DEBUG_LEVEL} -i ${IN_FILE_TXN} ${IN_FILE_SUMMARY} -o ${OUT_FILE_1} ${OUT_FILE_2} ${OUT_FILE_3} ${OUT_FILE_4}  ${OUT_FILE_5}
python demat_invoke.py -d ${DEBUG_LEVEL} -i ${IN_FILE_TXN} ${IN_FILE_SUMMARY} -o ${OUT_FILE_1} ${OUT_FILE_2} ${OUT_FILE_3} ${OUT_FILE_4}  ${OUT_FILE_5}

# dump company names : why not tickers here
# dump ticker names from the ISIN instead
OUT_FILE_COMP_NAME=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/demat-names.txt
grep -v -e 'Company Name' -e ETF ${IN_FILE_SUMMARY} | sort | awk -F"," '{print $2}' > ${OUT_FILE_COMP_NAME}

# gather stats
OUT_FILE_YEAR=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/stats_year_output.csv
OUT_FILE_QTR=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/stats_qtr_output.csv

./demat_txn_stats/icici_direct_stats.sh ${IN_FILE} year_company all all year > ${OUT_FILE_YEAR}
./demat_txn_stats/icici_direct_stats.sh ${IN_FILE} year_company all all quarter > ${OUT_FILE_QTR}


OUT_FILE_PLOT=$CONFIG_PROFILE_REPORTS_LOC/demat-reports/stats_year_output.png
# draw plots

# demat_plot.py online ${OUT_FILE_YEAR}

#demat_plot.py offline ${OUT_FILE_YEAR} ${OUT_FILE_PLOT}
