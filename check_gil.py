import sys
import sysconfig

print(f"Version of python: {sys.version}")

active = sysconfig.get_config_vars().get("Py_GIL_DISABLED")

if active is None:
    print("GIL cannot be disabled")

if active == 0:
    print("GIL is active")

if active == 1:
    print("GIL is disabled")
