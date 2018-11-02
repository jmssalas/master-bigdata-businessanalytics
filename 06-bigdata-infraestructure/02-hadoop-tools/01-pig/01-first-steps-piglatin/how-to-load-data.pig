/* Load Pink Floyd Discography using data types and not using data types */

disks = load 'pinkfloyd-discography' using PigStorage(',') as (year, disk, usa, uk);
describe disks;
illustrate disks;

disks2 = load 'pinkfloyd-discography' using PigStorage(',') as (year:int, disk:chararray, usa:int, uk:int);
describe disks2;
illustrate disks2;