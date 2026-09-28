#!/usr/bin/env bash
#==============================================================================
# Nazwa skryptu: run_ztscep.sh
# Opis: Zarządca potoku ZT-SCEP (Zero-Trust Student Code Evaluation Pipeline)
#       uruchamiany w domenie dydaktycznej (np. work-academic).
# Autor: Przemysław Żarnecki <pzarnecki@protonmail.com>
# Instytucja: Akademia Techniczno-Informatyczna Nauk Stosowanych we Wrocławiu
#==============================================================================

set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Sposób użycia: $0 <archiwum_zadania> <identyfikator_studenta>" >&2
    exit 1
fi

SUBMISSION_ARCHIVE="$1"
STUDENT_ID="$2"
OUTPUT_REPORT="raport_${STUDENT_ID}.json"

if [ ! -f "${SUBMISSION_ARCHIVE}" ]; then
    echo "Błąd: Plik ${SUBMISSION_ARCHIVE} nie istnieje." >&2
    exit 2
fi

echo "[*] Inicjalizacja izolowanej domeny detonacyjnej (DispVM: tpl-eval-sandbox)..."

# Wywołanie procedury Qubes RPC ze strumieniowaniem archiwum na stdin
if qrexec-client-vm @dispvm:tpl-eval-sandbox \
    academic.EvaluateSubmission < "${SUBMISSION_ARCHIVE}" \
    > "${OUTPUT_REPORT}"; then
    echo "[+] Weryfikacja zakończona powodzeniem. Raport zapisano w: ${OUTPUT_REPORT}"
    exit 0
else
    EXIT_CODE=$?
    echo "[-] Wykryto błąd wykonania lub przekroczenie limitów zasobów (kod: ${EXIT_CODE})." >&2
    exit "${EXIT_CODE}"
fi
