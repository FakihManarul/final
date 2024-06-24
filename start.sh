set -eu

export PYTHONUNBUFFERED=true

VIRTUALENV=.data/venv

# Buat virtual environment jika belum ada
if [ ! -d "$VIRTUALENV" ]; then
  python3 -m venv "$VIRTUALENV"
fi

# Cek apakah python di dalam virtual environment sudah ada
if [ ! -f "$VIRTUALENV/bin/python3" ]; then
  echo "Virtual environment not created properly or missing interpreter."
  exit 1
fi

# Instal pip dalam virtual environment jika belum ada
if [ ! -f "$VIRTUALENV/bin/pip" ]; then
  echo "Downloading get-pip.py..."
  curl --silent --show-error --retry 5 https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  echo "Installing pip..."
  "$VIRTUALENV/bin/python3" get-pip.py
  rm get-pip.py
fi

# Instalasi dependencies dari requirements.txt
echo "Installing dependencies..."
"$VIRTUALENV/bin/pip" install -r requirements.txt

# Jalankan aplikasi
echo "Starting application..."
"$VIRTUALENV/bin/python3" app.py
Footer