#!/usr/bin/python3
import json
import requests

if __name__ == "__main__":
    todos = requests.get(
        'https://jsonplaceholder.typicode.com/todos')
    if todos.status_code == 200:
        todo_result = todos.json()

    users = requests.get(
        'https://jsonplaceholder.typicode.com/users')
    if users.status_code == 200:
        users_result = users.json()

    final_dict = {}
    task_list = []

    for task in todo_result:
        id_ = task['userId']
        name_list = list(filter(lambda x: x['id'] == id_, users_result))
        name = name_list[0].get('username')
        task_list.append({"task": task['title'],
                          "completed": task['completed'],
                          "username": name})
        final_dict.update({str(id_): task_list})

    with open("todo_all_employees.json", 'w') as employee:
        json.dump(final_dict, employee)
