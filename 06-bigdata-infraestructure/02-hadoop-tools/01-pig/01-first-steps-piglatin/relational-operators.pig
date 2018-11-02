/*** Relational Operators ***/

-- CROSS OPERATOR
cross1 = load 'cross1';
dump cross1;

cross2 = load 'cross2';
dump cross2;

cartesiano = cross cross1, cross2;
dump cartesiano;


-- DISTINCT OPERATOR
duplicated = load 'duplicated';
dump duplicated;
no_duplicated = distinct duplicated;
dump no_duplicated;


-- FILTER OPERATOR
data = load 'filter' as (c1:int, c2:int, c3:int);
describe data;
dump data;

result = filter data by c3 == 3;
dump result;

result2 = filter data by (c1 == 8) or (not (c2 + c3 > c1));
dump result2;


-- GROUP OPERATOR
students = load 'group' using PigStorage(',') as (name:chararray, age:int);
describe students;
dump students;

age = group students by age;
describe age;
dump age;
illustrate age;


-- FOREACH OPERATOR
ex_foreach = foreach age generate group, COUNT(students);
dump ex_foreach;

ex2_foreach = foreach age generate $0, $1.name;
dump ex2_foreach;


-- JOIN OPERATOR
data1 = load 'cross1' as (c1:int, c2:int, c3:int);
data2 = load 'cross2' as (c1:int, c2:int);
dump data1;
dump data2;

result = join data1 by c1, data2 by c1;
dump result;


-- LIMIT OPERATOR
data = load 'filter';
dump data;

result = limit data 3;
dump result;


-- ORDER BY OPERATOR
a = load 'duplicated' using PigStorage(',') as (col1:int, col2:int, col3:int);
describe a;

x = order a by col1 desc;
dump x;


-- SAMPLE OPERATOR
a = load 'duplicated' using PigStorage(',') as (col1:int, col2:int, col3:int);

twenty_percent = sample a 0.2;
dump twenty_percent;


-- SPLIT OPERATOR
a = load 'duplicated' using PigStorage(',') as (col1:int, col2:int, col3:int);

split a into x if col1>7, y if col2==2, z if (col3<4 or col3>4);
dump x;
dump y;
dump z;


-- STORE OPERATOR
a = load 'duplicated' using PigStorage(',') as (col1:int, col2:int, col3:int);

store a into 'change_separator' using PigStorage('*');
cat change_separator;

b = foreach a generate CONCAT('col1:', (chararray)col1), CONCAT('col2:', (chararray)col2), CONCAT('col3:',(chararray)col3);

store b into 'columns' using PigStorage(',');
cat columns;


-- UNION OPERATOR
a = load 'cross1' as (a1:int, a2:int, a3:int);
b = load 'cross2' as (b1:int, b2:int);

dump a;
dump b;

result = union a,b;
dump result;