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
    print('Employee {} is done with tasks({}/{}):'.format(
            name, len(completed), len(filtered)))

    for complete in completed:
        print("\t {}".format(complete.get("title")))
