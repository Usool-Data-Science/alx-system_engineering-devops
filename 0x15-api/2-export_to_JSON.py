#!/usr/bin/python3
"""Exports result based on a specified user id"""
import json
import requests
from sys import argv

if __name__ == "__main__":
    usr_id = 2
    todos = requests.get(
        'https://jsonplaceholder.typicode.com/todos')
    if todos.status_code == 200:
        todo_result = todos.json()
        filtered = list(filter(lambda x: x['userId'] == usr_id,
                               todo_result))
        completed = list(filter(lambda x: x['completed'] is True, filtered))

    users = requests.get(
        'https://jsonplaceholder.typicode.com/users')
    if users.status_code == 200:
        users_result = users.json()
        user = list(filter(lambda x: x.get('id') == usr_id, users_result))
        name = user[0].get('name')

    final_dict = {}
    task_list = []

    for task in todo_result:
        task_list.append({"task": task['title'],
                          "completed": task['completed'],
                          "username": name})

    final_dict.update({str(usr_id): task_list})

    with open("{}.json".format(usr_id), 'w') as employee:
        json.dump(final_dict, employee)
