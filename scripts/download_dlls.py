#!/usr/bin/env python
import logging
import os
import shutil
import sys
import zipfile
from pathlib import Path
from urllib.request import urlretrieve
from urllib.request import urlretrieve as download

logging.basicConfig(format="%(levelname)s - %(message)s",level=logging.DEBUG)

download_location = Path(r"D:/dll_files/")
if download_location.exists():
    logging.info("Download Location already exists clearing it...")
    shutil.rmtree(str(download_location))

os.makedirs(download_location)
download_file=download_location / "build.zip"
logging.info("Downloading Pango and Cairo Binaries for Windows...")
download(url="https://ci.appveyor.com/api/projects/naveen521kk/pango-cairo-build/artifacts/pango-cairo-build.zip?job=image:%20Visual%20Studio%202017",filename=download_file)
logging.info(f"Download complete. Saved to {download_file}.")
logging.info(f"Extracting {download_file}...")
with zipfile.ZipFile(download_file, mode="r", compression=zipfile.ZIP_DEFLATED) as file:
    file.extractall(download_location)
os.remove(download_file)
logging.info("Completed Extracting.")
logging.info("Moving Files.")

shutil.move(str(download_location / "build") , str(download_location))
