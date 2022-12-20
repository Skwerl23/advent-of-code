import string
from collections import defaultdict

inputs = [x.strip() for x in open("C:\\Tools\\advent2022\\challenge12.txt").readlines()]

points = {}
graph = defaultdict(list)
start, starts, end = None, [], None
for y, line in enumerate(inputs):
    for x, letter in enumerate(line):
        point = complex(x, y)
#        print(point)
        if letter == "S":
            value = 0
            start = point
            starts.append(point)
        elif letter == "a":
            value = 0
            starts.append(point)
        elif letter == "E":
            value = 25
            end = point
        else:
            value = string.ascii_lowercase.index(letter)
        points[point] = value
#print([1 + 0j, -1 + 0j, 0 + 1j, 0 - 1j])
for point in points:
    for neighbor in [1 + 0j, -1 + 0j, 0 + 1j, 0 - 1j]:
        if (point + neighbor) in points:
            graph[point].append(point + neighbor)


def dijkstra(graph, source):
    Q = list(graph.keys())
    dist = {v: float("inf") for v in graph}
    dist[source] = 0
    
    while Q:
        u = min(Q, key=dist.get)
        Q.remove(u)
        for v in graph[u]:
            alt = dist[u] + 1
            if alt < dist[v] and points[u] - points[v] <= 1:
                dist[v] = alt

    return dist


paths = dijkstra(graph, end)
print(paths[start])
print(min(paths[s] for s in starts))