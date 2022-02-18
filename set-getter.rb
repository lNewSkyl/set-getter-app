require 'sqlite3'
require 'sinatra'

class SetGetterApp < Sinatra::Base
  $bd = SQLite3::Database.new 'test.db'
  $bd.execute 'CREATE TABLE IF NOT EXISTS "tab_2"
  ( "id" INTEGER,
  "col_1" TEXT UNIQUE,
  "col_2" TEXT,
  PRIMARY KEY("id" AUTOINCREMENT)
  )'

  get '/get/:key' do
    $bd.execute('SELECT col_2 FROM tab_2 WHERE col_1=?', params[:key]).to_json
  end

  post '/set' do
    begin
      $bd.execute 'INSERT INTO tab_2(col_1,col_2) VALUES (?,?)', params.first[0], params.first[1] 
    rescue
      'Error! You entered not uniq data!'
    end
  end

end
