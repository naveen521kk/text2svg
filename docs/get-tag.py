# -*- coding: utf-8 -*-
import os

ref = os.getenv("ref")
if ref.startswith("refs/heads/"):
    branch_name = ref[11:]
else:
    branch_name = ref[10:]
print(branch_name)
