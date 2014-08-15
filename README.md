Pure-FTPd Interface
==================

Sinatra app to interface with the server using mysql as user backend.

### Features
- A view for reading your transfer logs
- A CRUD for ftp accounts

## Production
1. `bundle`
2. `cp .env.example .env`
3. Edit the `.env` to your hearts content
2. `bundle exec thin start`

### Development
1. `bundle`
2. `gem install rerun`
3. `rerun 'rackup'`
