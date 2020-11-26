# -*- coding: utf-8 -*-
import json
import os
import pathlib

import requests

headers = {"Authorization": f"token {os.getenv('GITHUB_TOKEN')}"}

branches = requests.get(
    "https://api.github.com/repos/naveen521kk/text2svg/branches",
    headers=headers,
)
branches = branches.json()

tags = requests.get(
    "https://api.github.com/repos/naveen521kk/text2svg/tags",
    headers=headers,
)
tags = tags.json()


folder = []
for p in (pathlib.Path(__file__).parent.parent.parent / "gh-pages").iterdir():
    if p.is_dir() and p.name not in [".git", "latest"]:
        folder.append(p.name)

expected = []
for i in branches:
    if i["name"] not in [
        "gh-pages",
        "main",
        "text2svg-v0.2.1",
        "text2svg-v0.2.0",
    ]:
        expected.append(i["name"])
for i in tags:
    if i["name"] not in ["0.0.1", "v0.1.0", "v0.2.0", "v0.2.1"]:
        expected.append(i["name"])
unwanted = []
for i in folder:
    if i not in expected:
        unwanted.append(i)
print(json.dumps(unwanted))
