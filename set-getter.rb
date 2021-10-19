require 'sqlite3'
require 'sinatra'

$bd = SQLite3::Database.new 'test.db'
$bd.execute 'CREATE TABLE IF NOT EXISTS "tab_2"
( "id" INTEGER,
"col_1" TEXT,
"col_2" TEXT,
PRIMARY KEY("id" AUTOINCREMENT)
)'

get '/get' do
  $bd.execute('SELECT col_2 FROM tab_2 WHERE col_1=?', params[:key])
end

post '/set' do
  $bd.execute 'INSERT INTO tab_2(col_1,col_2) VALUES (?,?)', params[:key], params[:value]
end
