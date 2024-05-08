#!/usr/bin/env python3
"""
Function to count occurrences of specified words in the titles of hot posts from a given Reddit subreddit.
"""
import requests


def count_word_occurrences(subreddit, words_to_count, after=None, counts={}):
    """
    Recursively fetches hot posts from Reddit API, analyzes their titles, and prints the count of specified words.
    """
    if not words_to_count or not subreddit:
        return

    url = f"https://www.reddit.com/r/{subreddit}/hot.json"
    headers = {"User-Agent": "Mozilla/5.0"}

    params = {"limit": 100}
    if after:
        params["after"] = after

    response = requests.get(url,
                            headers=headers,
                            params=params,
                            allow_redirects=False)

    if response.status_code != 200:
        return

    data = response.json()
    posts = data.get("data", {}).get("children", [])

    for post in posts:
        title = post.get("data", {}).get("title", "").lower()
        for word in words_to_count:
            if word.lower() in title:
                counts[word] = counts.get(word, 0) + title.count(word.lower())

    after = data.get("data", {}).get("after")
    if after:
        count_word_occurrences(subreddit, words_to_count, after, counts)
    else:
        sorted_counts = sorted(counts.items(), key=lambda x: (-x[1], x[0].lower()))
        for word, count in sorted_counts:
            print(f"{word.lower()}: {count}")