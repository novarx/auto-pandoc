import json


def fileprint(*vals):
    with open("/data/log.txt", "a") as f:
        for val in vals:
            val = json.dumps(val)
            f.write(val)
            f.write("\n")
        f.write("\n")
