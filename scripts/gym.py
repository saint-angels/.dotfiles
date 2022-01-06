#!/usr/bin/env python3

import csv
from argparse import ArgumentParser
from collections import defaultdict

parser = ArgumentParser()
parser.add_argument("file", help="exercieses csv")
parser.add_argument("date", help="date")
parser.add_argument("duration", help="duration, minutes")
args = parser.parse_args()

translation = {
    "Lat Pull-Downs": "тяга блока",
    "Dips": "брусья",
    "Bent-over Row": "тяга в наклоне",
    "Deadlift": "становая тяга",
    "Bench Press": "жим лежа",
    "Bar Squats": "приседания со штангой",
    "Standing Calf Raise": "подьем на носки в машине смита",
}

file=open(args.file, "r")
reader = csv.reader(file)
result = defaultdict(list)
for index, line in enumerate(reader):
    date = line[0]
    if index == 0 or date != args.date:
        continue
    name = line[2]
    reps = int(line[3])
    weight = float(line[4])
    result[name].append(weight)
# HACK: reps to 5
reps = 5
total_weight = 0
print("")
for key in result:
    translated_name = translation[key]
    exercise_sum = int(sum(result[key]) * reps)
    total_weight += exercise_sum
    print(f"\t{translated_name}: {result[key]}x{reps} = {exercise_sum}kg")

if float(args.duration) != 0:
    print(f"\tпродолжительность: {int(args.duration)}м.")
    intensity = int(total_weight / float(args.duration))
    print(f"\tинтенсивность: {intensity}\n")
