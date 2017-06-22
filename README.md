# hba

This project implement a CRUD interface to manage the `pg_hba.conf` file to avoid any syntax error and get a easier way to check and maintain the rules.

# example output

Running `ruby bin/run.rb show -f sample_files/pg_hba.conf` in the command line, it shows:

```
+------+---------+----------+------+-------------+-----------------+--------+--------------+
| line | type    | database | user | ip addr     | mask            | auth   | comment      |
+------+---------+----------+------+-------------+-----------------+--------+--------------+
| 84   | local   | all      | all  | ~           | ~               | trust  | ~            |
| 86   | host    | all      | all  | 127.0.0.1   | 32              | trust  | ~            |
| 87   | hostssl | all      | all  | 127.0.0.1   | 255.255.255.255 | md5    | supercomment |
| 88   | hostssl | dbname   | seba | 192.168.0.0 | 24              | reject | supercomment |
| 90   | host    | all      | all  | ::1         | 128             | trust  | ~            |
+------+---------+----------+------+-------------+-----------------+--------+--------------+
```

## TODO List

 - [x] Split the UI and Parse responsibilities
 - [ ] Create a option to add a new rule
 - [ ] Create a option to modify a existing rule
 - [ ] Create a option to delete a existing rule
 - [ ] review tests and start to use rspec