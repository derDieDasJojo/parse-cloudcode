A simple git smart-http server using nginx as a frontend. With authentication, no SSL.

Usage:

```
docker run -d -p 80:80 --env GIT_USERNAME=git --env GIT_PASSWORD=git derdiedasjojo/parse-cloudcode

```

Work with your new Repository:

```
git clone http://localhost:80/git
```
