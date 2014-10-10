Pure-FTPd Interface
==================

Sinatra app to interface with the server using mysql as user backend.

### Features
- A view for reading your transfer logs
- A CRUD for ftp accounts

## Production setup
1. `bundle`
2. `cp .env.example .env`
3. Edit the `.env` to your hearts content

## Production start
Start the server by running (omit `-d` to start in foreground):
`bundle exec thin start -d -p 80`

## Production kill
Just kill it by running:
`ps aux | grep -m1 thin | awk '{print $2}' | xargs kill`

### Development
1. `bundle`
2. `gem install rerun`
3. `rerun 'rackup'`
