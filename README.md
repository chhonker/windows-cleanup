# Windows Update Cleanup Script

This repository contains a simple batch script to help manage the Windows Update process by clearing cached files and temporarily pausing updates.

### What It Does

The script performs the following actions:
1.  **Stops Windows Update Services:** It temporarily stops the `wuauserv`, `bits`, and `cryptsvc` services, which are related to Windows Update.
2.  **Clears the Cache:** It deletes temporary and cached update files from the `SoftwareDistribution` and `catroot2` folders.
3.  **Pauses Updates:** It uses a PowerShell command to pause automatic Windows Updates for 28 days (4 weeks).
4.  **Keeps Services Stopped:** The script leaves the services in a stopped state. You will need to manually restart them or reboot your computer to resume normal update behavior.

### How to Use

1.  **Download the script:** Download the `cleanup_script.bat` file from this repository.
2.  **Run as Administrator:** Right-click the file and select **"Run as administrator."** This is **mandatory** for the script to have the necessary permissions to stop services and delete system files.
3.  **Follow the prompts:** The script will display a command-line interface with messages as it performs each step.
4.  **Press any key to exit:** Once the process is complete, the script will pause. Press any key to close the window.

### Important Disclaimers

* **Use at your own risk:** This script modifies system settings and files. While it is designed to be safe, it is provided without any warranty.
* **Administrator rights are required:** The script will not function correctly without being run with administrator privileges.
* **Consider a system restore point:** Before running any script that modifies your system, it is highly recommended to create a system restore point.

---

### Author & Project

* **Author:** Sumit Singh Chhonker
* **GitHub Repository:** https://github.com/chhonker