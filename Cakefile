{exec} = require 'child_process'

task 'test', 'test project', ->
    command = "mocha --watch --compilers coffee:coffee-script --require should --ui bdd"
    exec command, (err, stdout, stderr) ->
        throw err if err
        console.log stdout + stderr