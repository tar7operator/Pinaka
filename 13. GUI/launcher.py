#!/usr/bin/env python3


import os
import sys

from edvs import MainWindow
from PySide6.QtWidgets import QApplication

if __name__ == '__main__':
    # Fixes high dpi issues and scaling over 100
    os.environ["QT_FONT_DPI"] = "96" 
    
    # Start the application
    app = QApplication(sys.argv) 

    # Start the main window
    window = MainWindow() 

    # Start the event loop 
    sys.exit(app.exec())