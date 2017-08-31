#!/usr/bin/env python

class City(object):
    def __init__(self, ident, x, y):
        self._id = ident
        self._x = x
        self._y = y

    def distance_to(self, other_city):
        x_squared = (self._x - other_city._x) ** 2
        y_squared = (self._y - other_city._y) ** 2
        return sqrt(x_squared + y_squared)

class Link(object):
    def __init__(self, city_1, city_2):
        self._pheremone = 0.0
        self._distance = city_1.distance_to(city_2)

class LinkKeeper(object):
    def __init__(self, city_list):
        n_cities = len(city_list)
        self._n_cities = n_cities
        self._link_list = [[None]*n_cities]*n_cities
        for city_1 in range(n_cities-1):
            for city_2 in range(city_1+1, n_cities):
                self._link_list[city_1][city_2] = Link(city_list[city_1], city_list[city_2])

    def get_link(self, city_1, city_2):
        if (city_1 < city_2):
            return self._link_list[city_1][city_2]
        return self._link_list[city_2][city_1]x

class AntJourney(object):
    def __init__(self, total_pheremone, city_list, start_city):
        self._total_pheremone = total_pheremone
        self._city_list = city_list
        self._start_city = start_city
        self._not_visited = [x for x in range(len(city_list)) if x != start_city]
        self._visited = []

    def run_journey(self):
        total_length = 0
